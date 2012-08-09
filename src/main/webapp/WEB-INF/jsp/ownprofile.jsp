<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript" src='/static/js/addTweet.js'></script>


</head>
<body>
Hello <a href ="/user/${sessionScope.userName}">${sessionScope.userName}</a> <a href="/user/logout">Logout</a>
<h1><a href="/home">My Homepage</a></h1>



<h1> ${handle}'s Profile</h1>
<h1><a href="/user/${handle}/edit">Edit Profile</a></h1>
<li><a href="/user/getfollowers/${handle}">followers ${User.num_followers}</a></li>
<li><a href="/user/getfollowing/${handle}">following ${User.num_following}</a></li>


User ${handle}'s Tweets ${User.num_tweets}
<ul id="tweetList">

    <c:forEach var='item' items='${List}'>
        <script type="text/javascript">
            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'})
        </script>
    </c:forEach>
</ul>
</body>
</html>
