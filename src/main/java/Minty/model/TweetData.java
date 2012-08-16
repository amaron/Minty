package Minty.model;

import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created with IntelliJ IDEA.
 * User: karthik
 * Date: 25/7/12
 * Time: 3:29 PM
 * To change this template use File | Settings | File Templates.
 */
public class TweetData {

    private String tweet;
    private int tweet_id;
    private String username ="";
    private int user_id;
    private String pushtime ="";



    public static final RowMapper<TweetData> rowMapper = new RowMapper<TweetData>() {
        @Override public TweetData mapRow(ResultSet resultSet, int i) throws SQLException {
            return new TweetData(resultSet);
        }
    };

    public TweetData(ResultSet rs) throws SQLException {
        tweet_id = (Integer)rs.getObject("tweet_id");
        tweet = rs.getString("tweet");
        username = rs.getString("username");
        user_id=rs.getInt("user_id");
        pushtime =rs.getString("pushtime");

    }

    public TweetData(){};

    public String getTweet() {
        return tweet;
    }

    public void setTweet(String tweet) {
        this.tweet = tweet;
    }

    public int getTweet_id() {
        return tweet_id;
    }

    public void setTweet_id(int tweet_id) {
        this.tweet_id = tweet_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getPushtime() {
        return pushtime;
    }

    public void setPushtime(String pushtime) {
        this.pushtime = pushtime;
    }
}
