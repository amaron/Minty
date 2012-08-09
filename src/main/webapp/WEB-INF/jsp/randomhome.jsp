<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
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
    <script type="text/javascript" src="/static/js/bootstrapJS/jquery.validate.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/easyNotification.css">
    <link rel="stylesheet" href="static/css/charCount.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/easy.notification.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/charCount.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript" src="/static/js/getUpdates.js"></script>
    <script type="text/javascript" src="/static/js/addTweet.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getMoreTweets.js"></script>
    <script type="text/javascript" src="/static/js/displayNew.js"></script>
    <script type="text/javascript" src="/static/js/escapeHTML.js"></script>
    <meta charset="utf-8">
    <title>Bootstrap, from Twitter</title>
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
                    <li><a href="#">Profile</a></li>
                    <li class="divider"></li>
                    <li><a href="/user/logout">Logout</a></li>
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
        <div class="span3">
            <div class="well sidebar-nav">
                <ul class="nav nav-list">

                    <legend>Gaurav Munjal<span class="smalltext"><a href="View my profile">View my profile</a></span></legend></li>
                    <div class="mintbio">We are here to create a dent in the universe, otherwise, why even be here.</div>



                </ul>


            </div><!--/.well -->

            <form class="well"  onsubmit="addTweet(this); return false;">



                <textarea class="span12" id="tweet" name="tweet" rows="2" placeholder="Add a new Minty!"></textarea>
                <input type="submit" class="btn btn-success" value="Tweet"><span class="charleft">128</span>

            </form>





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




    </div>
    <hr>

    <footer>
        <p>&copy; Company 2012</p>
    </footer>

</div><!--/.fluid-container-->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->


</body>
</html>
