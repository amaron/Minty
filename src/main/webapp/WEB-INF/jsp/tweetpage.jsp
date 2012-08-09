<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <link rel="stylesheet" href="/static/css/charCount.css">
    <link rel="stylesheet" href="/static/css/easyNotification.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/easy.notification.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/addTweetNow.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript" src="/static/js/charCount.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){

            //custom usage
            $("#tweet").charCount({
                allowed: 128,
                warning: 20,
                counterText: 'Characters left: '
            });
        });
    </script>

</head>
<body>
Hello <a href ="/user/${sessionScope.userName}">${sessionScope.userName}</a> <a href="/user/logout">Logout</a>
<h1><a href="/home">My Homepage</a></h1>



<h1> ${List[0].username}'s Tweet</h1>

<ul id="tweetList">

    <c:forEach var='item' items='${List}'>
        <script type="text/javascript">
            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'})
        </script>
    </c:forEach>

</ul>

<form action="/user/tweet/create.json" onsubmit='addTweetNow(this); return false;' method='post'>

    <div>
        <label for="tweet"> <small>128 character limit</small></label>
        <textarea id="tweet" name="tweet">@${List[0].username}:</textarea>
    </div>
    <input type="submit" value="Tweet"/>
</form>


</body>
</html>
