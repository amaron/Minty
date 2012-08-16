package Minty.controller;

/**
 * Created with IntelliJ IDEA.
 * User: karthik
 * Date: 24/7/12
 * Time: 8:38 PM
 * To change this template use File | Settings | File Templates.
 */

import Minty.model.User;
import Minty.services.EmailValidator;
import Minty.services.UserService;
import Minty.services.ValidatorService;
import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Hashtable;



@Controller
public class SignupController {
    private final UserService userService;
    private final ValidatorService validatorService;
    @Autowired
    public SignupController(UserService userService, ValidatorService validatorService) {
        this.userService=userService;
        this.validatorService=validatorService;
    }


    @RequestMapping(value="/captcha.json", method=RequestMethod.POST)
    @ResponseBody
    public String checkCaptcha( @RequestParam String challenge,
                                @RequestParam String response, HttpServletRequest request)
    {

        String remoteAddr = request.getRemoteAddr();
        ReCaptchaImpl reCaptcha = new ReCaptchaImpl();

        reCaptcha.setPrivateKey("6LepJNUSAAAAABKmm-ELb7dLNrHXmvHCrFPMNcMH ");

        ReCaptchaResponse reCaptchaResponse =
                reCaptcha.checkAnswer(remoteAddr, challenge, response);

        if (!reCaptchaResponse.isValid()) {
            return "no";

        }
        else return "yes";
    }


    @RequestMapping(value = "/user/register", method = RequestMethod.GET)
    public ModelAndView RegistrationForm() {
        return new ModelAndView("register");
    }

    @RequestMapping(value = "/user/{handle}/userdetails", method = RequestMethod.GET)
    public ModelAndView userDetailsForm(@PathVariable final String handle) {
        return new ModelAndView("almostthere"){{
            addObject("User",userService.getUser(handle));
        }};
    }

    @RequestMapping(value = "/user/{handle}/userdetails", method = RequestMethod.POST)
    public ModelAndView submituserDetailsForm(@PathVariable final String handle,final User user) {
        user.setUsername(handle);
        userService.updateUser(user,handle);
        return new ModelAndView("redirect:/uploadfile");
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
            e.printStackTrace();
        }
        return h;
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public ModelAndView register(final User user, HttpSession session) {

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

        return new ModelAndView("almostthere"){{
            addObject("handle",user.getUsername());
        }};

    }



}