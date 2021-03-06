
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/easy.notification.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/charCount.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript" src="/static/js/getUpdates.js"></script>
    <script type="text/javascript" src="/static/js/addTweet.js"></script>
    <script type="text/javascript" src="/static/js/addTweetNow.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getMoreTweets.js"></script>
    <script type="text/javascript" src="/static/js/displayNew.js"></script>
    <script type="text/javascript" src="/static/js/escapeHTML.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){

            //custom usage
            $("#tweet").charCount({
                allowed: 128,
                warning: 20,
                counterText: 'Characters left: '
            });
        });
        var num_tweets=${User.num_tweets};
        var newtweets=0;
    </script>
    <link href="/static/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 110px;
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }
    </style>
    <link href="/static/css/bootstrap-responsive.css" rel="stylesheet">
    <style type="text/css">

        .tweet {
            padding-top: 15px;
            padding-bottom: 0px;
            height:80px;
            border-bottom-style: inset;

        }

        .tweetimage{
            padding-left: 5px;
        }
        .tweetheader {

            padding-top: 3px;
            padding-bottom: 5px;
            color:black;
            font-family:"Times New Roman";
            font-size:25px;
        }
        .tweettext {

            padding-bottom: 5px;
            color:black;
            font-size: 14px;
            line-height: 20px;
        }
        .time {
            float:right;
            padding-right: 5px;
            padding-top: 6px;
            padding-left:3px;
            color:#356635 ;

        }
        .reply {
            float:right;
            padding-right: 5px;
        }
        .mintheader{
            font-size: 20px;
            color: black;

        }
        #replyform {
            padding-left: 80px;
        }
        .mintbio {

        }
        .charleft{
            float: right;
            padding-top:5px;
            padding-right: 5px;
            font-size: 20px;
        }
        .smalltext{
            font-size: 12px;
            float:right;
            padding-top: 2px;
        }
        a:link {
            color: #51A351;
        }
        a:visited {
            color: #51A351;
        }
        a:hover {
            color: black;
        }
        a:active {
            color: #51A351;
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
            <div class="btn-group pull-right">
                <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-user"></i> ${User.username}
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="/user/${User.username}">Profile</a></li>
                    <li class="divider"></li>
                    <li><a href="/user/logout">Sign Out</a></li>
                </ul>
            </div>
            <div class="nav-collapse">
                <ul class="nav">
                    <li><a href="/home">Home</a></li>
                    <li><a href="/public">Public</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container">
    <div class="row-fluid">
        <div class="span3">
            <div class="well sidebar-nav">

                <ul class="nav nav-list">

                    <legend>Popular users<span class="smalltext"></legend></li>
                    <c:forEach var='item' items='${popular}'>
                        <div class="popularimage"><img src="/static/img/Woo/${item.username}.jpg" width="56px" height="56px"><span class="tweetheader"><a href="/user/${item.username}"> @${item.username}</a> </span></div>
                    </c:forEach>

                </ul>


            </div><!--/.well -->








        </div><!--/span-->




        <div class="span9">

            <div class="row-fluid">
               <legend>${label}</legend>



                <div class="well" id="tweetList">
                    <c:forEach var='item' items='${List}'>
                        <div class="tweet">
                            <div class="span1"><span class="tweetimage"><img src="/static/img/Woo/${item.username}.jpg" height="58px" width="58px"/></span></div>
                            <div class="span11">
                                <span class="tweetheader">${item.realname}</span>(<span class="tweettext"><a href="/user/${item.username}">@${item.username}</a></span>)<br>
                                <span class="tweettext">${item.bio} </span> <br>
                                <span class="tweettext">Followers: <a href="/user/${item.username}/followers"> ${item.num_followers}</a> </span>
                                <span class="tweettext">Following: <a href="/user/${item.username}/following"> ${item.num_following}</a> </span>
                                <span class="tweettext">Tweets: ${item.num_tweets} </span>    <br>

                                <span class="reply"></span>
                            </div>
                        </div>




                    </c:forEach>

                </div><!--/span-->
            </div>
        </div>




    </div>
    <hr>

    <footer>
        <p>&copy; Company 2012</p>
    </footer>

</div><!--/.fluid-container-->

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
<script type="text/javascript" src="/static/js/bootstrap/jquery.validate.js"></script>

</body>
</html>


