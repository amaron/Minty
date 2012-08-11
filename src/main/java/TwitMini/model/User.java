package TwitMini.model;

import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created with IntelliJ IDEA.
 * User: gauravmunjal
 * Date: 25/7/12
 * Time: 4:50 PM
 * To change this template use File | Settings | File Templates.
 */
public class User {
    private String realname;
    private String email;
    private String username;
    private String user_password;
    private int user_id;
    private String bio;
    private String place;
    private String website;
    private int num_followers;
    private int num_tweets;
    private int num_following;

    public static final RowMapper<User> rowMapper = new RowMapper<User>() {
        @Override public User mapRow(ResultSet resultSet, int i) throws SQLException {
            return new User(resultSet);
        }
    };

    public User() {

    }
    public User(ResultSet resultSet) throws SQLException {
        realname = resultSet.getString("realname");
        email = resultSet.getString("email");
        username = resultSet.getString("username");
        user_id=resultSet.getInt("user_id");
        user_password =resultSet.getString("user_password");
        num_followers=resultSet.getInt("num_followers");
        num_tweets=resultSet.getInt("num_tweets");
        num_following=resultSet.getInt("num_following");
        bio=resultSet.getString("bio");
        website=resultSet.getString("website");
        place=resultSet.getString("place");

    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUser_password() {
        return user_password;
    }

    public void setUser_password(String user_password) {
        this.user_password = user_password;
    }


    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }



    public int getNum_following() {
        return num_following;
    }

    public void setNum_following(int num_following) {
        this.num_following = num_following;
    }

    public int getNum_tweets() {
        return num_tweets;
    }

    public void setNum_tweets(int num_tweets) {
        this.num_tweets = num_tweets;
    }

    public int getNum_followers() {
        return num_followers;
    }

    public void setNum_followers(int num_followers) {
        this.num_followers = num_followers;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
}