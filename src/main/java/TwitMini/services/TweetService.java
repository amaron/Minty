package TwitMini.services;

import TwitMini.model.TweetData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TweetService {
    private final ThreadLocal<Long> userID;
    public JdbcTemplate db;

    @Autowired
    public TweetService(@Qualifier("userID") ThreadLocal<Long> userID, JdbcTemplate template) {
        this.userID = userID;
        System.out.println("from @service tweetStore, userID," + this.userID);
        db = template;
    }



    public List<TweetData> listHomePageTweets(int limit, int offset, Long id) {
        return db.query("select * from tweets where tweet_id in (select tweet_id from USERFEED where user_id=?)  order by tweet_id desc limit ? offset ?",
                TweetData.rowMapper,id,limit,offset
        );
    }

    public List<TweetData> getTweet(int id){
        return db.query("select * from tweets where tweet_id=?",TweetData.rowMapper,id);
    }

    public List<TweetData> listAllTweets(int offset, int limit){
        return db.query("select * from tweets order by tweet_id desc limit ? offset ?",TweetData.rowMapper, limit, offset);
    }



    public List<TweetData> getNewTweets(Integer cur, Integer curmax, Long id) {
     System.out.println("cur and curmax" + cur + " " + curmax);
        return db.query("select * from tweets where tweets.tweet_id in ( select tweet_id from USERFEED where USERFEED.user_id= ? and USERFEED.tweet_id > ? and USERFEED.tweet_id <= ? and USERFEED.tweet_id not in (select tweet_id from tweets where user_id=? and tweet_id>?)) order by tweet_id asc",
                TweetData.rowMapper,id,cur,curmax,id,cur
        );
    }

    public List<TweetData> listOwnTweets(Long user_id) {
        return db.query("select * from tweets where user_id=? order by tweet_id asc",
                TweetData.rowMapper,user_id
                );
    }

    public Integer getLatestTweetId(Long id, int cur){

        System.out.println(db.queryForInt("select max(tempMax.tweet_id) as maxval from (select tweet_id from USERFEED where user_id=?) AS tempMax",id));
        return db.queryForInt("select max(tempMax.tweet_id) as maxval from (select tweet_id from USERFEED where user_id=? and USERFEED.tweet_id not in (select tweet_id from tweets where user_id=? and tweet_id>?)) AS tempMax",id,id,cur);
    }

    public void addUserFeed(Integer id, Long user_id){
       FeedUpdater  feedUpdater= new FeedUpdater(id,user_id,db);
        feedUpdater.start();
        return;
    }

    public TweetData add(TweetData tweet, String username, Long user_id) {

        System.out.println("user id in tweet add method is, " + userID.get() + "at location " + userID);
        int id=db.queryForInt("insert into tweets (user_id, tweet, username) values(?,?,?) returning tweet_id", user_id, tweet.getTweet(),username);

        //spawning a background process to handle userfeed

        addUserFeed(id, user_id);

        db.update("update users set num_tweets=num_tweets+1 where user_id=?;",user_id);

        return db.queryForObject("select * from tweets where tweet_id=?",
                TweetData.rowMapper,
                id);
    }



}
