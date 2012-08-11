<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaImpl" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaResponse" %>

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
<form action="/user/register"  method="post">
    Name: <input type="text" id="realname" name="realname"> <span id="realname_error">Enter Your Name!</span></br>
    <script type="text/javascript" src="/static/js/rnm_chk.js"></script>
    username: <input type="text" id="username" name="username"> <span id="username_error"></span></br>
    <script type="text/javascript" src="/static/js/usrnm_chk.js"></script>
    email id: <input type="text" id="email" name="email"> <span id="email_error"></span></br>
    <script type="text/javascript" src="/static/js/eml_chk.js"></script>
    password: <input type="password" id="password" name="user_password"> <span id="password_error"></span></br>
    <script type="text/javascript" src="/static/js/pswrd_chk.js"></script>

    <input type="submit" id="regBtn" name="regBtn" value="Register" style="display:none">
</form>
<form>
    <script type="text/javascript"
            src="http://api.recaptcha.net/challenge?k=6LepJNUSAAAAADjXVJ-6vY5223LNYgZbzy3mWgNt">
    </script>
    <noscript>
        <iframe id="captchaImg" name="captchaImg" src="http://api.recaptcha.net/noscript?k=6LepJNUSAAAAADjXVJ-6vY5223LNYgZbzy3mWgNt"
                height="300" width="500" frameborder="0"></iframe><br>
        <textarea id="captchaText" name="recaptcha_challenge_field" rows="3" cols="40">
        </textarea>
        <input id="manChallenge" type="hidden" name="recaptcha_response_field"
               value="manual_challenge">
    </noscript>

    <button type="button" onclick="validateCaptcha(this.form.recaptcha_challenge_field.value,this.form.recaptcha_response_field.value);return false;">verify!</button>
    <script type="text/javascript">
        function validateCaptcha(chall,resp){
            var check =false;
            $.ajax({
                type: "POST",
                data:$.param({ challenge: chall, response: resp}),
                url: "/captcha.json",
                async:false,
                success: function(result){
                       //alert(result) ;
                    if(result=="yes"){

                        $('#captchaImg').style="display:none";
                        $('#manChallenge').style="display:none";
                        $('#captchaText').style="display:none";
                        $('#regBtn').show();
                        check=true;
                    }


                }
            });
            //alert (check);
            return check;
        }
    </script>
</form>

</body>
</html>