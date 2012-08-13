package Minty.services;

import Minty.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * Created with IntelliJ IDEA.
 * User: gauravmunjal
 * Date: 25/7/12
 * Time: 5:18 PM
 * To change this template use File | Settings | File Templates.
 */
@Service
public class UserService {
    public JdbcTemplate db;

    @Autowired
    public UserService(JdbcTemplate db) {
        this.db = db;
    }

    public int updateUser(User user, String username) {
        return db.update("UPDATE USERS SET bio=?, website=?, place=?  where username=?", user.getBio(), user.getWebsite(), user.getPlace(), username);

    }

    public int addUser(User user) {
        return db.queryForInt("INSERT INTO USERS ( realname, email, username, user_password) values(?,?,?,?) RETURNING user_id", user.getRealname(), user.getEmail(), user.getUsername(), user.getUser_password());

    }

    public void addFollowing(long user_id, long following_id){
        db.update("INSERT INTO FOLLOWING values(?,?)",user_id, following_id);
   }

    public User getUser(String handle) {
        User user = null;
        try {
            user = db.queryForObject("SELECT * FROM USERS where username=? ", User.rowMapper, handle);
        }
        catch (EmptyResultDataAccessException e) {
            return user;
        }
        return (user);
    }

    public User emailExists(String email){
        User user = null;
        try {
            user = db.queryForObject("SELECT * FROM USERS where email=? ", User.rowMapper, email);
        }
        catch (EmptyResultDataAccessException e) {
            return user;
        }
        return (user);
    }
}
