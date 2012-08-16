package Minty.controller;

import Minty.model.TweetData;
import Minty.services.TweetService;
import Minty.services.ViewService;
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
public class TweetController {

    private final ViewService viewService;
    private final TweetService tweetStore;
    private final Logger logger;

    @Autowired
    public TweetController(ViewService viewService, TweetService tweetStore, Logger logger) {
        this.viewService = viewService;
        this.tweetStore=tweetStore;
        this.logger=logger;
    }


    @RequestMapping(value="{handle}/tweet/{id}", method=RequestMethod.GET)
    public ModelAndView Viewtweet(@PathVariable final String handle, @PathVariable final int id) {
        if(viewService.getUserId(handle)==null){
            return new ModelAndView("errorpage") {{
                addObject("message","User "+ handle+ " doesnt exist!");
            }};
        }

        ModelAndView mv= new ModelAndView("tweetpage");
        mv.addObject("List", tweetStore.getTweet(id));
        return mv;
    }

    @RequestMapping(value="/retweet/{id}", method=RequestMethod.POST)
    @ResponseBody
    public List<TweetData> retweet(@PathVariable final int id) {
        return  tweetStore.getTweet(id);
    }


    @RequestMapping(value ="getMoreTweets/{num}.json", method = RequestMethod.POST)
    @ResponseBody
    public Hashtable getMore(HttpSession Session, @PathVariable int num) {

        Hashtable h= new Hashtable();
        Integer offset=  (Integer)Session.getAttribute("offset");
        List<TweetData> L= tweetStore.listHomePageTweets(10, offset + num, (Long) Session.getAttribute("userID"));
        h.put("status","success");
        h.put("val",L.size());
        h.put("List", L);
        Session.setAttribute("offset",offset+10);

        return h;
    }

    @RequestMapping(value="{handle}/tweet/{id}/reply", method = RequestMethod.GET)
    public ModelAndView replyTweet(@PathVariable final String handle, @PathVariable final int id) {

        boolean isUser=viewService.isUserExists(handle);
        if(!isUser){ return new ModelAndView("errorpage") {{
            addObject("message","user "+ handle+ " doesnt exist!");
        }};
        }

        ModelAndView mv= new ModelAndView("tweetpage");
        mv.addObject("List", tweetStore.getTweet(id));


        return mv;
    }

    @RequestMapping(value="/tweet/create.json", method = RequestMethod.POST)
    @ResponseBody
    public TweetData create(TweetData tweet, HttpSession session) {

        TweetData new_tweet= tweetStore.add(tweet, (String)session.getAttribute("userName"), (Long)session.getAttribute("userID"));
        logger.info("user "+(String)session.getAttribute("userName") +"tweeted " + new_tweet.getTweet_id());
        return new_tweet;
    }

    @RequestMapping(value="/updates.json", method = RequestMethod.GET )
    @ResponseBody
    public Hashtable updates( HttpSession Session, HttpServletRequest request) {

        Integer latestTweet= (Integer) Session.getAttribute("latestTweet");
        Hashtable h= new Hashtable();
        Integer update=tweetStore.getLatestTweetId((Long) Session.getAttribute("userID"), latestTweet);
        if(update>latestTweet){

            h.put("value", "yes");
            h.put("number",update-latestTweet);
            Session.setAttribute("currLatestTweet",update);
        }
        else  h.put("value","no");
        return h;

    }

    @RequestMapping(value="/getNewTweet.json", method = RequestMethod.POST )
    @ResponseBody
    public Hashtable getUpdates( HttpSession Session) {
        Hashtable h= new Hashtable();
        Integer latestTweet= (Integer) Session.getAttribute("latestTweet");
        Integer currLatestTweet=(Integer) Session.getAttribute("currLatestTweet");
        List<TweetData> L=tweetStore.getNewTweets(latestTweet,currLatestTweet,(Long)Session.getAttribute("userID"));
        h.put("val",L.size());
        System.out.println("List size"+L.size());
        h.put("List",L);
        Session.setAttribute("latestTweet",currLatestTweet);
        return h;

    }

}
