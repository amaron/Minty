package TwitMini.services;

import TwitMini.model.TweetData;
import TwitMini.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ViewService {
    private final ThreadLocal<Long> userID;
    public JdbcTemplate db;

    @Autowired
    public ViewService(@Qualifier("userID") ThreadLocal<Long> userID, JdbcTemplate template) {
        this.userID = userID;
        db = template;
    }
    public Long getUserId(String handle){
        Long l=  db.queryForLong("select user_id from users where username=? ",handle);
        //System.out.println("User details "+handle+l);
        return l;

    }

    public List<User> searchUsers(String string){
        return db.query("select * from USERS where username like ?",User.rowMapper,"%"+string+"%");
    }

    public List<TweetData> searchTweets(String string){
        return db.query("select * from TWEETS where tweet like ?",TweetData.rowMapper,"%"+string+"%");
    }

    public List<Map<String,Object>> getFollowers(String handle){
     Long id=getUserId(handle);
     return db.queryForList("select username from users where user_id in (select following.user_id from following where following_id=? and following.user_id!=?)",id,id);
    }

    public List<Map<String,Object>> getFollowing(String handle){
        Long id=getUserId(handle);
        return db.queryForList("select username from users where user_id in (select following_id from following where following.user_id=? and following.following_id!=?)",id,id);
    }


    public boolean isFollowing(String handle){

        Long l=getUserId(handle);
      Integer l1=db.queryForInt("select count(*) from following where user_id =? and following_id=?",userID.get(),l);
        System.out.println("is following? "+l1);
        if(l1==0)return false;
        return true;
    }

    public boolean isUserExists(String handle){

        Integer l=db.queryForInt("select count(*) from users where username=?",handle);
        if(l==0)return false;
        return true;
    }

    public boolean isUserHimself(Long id){
        return id.equals(userID.get());
    }
    public void followUser(String handle){

        Long l=getUserId(handle);
        if(userID.get()==l)   return;
        if(isFollowing(handle)){unfollowUser(l);return;}
/*
        db.update("insert into following values(?,?)",userID.get(), l);
        db.update("update users set num_following=num_following+1 where user_id=?",userID.get());
        db.update("update users set num_followers=num_followers+1 where user_id=?",l);
*/
        db.update("insert into following values(?,?);" +
                  "update users set num_following=num_following+1 where user_id=?;" +
                "update users set num_followers=num_followers+1 where user_id=?;",userID.get(), l,userID.get(),l);
        System.out.println("following user "+handle);

    }

    public void unfollowUser(Long l){
        System.out.println("unfollowing userid " +l);
        db.update("delete from following where user_id=? and following_id=? ",userID.get(), l);
        db.update("update users set num_following=num_following-1 where user_id=?",userID.get());
        db.update("update users set num_followers=num_followers-1 where user_id=?",l);
    }

    public List<TweetData> listFollowingTweets(String handle) {
        Long l=getUserId(handle);
        return db.query("select * from tweets where tweets.tweet_id in (select USERFEED.tweet_id from USERFEED where USERFEED.user_id=?) order by tweets.tweet_id desc",
                TweetData.rowMapper,l
        );
    }

    public List<TweetData> listUserTweets(String handle) {

        return db.query("select * from tweets where username=? order by tweet_id desc",
                TweetData.rowMapper,handle
        );
    }


}
