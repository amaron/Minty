<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



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
        <legend>Get a hot and cool picture for your Minty!</legend>
        <div class="span6">



            <form:form modelAttribute="uploadItem" name="frm" method="post"
                       enctype="multipart/form-data" onSubmit="return Validate();" class="well">
                <fieldset>
                    <table>
                        <tr>

                            <td><form:input path="fileData" id="image" type="file" class="btn" /></td>
                        </tr>
                        <tr>

                            <td><br><input type="submit" value="Upload" class="btn-success"/></td>
                        </tr>
                    </table>
                </fieldset>
            </form:form>
            <form action="/home">
                <button class="btn btn-warning">Take me to my home!</button>
            </form>
        </div><!--/span-->



        <div class="span6">
            <img src="/static/img/Woo/${username}.jpg"/>
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
<script language="JavaScript">
    function Validate()
    {
        var image =document.getElementById("image").value;
        if(image!=''){
            var checkimg = image.toLowerCase();
            if (!checkimg.match(/(\.jpg|\.png|\.JPG|\.PNG|\.jpeg|\.JPEG)$/)){
                alert("Please enter  Image  File Extensions .jpg,.png,.jpeg");
                document.getElementById("image").focus();
                return false;
            }
        }
        return true;
    }
</script>


</body>
</html>

