package Minty.services;

import Minty.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 6/8/12
 * Time: 2:05 PM
 * To change this template use File | Settings | File Templates.
 */
@Service
public class ValidatorService {

    private final ThreadLocal<Long> userID;
    private final UserService userService;
    public JdbcTemplate db;

    @Autowired
    public ValidatorService(@Qualifier("userID") ThreadLocal<Long> userID, JdbcTemplate template, UserService userService) {
        this.userID = userID;
        db = template;
        this.userService=userService;
    }

    public String checkUsername(String username)
    {
           if(username==null || username=="") return "username can not be empty";
           User user= userService.getUser(username);
           if(user==null)return "success";
           else  return "username already exists";
    }

    public String checkPassword(String password){
        if(password.length()<6 || password.length() > 15) return "password must be between 6 and 15 characters";
        else return "success";
    }

    public String checkEmail(String email) throws InterruptedException {

        if(email==null || email=="")return "email can not be empty";
        EmailValidator EV=new EmailValidator();
        if (EV.validate(email)==false)return "email entered is not valid";
        else{
            User user=userService.emailExists(email);
            if(user==null)return "success";
            else return "entered emailid already registered with some other username, please enter new emailid";
        }

    }

}
