
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
    <link href="/static/css/bootstrap.css" rel="stylesheet">
    <link href="/static/css/bootstrap-responsive.css" rel="stylesheet">
    <style>
        body {
            padding-top: 120px; /* 60px to make the container go all the way to the bottom of the topbar */
        }

    </style>



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
        <legend>Edit your profile...</legend>
        <div class="span12">





            <form class="form-horizontal" action="/user/${handle}/userdetails" method="post">
                <fieldset>


                    <div class="control-group">
                        <label class="control-label" for="bio">Bio (a few words)</label>
                        <div class="controls">
                            <textarea class="input-xlarge" name="bio" value="" id="bio" rows="3" placeholder="Standing out or out standing? Minty needs to know.">${User.bio}</textarea>

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="place">Location</label>
                        <div class="controls">
                            <input type="text" class="input-xlarge" value="${User.place}" name="place" id="place" placeholder="Minty loves cheesiness.">
                            <p class="help-block">City/State/Country/Planet/Heart</p>
                        </div>
                    </div>



                    <div class="control-group">
                        <label class="control-label" for="website">Website</label>
                        <div class="controls">
                            <input type="text" class="input-xlarge" value="${User.website}" name="website" id="website" placeholder="Minty loves cheesiness.">
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
                    </div>

                </fieldset>
            </form>
            <form action="/home">
                <button class="btn">Skip</button>
            </form>
        </div><!--/span-->




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

</body>
</html>
