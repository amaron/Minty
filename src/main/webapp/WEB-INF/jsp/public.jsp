<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Latest Tweets on Minty!</title>
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
    <link rel="stylesheet" href="/static/css/easyNotification.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/ejs_production.js"></script>
    <script type="text/javascript" src="/static/js/timeDifference.js"></script>
    <script type="text/javascript" src="/static/js/appendItem.js"></script>
    <script type="text/javascript" src="/static/js/getJSTimestamp.js"></script>
    <script type="text/javascript" src="/static/js/easy.notification.js"></script>
    <script type="text/javascript" src='/static/js/follow.js'></script>
    <script type="text/javascript" src='/static/js/addTweet.js'></script>
    <script type="text/javascript">var num_followers=${User.num_followers};</script>
    <script type="text/javascript">
        var cur_offset=10;
        function getMorePublicTweets(){

            $.ajax({
                type: 'GET',
                url: '/getMorePublicTweets.json',
                data: { offset: cur_offset },
                success: function(data) {
                    if(data.length==0) $('#moreTweetsBtn').hide();
                    for(var k=0;k<data.length;k++){
                        //alert(JSON.stringify(data.List[k]));
                        appendItem(data[k]);
                    }
                }
            });
            cur_offset+=10;


            }
    </script>

    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
</head>

<body>

<div class="navbar navbar-fixed-top" >
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="#">Minty</a>

            <div class="nav-collapse">
                <ul class="nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="/user/login">Login</a></li>
                    <li><a href="/public">Public</a></li>
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

                    <div class="span4">
                    Already a Minty member? Login to start tweeting! <a class="btn btn-success" href="/user/login"></a>

                    Not on Minty? You can be tweeting on Minty too! Just take 2 mins to signup! <a class="btn btn-success" href="/user/register"></a>
                    </div>

                </div>
            </div>


        </div>
    </div>


        <div class="span9">
            <div class="row-fluid">



                <div class="well" id="tweetList">
                    <c:forEach var='item' items='${List}'>

                        <script type="text/javascript">
                            appendItem({tweet_id:${item.tweet_id}, tweet:'${item.tweet}', username:'${item.username}', pushtime:'${item.pushtime}'});
                        </script>
                    </c:forEach>

                </div><!--/span-->
            </div>
        </div>


    <div class="span9">
        <button class="btn btn-success" id="moreTweetsBtn" onclick="getMorePublicTweets();return false">load more...</button>
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

