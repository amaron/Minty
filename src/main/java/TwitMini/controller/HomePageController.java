package TwitMini.controller;


import TwitMini.services.TweetService;
import TwitMini.services.UserService;
import TwitMini.services.ViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.logging.Logger;

@Controller
@RequestMapping
public class HomePageController {

    private final ViewService viewService;
    private final TweetService tweetStore;
    private final UserService userService;
    //private Integer latestTweet;
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

    @RequestMapping("/search")
    public ModelAndView Search(@RequestParam final String searchtext, HttpSession Session){

        logger.info("User " + (String)Session.getAttribute("userName") + " searched for "+ searchtext );
        return new ModelAndView("search"){{

            addObject("UserList", viewService.searchUsers(searchtext));
            addObject("TweetList", viewService.searchTweets(searchtext));
        }
        };

    }


    @RequestMapping("/home")
    public ModelAndView home(final HttpSession Session){

        Integer latestTweet=tweetStore.getLatestTweetId((Long) Session.getAttribute("userID"));
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
