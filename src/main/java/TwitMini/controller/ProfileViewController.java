package TwitMini.controller;

import TwitMini.services.TweetService;
import TwitMini.services.UserService;
import TwitMini.services.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Hashtable;
import java.util.logging.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 26/7/12
 * Time: 5:17 PM
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("user")
public class ProfileViewController {

    private final ViewService viewService;
    private final TweetService tweetStore;
    private final UserService userService;
    private final Logger logger;

    @Autowired
    public ProfileViewController(ViewService viewService, TweetService tweetStore, UserService userService, Logger logger) {
        this.viewService = viewService;
        this.tweetStore=tweetStore;
        this.userService = userService;
        this.logger=logger;
    }


    @RequestMapping("{handle}")
    public ModelAndView ViewUser(@PathVariable final String handle, HttpServletRequest request) {

        boolean isUser=viewService.isUserExists(handle);
        if(!isUser){ return new ModelAndView("errorpage") {{
            addObject("message","user "+ handle+ " doesnt exist!");
        }};
        }

        HttpSession session = request.getSession(false);

        if(session!=null) {


        String userName = (String) session.getAttribute("userName");

        if (userName != null) {

            if(userName.equals(handle)){
                ModelAndView mv= new ModelAndView("ownprofile");
                mv.addObject("handle",handle);
                mv.addObject("User",userService.getUser(handle));
                mv.addObject("List", viewService.listUserTweets(handle));
                return mv;
            }

        boolean isfollow=viewService.isFollowing(handle);
        ModelAndView mv= new ModelAndView("profileview");
        if(isfollow==true){mv.addObject("message","unfollow");}
        else mv.addObject("message","follow");

        mv.addObject("User",userService.getUser(handle));
        mv.addObject("handle",handle);
        mv.addObject("List", viewService.listUserTweets(handle));

        logger.info("user "+userName + " visited " + handle + "'s profile");

        return mv;
        }

        }

            return new ModelAndView("profileview-public"){{
                addObject("List",viewService.listUserTweets(handle));
            }};


    }


    @RequestMapping("getfollowers/{handle}")
    public ModelAndView getFollowers(@PathVariable final String handle,HttpSession Session){
        ModelAndView mv= new ModelAndView("userlist");
        mv.addObject("label","Users "+ "that follow " + handle);
        mv.addObject("User",userService.getUser((String) Session.getAttribute("userName")));
        mv.addObject("List",viewService.getFollowers(handle));
        mv.addObject("handle",handle);

        return mv;
    }

    @RequestMapping("getfollowing/{handle}")
    public ModelAndView getFollowering(@PathVariable final String handle,HttpSession Session){
        ModelAndView mv= new ModelAndView("userlist");
        mv.addObject("label","Users "+ handle+ " follows");
        mv.addObject("User",userService.getUser((String) Session.getAttribute("userName")));
        mv.addObject("List",viewService.getFollowing(handle));
        mv.addObject("handle",handle);
        return mv;
    }

    @RequestMapping(value ="follow/{handle}.json", method = RequestMethod.POST)
    @ResponseBody
    public Hashtable FollowuserJSON(@PathVariable final String handle, HttpSession Session) {
        viewService.followUser(handle);
        Hashtable h= new Hashtable();
        h.put("status","success");
        h.put("name",handle);
        if(viewService.isFollowing(handle)==true){

                 h.put("value","unfollow");
                 h.put("displayvalue","follow");
                 logger.info("user "+ (String)Session.getAttribute("userName")+" followed " + handle );
        }
        else {
            logger.info("user "+ (String)Session.getAttribute("userName")+" unfollowed " + handle );
            h.put("value","follow");h.put("displayvalue","unfollow");
        }


        return h;
    }


}
