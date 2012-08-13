
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Almost there!</title>
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
        <legend>Almost there, Minty awaits your presence...</legend>
        <div class="span6">





            <form class="form-horizontal">
                <fieldset>

                    <div class="control-group">
                        <label class="control-label" for="fileInput">How do you look?</label>
                        <div class="controls">
                            <input class="input-file" id="fileInput" type="file">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="textarea">Bio (a few words)</label>
                        <div class="controls">
                            <textarea class="input-xlarge" id="textarea" rows="3" placeholder="Standing out or out standing? Minty needs to know."></textarea>

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input01">Location</label>
                        <div class="controls">
                            <input type="text" class="input-xlarge" id="input01" placeholder="Minty loves cheesiness.">
                            <p class="help-block">City/State/Country/Planet/Heart</p>
                        </div>
                    </div>



                    <div class="control-group">
                        <label class="control-label" for="input01">Website</label>
                        <div class="controls">
                            <input type="text" class="input-xlarge" id="input01" placeholder="Minty loves cheesiness.">
                            <p class="help-block">Blog/Webpage/Facebook/Por..Project</p>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="select01">What do you do?</label>
                        <div class="controls">
                            <select id="select01">
                                <option>I just chill out.</option>
                                <option>One of those geeks you see near Andheri.</option>
                                <option>Businessman. Yeah, the family one.</option>
                                <option>Sell stuff (be it Milk or Domains).</option>
                                <option>Does it matter?</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Take me to my Minty!</button>
                        <button class="btn">Skip</button>
                    </div>
                </fieldset>
            </form>

        </div><!--/span-->



        <div class="span6">
            <img src="img/almost.jpg" />
        </div><!--/span-->
    </div>


</div> <!-- /container -->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery.js"></script>
<script src="js/bootstrap-transition.js"></script>
<script src="js/bootstrap-alert.js"></script>
<script src="js/bootstrap-modal.js"></script>
<script src="js/bootstrap-dropdown.js"></script>
<script src="js/bootstrap-scrollspy.js"></script>
<script src="js/bootstrap-tab.js"></script>
<script src="js/bootstrap-tooltip.js"></script>
<script src="js/bootstrap-popover.js"></script>
<script src="js/bootstrap-button.js"></script>
<script src="js/bootstrap-collapse.js"></script>
<script src="js/bootstrap-carousel.js"></script>
<script src="js/bootstrap-typeahead.js"></script>
<script type="text/javascript" src="http://jzaefferer.github.com/jquery-validation/jquery.validate.js"></script>
<script type="text/javascript">
    //TODO: Validation for webpages and other stuff.
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
                user_name:"required",
                user_email:{

                    required:true,
                    email: true

                },
                password:{
                    required:true,
                    minlength: 6
                },
            },
            messages:{
                user_name:"Enter your first and last name",
                user_email:{
                    required:"Enter your email address",
                    email:"Enter valid email address"
                },
                password:{
                    required:checkpassword(),
                    minlength:"Password must be minimum 6 characters"
                },

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
