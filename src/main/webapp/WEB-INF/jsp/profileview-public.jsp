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

</head>
<body>
Hello, Y U No Signup?! <a href="/user/register">Signup!</a>
<a href="/user/login">login</a>

<h2>SpeakOUT!</h2>

<h1> ${List[0].username}'s Profile</h1>
<ul id="tweetList">
    User ${List[0].username}'s Tweets
    <c:forEach var='item' items='${List}'>
        <script type="text/javascript">
            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'})
        </script>
    </c:forEach>
</ul>
</body>
</html>
