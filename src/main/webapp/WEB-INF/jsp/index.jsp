
<!DOCTYPE html>
<html lang="en">
<head>
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

    <link href="/static/css/bootstrap.css" rel="stylesheet">
    <link href="/static/css/bootstrap-responsive.css" rel="stylesheet">

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

    <div class="row-fluid">

        <div class="span6">



            <form action="/user/login" method="post" class="well form-inline">
                Already with Minty?
                <input type="text" class="input-medium" placeholder="Username" name="username">
                <input type="password" class="input-medium" placeholder="Password" name="user_password">

                <button type="submit" class="btn">Sign in</button>
            </form>
            <form action="/user/register" method="post" class="well" id="registerHere">
                <legend>Get your Minty account!</legend>

                <div class="control-group">
                    <div class="controls">
                        <input type="text" class="input-large" id="user_name" name="realname" rel="popover" data-content="Enter your first and last name." data-original-title="Full Name" placeholder="Full Name">
                    </div>
                </div>


                <div class="control-group">
                    <div class="controls">
                        <input type="text" class="input-large" id="user_email" name="email" rel="popover" data-content="What’s your email address?" data-original-title="Email" placeholder="Email">
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <input type="text" class="input-large" id="user_username" name="username" rel="popover" data-content="Type a cool Minty name" data-original-title="Username" placeholder="Username">
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <input type="password" class="input-large" id="password" name="user_password" rel="popover" data-content="Six characters or more, be tricky!" data-original-title="Password" placeholder="Password">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"></label>
                    <div class="controls">
                        <button type="submit" class="btn btn-success" >Create My Account</button>
                    </div>
                </div>
            </form>

        </div><!--/span-->



        <%--<div class="span6">--%>
            <%--<legend>How to Minty?</legend>--%>
            <%--<iframe width="570" height="335" src="http://www.youtube.com/embed/SaOFuW011G8" frameborder="0" allowfullscreen></iframe>--%>
        <%--</div><!--/span-->--%>
    </div>


</div> <!-- /container -->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/static/js/bootstrap/jquery.js"></script>
<script src="/static/js/bootstrap/bootstrap-transition.js"></script>
<script src="/static/js/bootstrap/bootstrap-alert.js"></script>
<script src="/static/js/bootstrap/bootstrap-modal.js"></script>
<script src="/static/js/bootstrap/bootstrap-dropdown.js"></script>
<script src="/static/js/bootstrap/bootstrap-scrollspy.js"></script>
<script src="/static/js/bootstrap/bootstrap-tab.js"></script>
<script src="/static/js/bootstrap/bootstrap-tooltip.js"></script>
<script src="/static/js/bootstrap/bootstrap-popover.js"></script>
<script src="/static/js/bootstrap/bootstrap-button.js"></script>
<script src="/static/js/bootstrap/bootstrap-collapse.js"></script>
<script src="/static/js/bootstrap/bootstrap-carousel.js"></script>
<script src="/static/js/bootstrap/bootstrap-typeahead.js"></script>
<script type="text/javascript" src="/static/js/bootstrapJS/jquery.validate.js"></script>
<script type="text/javascript">

    function checkpassword(){
        return "Man, enter your password!";
    }

    $(document).ready(function(){

        $.validator.addMethod("usernameShouldNotAlreadyExist",function(value){
            var check=false;

            $.ajax({
                type: "POST",
                url: "/user/register/usrchk/" + value + ".json",
                async:false,
                success: function(result){
                    if(result.msg=="success")
                        check=true;
                }
            });
            return check;

        }, "username already exists");


        $.validator.addMethod("emailShouldNotAlreadyExist",function(value){

            var check=false;

            $.ajax({
                type: "POST",
                url: "/user/register/emlchk/" + value + ".json",
                async:false,
                success: function(result){
                    if(result.msg=="success")
                    check=true;
                }
            });

            return check;


        }, "email already registered with some other username");

        $('input').hover(function()
        {
            $(this).popover('show')
        });
        $("#registerHere").validate({
            rules:{
                username:{
                    required: true,
                    usernameShouldNotAlreadyExist:true

                },
                email:{
                    required:true,
                    email: true,
                    emailShouldNotAlreadyExist: true

                },
                user_password:{
                    required:true,
                    minlength: 6

                }
            },
            messages:{
                username:{
                    required:"Enter your first and last name"
                    //usernameShouldNotAlreadyExist:"username already exists"
                },
                email:{
                    required:"Enter your email address",
                    email:"Enter valid email address"
                    //emailShouldNotAlreadyExist:"email already registered with some other username"
                },
                user_password:{
                    required:checkpassword(),
                    minlength:"Password must be minimum 6 characters"
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