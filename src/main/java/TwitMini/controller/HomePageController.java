package TwitMini.controller;


import TwitMini.model.TweetData;
import TwitMini.model.User;
import TwitMini.services.TweetService;
import TwitMini.services.UserService;
import TwitMini.services.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.logging.Logger;

@Controller
@RequestMapping
public class HomePageController {

    private final ViewService viewService;
    private final TweetService tweetStore;
    private final UserService userService;
    private final Logger logger;

    @Autowired
    public HomePageController(TweetService tweetStore, UserService userService, ViewService viewService, Logger logger) {
        this.tweetStore = tweetStore;
        this.userService = userService;
        this.viewService=viewService;
        this.logger=logger;

    }

    @RequestMapping("/tweet")
    public ModelAndView homeredirect(){

        return new ModelAndView("redirect:/home"){{

        }
        };
    }

    @RequestMapping(value="/search/moreSearchTweets.json", method=RequestMethod.GET)
    @ResponseBody
    public List<TweetData> moreSearchResultsTweets(@RequestParam String searchtext, @RequestParam int offset){
        return viewService.searchTweets(searchtext,offset,10);
    }

    @RequestMapping(value="/search/moreSearchUsers.json", method=RequestMethod.GET)
    @ResponseBody
    public List<User> moreSearchResultsUsers(@RequestParam String searchtext, @RequestParam int offset){
        return viewService.searchUsers(searchtext, offset, 10);
    }

    @RequestMapping("/search")
    public ModelAndView Search(@RequestParam final String searchtext, HttpSession Session){

        logger.info("User " + (String)Session.getAttribute("userName") + " searched for "+ searchtext );

       final  List<TweetData> tweet_list= viewService.searchTweets(searchtext,0,10);
       final List<User> user_list =  viewService.searchUsers(searchtext,0,10);

        return new ModelAndView("search"){{
            addObject("searchtext",searchtext);
            addObject("UserList", user_list);
            addObject("TweetList", tweet_list );
            addObject("UserListSize",user_list.size());
            addObject("TweetListSize",tweet_list.size());
        }
        };

    }

    @RequestMapping(value="/public",method=RequestMethod.GET)
    public ModelAndView allTweets(){
        return new ModelAndView("public"){{
            addObject("List",tweetStore.listAllTweets(0,10));
        }};

    }

    @RequestMapping(value="/getMorePublicTweets.json", method= RequestMethod.GET)
    @ResponseBody
    public List<TweetData> getMorePublicTweets(@RequestParam final int offset){
        return tweetStore.listAllTweets(offset,10);

    }

    @RequestMapping("/home")
    public ModelAndView home(final HttpSession Session){

        Integer latestTweet=tweetStore.getLatestTweetId((Long) Session.getAttribute("userID"),0);
        Session.setAttribute("latestTweet",latestTweet);
        Session.setAttribute("offset", 10);
        System.out.println("home latest tweet " + Session.getAttribute("userName") + latestTweet);
        return new ModelAndView("randomhome"){{
            addObject("User",userService.getUser((String) Session.getAttribute("userName")));
            addObject("List",tweetStore.listHomePageTweets(10, 0, (Long) Session.getAttribute("userID")));
        }
    };
    }




}
