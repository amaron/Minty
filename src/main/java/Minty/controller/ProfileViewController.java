package Minty.controller;

import Minty.model.TweetData;
import Minty.model.User;
import Minty.services.UserService;
import Minty.services.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Hashtable;
import java.util.List;
import java.util.logging.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: karthik
 * Date: 26/7/12
 * Time: 5:17 PM
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("user")
public class ProfileViewController {

    private final ViewService viewService;
    private final UserService userService;
    private final Logger logger;

    @Autowired
    public ProfileViewController(ViewService viewService, UserService userService, Logger logger) {
        this.viewService = viewService;
        this.userService = userService;
        this.logger=logger;
    }


    @RequestMapping(value="{handle}", method=RequestMethod.GET)
    public ModelAndView ViewUser(@PathVariable final String handle, HttpServletRequest request)
    {
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
                mv.addObject("List", viewService.listUserTweets(handle,0,10));
                return mv;
            }

            boolean isfollow=viewService.isFollowing((Long)session.getAttribute("userID"),handle);

            ModelAndView mv= new ModelAndView("profileview");
            if(isfollow==true){mv.addObject("message","unfollow");}
            else mv.addObject("message","follow");

            mv.addObject("User",userService.getUser(handle));
            mv.addObject("handle",handle);
            mv.addObject("List", viewService.listUserTweets(handle,0,10));

            logger.info("user "+userName + " visited " + handle + "'s profile");

            return mv;
        }
        }

    return new ModelAndView("profileview-public"){{
           addObject("List",viewService.listUserTweets(handle,0,10));
           addObject("User",userService.getUser(handle));
           }};
    }

    @RequestMapping(value="{handle}/mentions", method=RequestMethod.GET)
    public ModelAndView mentions(@PathVariable final String handle)
    {

        return new ModelAndView("mentions"){{
            addObject("User",userService.getUser(handle));
            addObject("List",viewService.listUserMentions(handle,0,10));
        }
        };
    }



    @RequestMapping(value="{handle}/getMoreMentions.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> moreMentions(@PathVariable final String handle, @RequestParam final int offset)
    {
        return viewService.listUserMentions(handle,offset,10);
    }


    @RequestMapping(value="{handle}/getMoreUserTweets.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> moreUserTwees(@PathVariable final String handle, @RequestParam final int offset)
    {
        return viewService.listUserTweets(handle,offset,10);
    }

    @RequestMapping(value="{handle}/followers", method=RequestMethod.GET)
    public ModelAndView getFollowers(@PathVariable final String handle,HttpSession Session){
        ModelAndView mv= new ModelAndView("userlist");
        mv.addObject("label","followers");
        mv.addObject("User",userService.getUser((String) Session.getAttribute("userName")));
        mv.addObject("List",viewService.getFollowers(handle));

        mv.addObject("handle",handle);
        return mv;
    }

    @RequestMapping(value="/edit", method=RequestMethod.GET)
    public ModelAndView editProfile(final HttpSession Session){
        return new ModelAndView("almostthere"){{
             addObject("User",userService.getUser((String) Session.getAttribute("userName")));
             addObject("handle",(String) Session.getAttribute("userName"));
        }};
    }

    @RequestMapping(value="/edit", method=RequestMethod.POST)
    public ModelAndView saveEditProfile(User user, final HttpSession Session){
        userService.updateUser(user);
        return new ModelAndView("redirect:/home");
    }


    @RequestMapping(value="{handle}/following",method=RequestMethod.GET)
    public ModelAndView getFollowering(@PathVariable final String handle,HttpSession Session){
        ModelAndView mv= new ModelAndView("userlist");
        mv.addObject("following");
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
        if(viewService.isFollowing((Long)Session.getAttribute("userID"),handle)==true){

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
