<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript">
    var cur_offset=10;
    var cur_searchtext='${searchtext}';
    function getMoreSearchTweets(){

    $.ajax({
    type: 'GET',
    url: '/search/moreSearchTweets.json',
    data: $.param({ offset: cur_offset, searchtext: cur_searchtext}),
    success: function(data) {
    if(data.length==0) $('#moreTweetsBtn').hide();
    for(var k=0;k<data.length;k++){
    //alert(JSON.stringify(data.List[k]));
    appendItem(data[k]);
    }
    }
    });
    cur_offset+=10;


    }
    </script>



    </head>
<body>
Hello <a href="/user/${sessionScope.userName}"> ${sessionScope.userName} </a><a href="/user/logout">Logout</a>
<h1><a href="/home">My Homepage</a></h1>



<h1>UserList</h1>
<ul id="userList">

    <c:forEach var='item' items='${UserList}'>
        <li><blockquote><a href="/user/${item.username}">${item.username}</a></blockquote></li>
    </c:forEach>
</ul>


<h2>TweetList</h2>
<ul id="tweetList">
    <c:forEach var='item' items='${TweetList}'>
        <script type="text/javascript">
            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'})
        </script>
    </c:forEach>
</ul>

<form action="moreSearchTweets.json" onsubmit="getMoreSearchTweets();return false">
    <input type="submit"  value="Load More Results" id="moreTweetsBtn"/>
</form>

</body>
</html>
