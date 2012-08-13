<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>






<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <meta charset="utf-8">
    <title>Welcome to Minty!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Include Bootstrap Asserts JavaScript Files. -->

    <!-- Le styles -->

    <style>
        body {
            padding-top: 120px; /* 60px to make the container go all the way to the bottom of the topbar */
        }

    </style>

    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
</head>

<body>

<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="#">Minty</a>
            <div class="nav-collapse">

            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container">

    <div class="row">

        <div class="span6 offset3">



            <legend align="left"><b>Minty Login</b></legend>
            <c:if test="${not empty message}">
                ${message}</br>
            </c:if>
            <form class="form-horizontal" id="registerHere" method="POST" action="/REST/login">



                <div class="control-group">
                    <div class="controls">
                        <input type="text" class="input-large" id="username" name="username" placeholder="Username">
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <input type="password" class="input-large" id="user_password" name="user_password" placeholder="Password">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"></label>
                    <div class="controls">
                        <button type="submit" class="btn btn-success" >Login</button> or <a href="#">Sign up here</a>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <input type="text" class="input-large" id="cb_url" name="cb_url" placeholder="cb_url">
                    </div>
                </div>
            </form>

        </div><!--/span-->





    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/static/js/bootstrapJS/jquery.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-transition.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-alert.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-modal.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-dropdown.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-scrollspy.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-tab.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-tooltip.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-popover.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-button.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-collapse.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-carousel.js"></script>
    <script src="/static/js/bootstrapJS/bootstrap-typeahead.js"></script>
    <script type="text/javascript" src="http://jzaefferer.github.com/jquery-validation/jquery.validate.js"></script>
    <script type="text/javascript">
        function checkpassword(){
            return "Man, enter your password!";
        }
        $(document).ready(function(){
            $('input').hover(function()
            {
                $(this).popover('show')
            });
            $("#registerHere").validate({
                rules:{
                    username:"required",
                    user_password:{

                        required:true,
                        password:true

                    }

                },
                messages:{
                    username:"WTF! Enter the username atleast.",
                    user_password:{
                        required:"Password man..."
                    }


                },
                errorClass: "help-inline",
                errorElement: "span",
                highlight:function(element, errorClass, validClass) {
                    $(element).parents('.control-group').addClass('error');
                },
                unhighlight: function(element, errorClass, validClass) {
                    $(element).parents('.control-group').removeClass('error');
                    $(element).parents('.control-group').addClass('success');
                }
            });
        });
    </script>

</body>
</html>
