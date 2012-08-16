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
    <script type="text/javascript">

        function textCounter(field,cntfield,maxlimit) {
            if (field.value.length > maxlimit)
                field.value = field.value.substring(0, maxlimit);
            else
                cntfield.value = maxlimit - field.value.length;
        }

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
    <link href="static/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 110px;
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }
    </style>
    <link href="static/css/bootstrap-responsive.css" rel="stylesheet">
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
                    <li class="active"><a href="/home">Home</a></li>
                    <li><a href="/mentions">Mentions</a></li>
                    <li><a href="/public">Public</a></li>
                </ul>
            </div><!--/.nav-collapse -->
            <form class="navbar-search pull-left" action="/search">
                <input type="text" name="searchtext" class="search-query" placeholder="Search">
            </form>
        </div>
    </div>
</div>

<div class="container">
    <div class="row-fluid">
        <div class="span3">
            <div class="well sidebar-nav">

                <ul class="nav nav-list">

                    <legend><img src="/static/img/Woo/${User.username}.jpg" width="56px" height="56px"> <a href="/user/${User.username}">@${User.username}</a></legend></li>
                    <div class="mintbio">${User.bio}</div>



                </ul>


            </div><!--/.well -->


            <form class="well" name="tweetBox" onsubmit="addTweetNow(this); this.reset(); return false;">


                <textarea class="span12" id="tweet" name ="tweet" rows="2" placeholder="Add a new Minty!" maxlength="128" onKeyDown="textCounter(document.tweetBox.tweet,document.tweetBox.remLen,128)"
                          onKeyUp="textCounter(document.tweetBox.tweet,document.tweetBox.remLen,128)"> </textarea>
                <button type="submit" class="btn btn-success" name="Mintify">Mintify</button> <input readonly type="text" name="remLen" value="128">


            </form>




        </div><!--/span-->




        <div class="span9">

            <div class="row-fluid">
             <legend>Home</legend>

                <form action="/user/getNewTweet.json" onsubmit="displayNew(this);return false">
                    <input type="submit" class="btn btn-inverse" style="display:none" value="You have new tweets!" id="updateBtn"/>
                </form>

                <div class="well" id="tweetList">

                    <c:forEach var='item' items='${List}' varStatus="loop">

                        <script type="text/javascript">
                            appendItem({tweet_id:${item.tweet_id}, tweet:"${item.tweet}", username:"${item.username}", pushtime:"${item.pushtime}"},${loop.index});
                        </script>
                    </c:forEach>


                    <div class="tweet" onmouseover="this.getElementById('re').style.display = 'block';" onmouseout="this.getElementById('re').style.display = 'none';">
                        <div class="span1"><span class="tweetimage"><img src="/static/img/minty.jpg" height="58px" width="58px"/></span></div>
                        <div class="span11">
                            <span class="time">Forever</span>

                            <span class="tweetheader">Minty</span><br>
                            <span class="tweettext">Hey ${User.realname}, Minty welcomes you! And will be there to help you throughout. </span>
                            <span class="reply"><a id="re" href="#" style="display: none;">Reply</a></span>
                        </div>
                    </div>

                    <div class="tweet" onmouseover="this.getElementById('re').style.display = 'block';" onmouseout="this.getElementById('re').style.display = 'none';">
                        <div class="span1"><span class="tweetimage"><img src="/static/img/minty.jpg" height="58px" width="58px"/></span></div>
                        <div class="span11">
                            <span class="time">Forever</span>

                            <span class="tweetheader">Minty</span><br>
                            <span class="tweettext">Check out the Public Mintline and see who the popular users are and read others' Mintees!</span>
                            <span class="reply"><a id="re" href="#" style="display: none;">Reply</a></span>
                        </div>
                    </div>

                    <div class="tweet" onmouseover="this.getElementById('re').style.display = 'block';" onmouseout="this.getElementById('re').style.display = 'none';">
                        <div class="span1"><span class="tweetimage"><img src="/static/img/minty.jpg" height="58px" width="58px"/></span></div>
                        <div class="span11">
                            <span class="time">Forever</span>

                            <span class="tweetheader">Minty</span><br>
                            <span class="tweettext">But before that, share a Mintee with Minty! Minty has been lonely for a long time. </span>
                            <span class="reply"><a id="re" href="#" style="display: none;">Reply</a></span>
                        </div>
                    </div>

                </div><!--/span-->
            </div>
            <button class="btn btn-success" id="moreTweetsBtn" onclick="getMoreTweets(this);return false">More...</button>
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
<script src="static/js/bootstrap/jquery.js"></script>
<script src="static/js/bootstrap/bootstrap-transition.js"></script>
<script src="static/js/bootstrap/bootstrap-alert.js"></script>
<script src="static/js/bootstrap/bootstrap-modal.js"></script>
<script src="static/js/bootstrap/bootstrap-dropdown.js"></script>
<script src="static/js/bootstrap/bootstrap-scrollspy.js"></script>
<script src="static/js/bootstrap/bootstrap-tab.js"></script>
<script src="static/js/bootstrap/bootstrap-tooltip.js"></script>
<script src="static/js/bootstrap/bootstrap-popover.js"></script>
<script src="static/js/bootstrap/bootstrap-button.js"></script>
<script src="static/js/bootstrap/bootstrap-collapse.js"></script>
<script src="static/js/bootstrap/bootstrap-carousel.js"></script>
<script src="static/js/bootstrap/bootstrap-typeahead.js"></script>
<script type="text/javascript" src="/static/js/bootstrap/jquery.validate.js"></script>
<script type="text/javascript" src="/static/js/bootbox.js"></script>
<script type="text/javascript" src="/static/js/bootbox.min.js"></script>

</body>
</html>
