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


<?xml version="1.0" encoding="utf-8"?>

<head>

    <script type="text/javascript" src="/static/js/gen_validatorv4.js"></script>
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>

</head>


Login:
<form id='loginForm' action="/user/login" method="post">
    username or email id: <input type="text" id= "username1" name="username"></br>
    password: <input type="password" id="user_password" name="user_password"></br>
    <input type="submit" value="Login">
</form>

New to SpeakOUT? Register Now!
<form action="/user/register" method="post">
    Name: <input type="text" id="realname" name="realname"> <span id="realname_error">Enter Your Name!</span></br>
    <script type="text/javascript" src="/static/js/rnm_chk.js"></script>
    username: <input type="text" id="username" name="username"> <span id="username_error"></span></br>
    <script type="text/javascript" src="/static/js/usrnm_chk.js"></script>
    email id: <input type="text" id="email" name="email"> <span id="email_error"></span></br>
    <script type="text/javascript" src="/static/js/eml_chk.js"></script>
    password: <input type="password" id="password" name="user_password"> <span id="password_error"></span></br>
    <script type="text/javascript" src="/static/js/pswrd_chk.js"></script>
    <input type="submit" value="Register">
</form>
</body>
</html>