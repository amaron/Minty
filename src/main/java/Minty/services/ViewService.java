package Minty.services;

import Minty.model.DBAccessHelper;
import Minty.model.TweetData;
import Minty.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ViewService {
    private final ThreadLocal<Long> userID;
    public DBAccessHelper db;

    @Autowired
    public ViewService(@Qualifier("userID") ThreadLocal<Long> userID, DBAccessHelper db) {
        this.userID = userID;
        this.db = db;
    }
    
    public Long getUserId(String handle){
        Long l=null;
        try{
        l=  db.queryForLong("SELECT user_id FROM users WHERE username=? ",handle);
        }catch(Exception e){
            return l;
        }
        return l;

    }

    public String addToMentions(String[] u_list, int tweet_id)
    {
        if(u_list==null)return null;
        int i;
        Integer count=0;
        for(i=0;i<u_list.length;i++){
            String handle=u_list[i].substring(1);
            Long user_id=getUserId(handle);
            if(user_id==null)continue;
            else{
                System.out.println(handle);
                db.update("insert INTO mentions values(?,?)", user_id, tweet_id);
                count++;
            }
        }
        return count.toString();
    }

    public List<User> searchUsers(String string, int offset, int limit){
        return db.query("SELECT * FROM USERS WHERE username like ? ORDER by username DESC offset ? limit ?" ,User.rowMapper,"%"+string+"%", offset, limit);
    }

    public List<TweetData> searchTweets(String string, int offset, int limit){
        return db.query("SELECT * FROM TWEETS WHERE tweet like ? ORDER by tweet_id DESC offset ? limit ?",TweetData.rowMapper,"%"+string+"%",offset,limit);
    }

    public List<TweetData> listUserMentions(String handle, int offset, int limit) {
        return db.query("SELECT * FROM TWEETS WHERE tweet_id in (SELECT mentions.tweet_id FROM mentions WHERE mentions.user_id=?) ORDER by tweet_id DESC offset ? limit ?",TweetData.rowMapper,(long)getUserId(handle),offset,limit);

    }

    public List<User> getFollowers(String handle){
     Long id=getUserId(handle);
     return db.query("SELECT * FROM users WHERE user_id in (SELECT following.user_id FROM following WHERE following_id=? and following.user_id!=?)",User.rowMapper,id,id);
    }

    public List<User> getFollowing(String handle){
        Long id=getUserId(handle);
        return db.query("SELECT * FROM users WHERE user_id in (SELECT following_id FROM following WHERE following.user_id=? and following.following_id!=?)",User.rowMapper,id,id);
    }

    public boolean isFollowing(long user_id, String handle){

      Long user_id_handle=getUserId(handle);
        System.out.println("userid through .get"+ userID.get() + "passed userid"+ user_id + "handle id is"+ user_id_handle);
        try{
         db.queryForMap("SELECT * FROM following WHERE user_id = ? and following_id= ?",user_id,user_id_handle);
         return true;
        }catch(Exception e){return false;}


    }

    public boolean isUserExists(String handle){

        Integer is_user_exists=db.queryForInt("SELECT count(*) FROM users WHERE username=?",handle);
        if(is_user_exists==0)return false;
        return true;
    }

    public void followUser(Long own_id, String handle){

        Long user_id=getUserId(handle);
        System.out.println("is following >"+ handle + isFollowing(own_id,handle));
        if(own_id==user_id)   return;
        if(isFollowing(own_id,handle)){unfollowUser(user_id);return;}
        System.out.println("is following after action should be 0>"+ handle + isFollowing(own_id,handle));
        db.update("INSERT INTO following values(?,?);" +
                  "UPDATE users SET num_following=num_following+1 WHERE user_id=?;" +
                "UPDATE users SET num_followers=num_followers+1 WHERE user_id=?;",own_id, user_id,own_id,user_id);
        
    }

    public List<User> getPopularUsers(){
        return db.query("SELECT * from Users order by num_tweets desc offset 0 limit 5",User.rowMapper);
    }

    public void unfollowUser(Long following_user_id){
        
        db.update("DELETE FROM following WHERE user_id=? and following_id=?;" +
                "UPDATE users SET num_following=num_following-1 WHERE user_id=?;" +
                "UPDATE users SET num_followers=num_followers-1 WHERE user_id=?;",
                userID.get(), following_user_id, userID.get(),following_user_id);
        
    }

    public List<TweetData> listUserFeed(String handle, int offset, int limit) {
        Long id=getUserId(handle);
        return db.query("SELECT * FROM tweets WHERE tweet_id in (SELECT tweet_id FROM USERFEED WHERE user_id=?)  ORDER by tweet_id DESC limit ? offset ?",
                TweetData.rowMapper,id,limit,offset);

    }

    public List<TweetData> listUserTweets(String handle, int offset, int limit) {

        return db.query("SELECT * FROM tweets WHERE username=? ORDER by tweet_id DESC offset ? limit ?",
                TweetData.rowMapper,handle,offset, limit
        );
    }


}
