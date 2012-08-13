package Minty.services;

import Minty.model.TweetData;
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

    public List<TweetData> getTweet(int tweet_id){
        return db.query("select * from tweets where tweet_id=?",TweetData.rowMapper,tweet_id);
    }

    public List<TweetData> listAllTweets(int offset, int limit){
        return db.query("select * from tweets order by tweet_id desc limit ? offset ?",TweetData.rowMapper, limit, offset);
    }

    public List<TweetData> getNewTweets(Integer curmax_tweet_homepage, Integer curmax_tweet_db, Long user_id) {
     System.out.println("cur and curmax" + curmax_tweet_homepage + " " + curmax_tweet_homepage);
        return db.query("select * from tweets where tweets.tweet_id in ( select tweet_id from USERFEED where USERFEED.user_id= ? and USERFEED.tweet_id > ? and USERFEED.tweet_id <= ? and USERFEED.tweet_id not in (select tweet_id from tweets where user_id=? and tweet_id>?)) order by tweet_id asc",
                TweetData.rowMapper,user_id,curmax_tweet_homepage,curmax_tweet_homepage,user_id,curmax_tweet_homepage
        );
    }

    public List<TweetData> listOwnTweets(Long user_id) {
        return db.query("select * from tweets where user_id=? order by tweet_id asc",
                TweetData.rowMapper,user_id
                );
    }

    public Integer getLatestTweetId(Long user_id, int curmax_tweet_homepage){

        return db.queryForInt("select max(tempMax.tweet_id) as maxval from (select tweet_id from USERFEED where user_id=? and USERFEED.tweet_id not in (select tweet_id from tweets where user_id=? and tweet_id>?)) AS tempMax",user_id,user_id,curmax_tweet_homepage);
    }

    public void addUserFeed(Integer tweet_id, Long user_id){
       FeedUpdater  feedUpdater= new FeedUpdater(tweet_id,user_id,db);
        feedUpdater.start();
        return;
    }

    public TweetData add(TweetData tweet, String username, Long user_id) {

        System.out.println("user id in tweet add method is, " + userID.get() + "at location " + userID);
        int tweet_id=db.queryForInt("insert into tweets (user_id, tweet, username) values(?,?,?) returning tweet_id", user_id, tweet.getTweet(),username);

        addUserFeed(tweet_id, user_id);

        db.update("update users set num_tweets=num_tweets+1 where user_id=?;",user_id);

        return db.queryForObject("select * from tweets where tweet_id=?",
                TweetData.rowMapper,
                tweet_id);
    }



}
