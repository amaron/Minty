package TwitMini.controller;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 24/7/12
 * Time: 8:38 PM
 * To change this template use File | Settings | File Templates.
 */

import TwitMini.model.User;
import TwitMini.services.EmailValidator;
import TwitMini.services.UserService;
import TwitMini.services.ValidatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Hashtable;


@Controller
public class SignupController {
    public final JdbcTemplate db;
    public final UserService userService;
    private final ValidatorService validatorService;
    @Autowired
    public SignupController(JdbcTemplate db, UserService userService, ValidatorService validatorService) {
        this.db = db;
        this.userService=userService;
        this.validatorService=validatorService;
    }


    @RequestMapping(value = "/user/register", method = RequestMethod.GET)
    public ModelAndView RegistrationForm(HttpSession Session) {
        String userName = (String) Session.getAttribute("userName");
        if(userName==null)
        return new ModelAndView("register");  // will change it to specific register page with only register
        else return new ModelAndView("redirect:/home");
    }

    @RequestMapping(value = "/user/register/usrchk/{username}.json", method = RequestMethod.POST)
    @ResponseBody
    public Hashtable validateUsername(@PathVariable String username) {
               Hashtable h= new Hashtable();
               h.put("msg",validatorService.checkUsername(username));
        return h;
    }


    @RequestMapping(value = "/user/register/emlchk/{email}.json", method = RequestMethod.POST)
    @ResponseBody
    public Hashtable validateEmail(@PathVariable String email) throws InterruptedException {
        Hashtable h= new Hashtable();
        try {
            h.put("msg",validatorService.checkEmail(email));
        } catch (InterruptedException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return h;
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public ModelAndView register(User user,
                                 HttpSession session) {

        EmailValidator EV= new EmailValidator();

        ModelAndView mv = new ModelAndView("register");
        long userID;

        User userData = userService.getUser(user.getUsername());
        if(userData!=null){
            mv.addObject("message"," username/email id already in use, please re-enter");
            return mv;
        }

        else{
            if(EV.validate(user.getEmail())==false){
                mv.addObject("message", "Enter proper Email address");
                return mv;

            }
        }

        userID=(long)userService.addUser(user);
        userService.addFollowing(userID,userID);
        session.setAttribute("userName", user.getUsername());
        session.setAttribute("userID", userID);
        mv.setViewName("redirect:/home");

        return mv;


    }

}