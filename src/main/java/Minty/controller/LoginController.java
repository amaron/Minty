package Minty.controller;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 24/7/12
 * Time: 8:38 PM
 * To change this template use File | Settings | File Templates.
 */

import Minty.model.User;
import Minty.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.logging.Logger;


@Controller
public class LoginController {
    private final UserService userService;
    private final Logger logger;
    @Autowired
    public LoginController( UserService userService, Logger logger) {

        this.userService=userService;
        this.logger= logger;
    }

    @RequestMapping("/")
    public ModelAndView index() {

            return new ModelAndView("index");

    }

    @RequestMapping("/index")
    public ModelAndView indexHome() {

            return new ModelAndView("index");

    }

    @RequestMapping(value = "/user/login", method = RequestMethod.GET)
    public ModelAndView loginForm() {

            return new ModelAndView("login");
    }

    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public ModelAndView login(User user, HttpSession session) {

        ModelAndView mv = new ModelAndView("login");
        int userID;
        User userData = userService.getUser(user.getUsername());

        if(userData==null){
            mv.addObject("message"," provided username/email id " + user.getUsername() +" does not exist, please register");
            return mv;
        }

        if (!userData.equals(null) && !userData.getUser_password().equals(user.getUser_password())) {
            mv.addObject("message", "Invalid password");
            return mv;
        }
        userID =  userData.getUser_id();


        logger.info("user "+ user.getUsername() + "logged in successfully");

        session.setAttribute("userName", user.getUsername());
        session.setAttribute("userID", (long)userID);
        mv.setViewName("redirect:/home");
        return mv;
    }


    @RequestMapping(value = "/user/logout")
    public String logout(HttpSession Session) {

        logger.info("user "+ (String)Session.getAttribute("userName") + " logged out successfully");
        Session.invalidate();
        return "redirect:/user/login";
    }
}