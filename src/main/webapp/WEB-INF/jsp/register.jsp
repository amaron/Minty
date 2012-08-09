<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty sessionScope.userName}">
    <script type="text/javascript">
        window.location = "/tweet"
    </script>
</c:if>

<c:if test="${not empty message}">
    ${message}</br>
</c:if>


New to TwitMini? Register Now!
<form action="/user/register" method="post">
    Name: <input type="text" name="realname"></br>
    username: <input type="text" name="username"></br>
    email id: <input type="text" name="email"></br>
    password: <input type="password" name="user_password"></br>
    <input type="submit" value="Register">
</form>

