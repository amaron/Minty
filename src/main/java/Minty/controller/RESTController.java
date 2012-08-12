package Minty.controller;

import Minty.model.TweetData;
import Minty.model.User;
import Minty.services.TweetService;
import Minty.services.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Hashtable;
import java.util.List;
import java.util.logging.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 26/7/12
 * Time: 5:17 PM
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("REST")
public class RESTController {

    private final ViewService viewService;
    private final TweetService tweetStore;
    private final Logger logger;

    @Autowired
    public RESTController(ViewService viewService, TweetService tweetStore, Logger logger) {
        this.viewService = viewService;
        this.tweetStore=tweetStore;
        this.logger=logger;
    }

    @RequestMapping(value="{handle}/mentions.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> getMentions(@PathVariable final String handle, @RequestParam int limit, @RequestParam int offset){
        return viewService.listUserMentions(handle,offset,limit);

    }


    @RequestMapping(value="/getPublicTweets.json", method= RequestMethod.GET)
    @ResponseBody
    public List<TweetData> getMorePublicTweets(@RequestParam final int offset, @RequestParam final int limit){
        return tweetStore.listAllTweets(offset,limit);

    }

    @RequestMapping(value="/searchTweets.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> moreSearchResultsTweets(@RequestParam String q, @RequestParam int offset, @RequestParam int limit){
        return viewService.searchTweets(q,offset,limit);
    }

    @RequestMapping(value="/searchUsers.json", method=RequestMethod.GET)
    @ResponseBody
    public List<User> moreSearchResultsUsers(@RequestParam String q, @RequestParam int offset, @RequestParam int limit){
        int i;
        List<User> u_list=viewService.searchUsers(q,offset,limit);

        for(i=0;i<u_list.size();i++){
            u_list.get(i).setUser_password("");
        }
        return u_list;
    }

    @RequestMapping(value="/user/{handle}/Tweets.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> listUserTweets(@PathVariable String handle, @RequestParam int offset, @RequestParam int limit){
        return viewService.listUserTweets(handle,offset,limit);
    }

    @RequestMapping(value="/user/{handle}/Feed.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> listUserFeed(@PathVariable String handle, @RequestParam int offset, @RequestParam int limit){
        return viewService.listUserFeed(handle,offset,limit);
    }

    @RequestMapping(value="/user/tweet/{id}.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> getTweet(@RequestParam int id){
        return tweetStore.getTweet(id);
    }

    @RequestMapping(value="{handle}/followers.json", method=RequestMethod.GET)
    @ResponseBody
    public Hashtable getFollowers(@PathVariable final String handle){
        Hashtable h_send=new Hashtable();
        int i;
        List<User> f_list=viewService.getFollowers(handle);

        for(i=0;i<f_list.size();i++){
            f_list.get(i).setUser_password("");
        }
        h_send.put("followers_list", f_list);
        return h_send;
    }


    @RequestMapping(value="{handle}/following.json", method=RequestMethod.GET)
    @ResponseBody
    public Hashtable getFollowing(@PathVariable final String handle){
        Hashtable h_send=new Hashtable();
        int i;
        List<User> f_list=viewService.getFollowing(handle);

        for(i=0;i<f_list.size();i++){
            f_list.get(i).setUser_password("");
        }
        h_send.put("following_list",f_list);
        return h_send;
    }


}
