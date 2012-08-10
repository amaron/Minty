<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/easyNotification.css">
    <link rel="stylesheet" href="static/css/charCount.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/easy.notification.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/charCount.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript" src="/static/js/getUpdates.js"></script>
    <script type="text/javascript" src="/static/js/addTweet.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getMoreTweets.js"></script>
    <script type="text/javascript" src="/static/js/displayNew.js"></script>
    <script type="text/javascript" src="/static/js/escapeHTML.js"></script>


    <script type="text/javascript">


        $(document).ready(function(){

            //custom usage
            $("#tweet").charCount({
                allowed: 128,
                warning: 20,
                counterText: 'Characters left: '
            });
        });
        var num_tweets=${User.num_tweets};
        var newtweets=0;

//        function showReply(id,username){
//            //alert("entered with" + id);
//            document.getElementById('replyform'+id).tweet.value="@"+username+": ";
//            $('#replyform'+id).show();
//
//            document.getElementById('replyform'+id).tweet.focus();
//
//        }

    </script>

</head>
<body>



Hello <a href ="/user/${sessionScope.userName}">${sessionScope.userName}</a>  <a href="/user/logout">Logout</a>
<h2><a href="/home">Homepage</a></h2>


<form action='/search'>
    <input type='text' name='searchtext'/>
    <input type='submit' value='search'/>
</form>

<h1>Tweet Tweet!</h1>


<form action="/user/getNewTweet.json" onsubmit="displayNew(this);return false">
    <input type="submit" style="display:none" value="you have new tweets!" id="updateBtn"/>
</form>


<form action="/user/tweet/create.json" onsubmit="addTweetNow(this); return false;">

    <div>
        <label for="tweet">Tweet! <small>128 character limit</small></label>
        <textarea id="tweet" name="tweet"></textarea>
    </div>
    <input type="submit" value="Tweet"/>
</form>

 <blockquote>
 Followers: ${User.num_followers}
 Following: ${User.num_following}
 Tweets:<span id="numTweets"> ${User.num_tweets} </span>
 </blockquote>
<ul id="tweetList">

    <c:forEach var='item' items='${List}'>

        <script type="text/javascript">
            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'});
        </script>
    </c:forEach>

</ul>

<form action="/user/getMoreTweets.json" onsubmit="getMoreTweets(this);return false">
    <input type="submit"  value="Load More Tweets" id="moreTweetsBtn"/>
</form>

</body>
</html>