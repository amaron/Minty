<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${not empty message}">
    ${message}</br>
</c:if>

Register Now to user Minty 3rdParty REST APIs!
<form action="/REST/register" method="post">
    Name: <input type="text" name="pname"></br>
    <input type="submit" value="Register">
</form>

Post tweet
<form action="/REST/user/amaron/createTweet.json" method="post">
    username: <input type="text" name="username"></br>
    Tweet: <input type="text" name="Tweet"></br>
    p_key: <input type="text" name="p_key"></br>
    u_key: <input type="text" name="u_key"></br>
    user_id: <input type="text" name="user_id"></br>

    <input type="submit" value="Post Tweet!">
</form>


