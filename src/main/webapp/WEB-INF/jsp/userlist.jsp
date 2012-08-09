<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>


</head>
<body>
Hello <a href="/user/${sessionScope.userName}"> ${sessionScope.userName} </a><a href="/user/logout">Logout</a>
<h1><a href="/home">My Homepage</a></h1>



<h1> ${label}</h1>
<ul id="followerList">

    <c:forEach var='item' items='${List}'>
        <li><blockquote><a href="/user/${item.username}">${item.username}</a></blockquote></li>
    </c:forEach>
</ul>
</body>
</html>
