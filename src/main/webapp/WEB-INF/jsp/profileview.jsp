<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <link rel="stylesheet" href="/static/css/easyNotification.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript" src="/static/js/easy.notification.js"></script>
    <script type="text/javascript" src='/static/js/follow.js'></script>
    <script type="text/javascript" src='/static/js/addTweet.js'></script>
    <script type="text/javascript">var num_followers=${User.num_followers};</script>

</head>
<body>
Hello <a href ="/user/${sessionScope.userName}">${sessionScope.userName}</a> <a href="/user/logout">Logout</a>
<h1><a href="/home">My Homepage</a></h1>


<form action="" onsubmit="follow('${handle}'); return false;">

    <input type="submit" value="${message}" name="unfollow" id="followBtn"/>

</form>


<h1> ${handle}'s Profile</h1>

<li id='numFollowers'><a href="/user/getfollowers/${handle}">followers: <span id="num_followers">${User.num_followers}</span></a></li>
<li><a href="/user/getfollowing/${handle}">following: ${User.num_following}</a></li>

User ${handle}'s Tweets   ${User.num_tweets}
<ul id="tweetList">

    <c:forEach var='item' items='${List}'>
        <script type="text/javascript">
            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'})
        </script>
    </c:forEach>
</ul>
</body>
</html>
