package TwitMini.services;

import org.springframework.jdbc.core.JdbcTemplate;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 8/8/12
 * Time: 3:16 PM
 * To change this template use File | Settings | File Templates.
 */
public class FeedUpdater extends Thread {


    private int id;
    private long user_id;
    JdbcTemplate db;
    public FeedUpdater(int id, long user_id, JdbcTemplate db){
        this.id=id;
        this.user_id=user_id;
        this.db=db;
    }

    @Override
    public void run(){

        db.update("insert into USERFEED (select following.user_id, tweet_id from following, tweets where following_id=? and tweet_id=?)",user_id,id);
    }
}
