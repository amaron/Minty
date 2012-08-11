<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>${User.username}'s profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 110px;
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }
    </style>
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
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
            font-size:18px;
            line-height: 22px;
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
        .smalldetails {
            padding-top: 30px;
        }
        .followbutton {
            padding-top:5px;
        }
        .count {
            padding-top:20px;
            text-align: right;
            font-family: "Arial Black";
            font-size: 22px;

        }

    </style>

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="stylesheet" href="/static/css/bootstrap.css">

    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>

    <script type="text/javascript" src='/static/js/follow.js'></script>
    <script type="text/javascript" src='/static/js/addTweet.js'></script>
    <script type="text/javascript">var num_followers=${User.num_followers};</script>
    <script type="text/javascript">
        var cur_offset_tweets=10;
        var cur_handle='${User.username}';
        function getMoreMentions(){

            $.ajax({
                type: 'GET',
                url: '/user/'+cur_handle+'/getMoreUserTweets.json',
                data: $.param({ offset: cur_offset_tweets, handle: cur_handle}),
                success: function(data) {
                    if(data.length==0) $('#moreTweetsBtn').hide();
                    for(var k=0;k<data.length;k++){
                        //alert(JSON.stringify(data.List[k]));
                        appendItem(data[k]);
                    }
                    cur_offset_tweets+=data.length;
                }
            });
        }
    </script>



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
                    <i class="icon-user"></i> Username
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#">Profile</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Sign Out</a></li>
                </ul>
            </div>
            <div class="nav-collapse">
                <ul class="nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#about">Mentions</a></li>
                    <li><a href="#contact">Public</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container">
    <div class="row-fluid">
        <div class="span12">

            <div class="hero-unit">
                <div class="row fluid">
                    <div class="span2">
                        <span class="tweetimage"><img src="img/gaurav.jpg" width="128px" height="128px"/></span>
                    </div>

                    <div class="span4">
                        <legend><h2>${User.username}</h2></legend>
                        <div class="mintbio">I will stop the motor of the world. Btw try to answer, who is John Galt?</div>

                    </div>
                    <div class="span4">

                        <form class="followbutton" action="" onsubmit="follow('${handle}'); return false;">

                            <input type="submit" class="btn-success btn-large" value="${message}" name="unfollow" id="followBtn"/>

                        </form>
                        <div class="smalldetails">Mumbai - http://gauravmunjal.com - Software Engineer - Atheist - Lover boy
                        </div></div>
                    <div class="span2"><div class="count">Followers ${User.num_followers}</div>
                        <div class="count">Following ${User.num_following}</div>
                        <div class="count">Tweets ${User.num_tweets}</div>


                    </div>
                </div>
            </div>


        </div>
    </div>

    <div class="row-fluid">

        <div class="span3">
            <div class="well sidebar-nav">
                <ul class="nav nav-list">


                    <li class="active"><a href="#">Tweets</a></li>
                    <li><a href="#">Followers</a></li>
                    <li><a href="#">Following</a></li>


                </ul>


            </div><!--/.well -->






        </div><!--/span-->




        <div class="span9">
            <div class="row-fluid">




                <div class="well" id="tweetList">
                    <c:forEach var='item' items='${List}'>

                        <script type="text/javascript">
                            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'});
                        </script>
                    </c:forEach>

                    <div class="tweet" onmouseover="document.getElementById('re').style.display = 'block';" onmouseout="document.getElementById('re').style.display = 'none';">
                        <div class="span1"><span class="tweetimage"><img src="img/gaurav.jpg" height="58px" width="58px"/></span></div>
                        <div class="span11">
                            <span class="time">5 mins ago</span>

                            <span class="tweetheader">Gaurav Munjal</span><br>
                            <span class="tweettext">Hey, we are here to create a dent in the universe, otherwise, why even be here. And by the way who the fuck is John Galt? Err what the hell you are saying man!</span>
                            <span class="reply"><a id="re" href="#" style="display: none;">Reply</a></span>
                        </div>
                    </div>
                    <div class="tweet" onmouseover="this.getElementById('re').style.display = 'block';" onmouseout="this.getElementById('re').style.display = 'none';">
                        <div class="span1"><span class="tweetimage"><img src="img/gaurav.jpg" height="58px" width="58px"/></span></div>
                        <div class="span11">
                            <span class="time">5 mins ago</span>

                            <span class="tweetheader">Gaurav Munjal</span><br>
                            <span class="tweettext">Hey, we are here to create a dent in the universe, otherwise, why even be here. And by the way who the fuck is John Galt? Err what the hell you are saying man!</span>
                            <span class="reply"><a id="re" href="#" style="display: none;">Reply</a></span>
                        </div>
                    </div>

                    <!-- 				<form class="well form-inline" id="replyform">

                         Reply to @gauravmunjal <input type="text" class="input-xxlarge"/>
                         <input type="submit" class="btn-success" value="Reply"/>
                         <input type="submit" class="btn-inverse" value="Nevermind"/>

         </form>-->

                    <div class="tweet" onmouseover="document.getElementById('re').style.display = 'block';" onmouseout="document.getElementById('re').style.display = 'none';">
                        <div class="span1"><span class="tweetimage"><img src="img/gaurav.jpg" height="58px" width="58px"/></span></div>
                        <div class="span11">
                            <span class="time">5 mins ago</span>

                            <span class="tweetheader">Gaurav Munjal</span><br>
                            <span class="tweettext">Hey, we are here to create a dent in the universe, otherwise, why even be here. And by the way who the fuck is John Galt? Err what the hell you are saying man!</span>
                            <span class="reply"><a id="re" href="#" style="display: none;">Reply</a></span>
                        </div>
                    </div>
                </div><!--/span-->
            </div>
        </div>

        <div class="span9">
            <button class="btn btn-success" id="moreTweetsBtn" onclick="getMoreMentions();return false">load more...</button>
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

</body>
</html>

