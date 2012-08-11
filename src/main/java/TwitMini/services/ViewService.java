package TwitMini.services;

import TwitMini.model.TweetData;
import TwitMini.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

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

    public List<User> searchUsers(String string, int offset, int limit){
        return db.query("select * from USERS where username like ? order by username desc offset ? limit ?",User.rowMapper,"%"+string+"%", offset, limit);
    }

    public List<TweetData> searchTweets(String string, int offset, int limit){
        return db.query("select * from TWEETS where tweet like ? order by tweet_id desc offset ? limit ?",TweetData.rowMapper,"%"+string+"%",offset,limit);
    }

    public List<TweetData> listUserMentions(String handle, int offset, int limit) {
        return db.query("select * from TWEETS where tweet like ? order by tweet_id desc offset ? limit ?",TweetData.rowMapper,"%@"+handle+"%",offset,limit);

    }

    public List<User> getFollowers(String handle){
     Long id=getUserId(handle);
     return db.query("select * from users where user_id in (select following.user_id from following where following_id=? and following.user_id!=?)",User.rowMapper,id,id);
    }

    public List<User> getFollowing(String handle){
        Long id=getUserId(handle);
        return db.query("select * from users where user_id in (select following_id from following where following.user_id=? and following.following_id!=?)",User.rowMapper,id,id);
    }


    public boolean isFollowing(long user_id, String handle){

      Long user_id_handle=getUserId(handle);
      Integer l1=db.queryForInt("select count(*) from following where user_id =? and following_id=?",user_id,user_id_handle);
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
        if(isFollowing(userID.get(),handle)){unfollowUser(l);return;}
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

    public List<TweetData> listUserFeed(String handle, int offset, int limit) {
        Long id=getUserId(handle);
        return db.query("select * from tweets where tweet_id in (select tweet_id from USERFEED where user_id=?)  order by tweet_id desc limit ? offset ?",
                TweetData.rowMapper,id,limit,offset);

    }

    public List<TweetData> listUserTweets(String handle, int offset, int limit) {

        return db.query("select * from tweets where username=? order by tweet_id desc offset ? limit ?",
                TweetData.rowMapper,handle,offset, limit
        );
    }


}
