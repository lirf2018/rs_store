<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>500</title>
    <%@ include file="../util/taglibs.jsp" %>
    <%@ include file="../util/meta.jsp" %>
    <link href="${path}/css/bootstrap.css" rel="stylesheet">
    <!-- FONT AWESOME CSS -->
    <link href="${path}/css/font-awesome.min.css" rel="stylesheet"/>
    <!-- custom CSS here -->
    <link href="${path}/css/style.css" rel="stylesheet"/>
<body>

<div class="container">
    <input type="hidden" id="error-link-value" value="500">
    <div class="row pad-top text-center">
        <div class="col-md-6 col-md-offset-3 text-center">
            <span id="error-link"></span>
            <h2>
                访问页面出现一点问题
            </h2>
        </div>
    </div>

    <div class="row text-center">
        <div class="col-md-8 col-md-offset-2">
            <h3><i class="fa fa-lightbulb-o fa-5x"></i></h3>
            <a href="${path}/index/main" class="mybtn">返回首页</a>
            <br/>
        </div>
    </div>
</div>
<!-- /.container -->

<!--Core JavaScript file  -->
<script src="${path}/js/jquery-1.10.2.js"></script>
<!--bootstrap JavaScript file  -->
<script src="${path}/js/bootstrap.js"></script>
<!--Count Number JavaScript file  -->
<script src="${path}/js/countUp.js"></script>
<!--Custom JavaScript file  -->
<script src="${path}/js/custom.js"></script>
</body>

</html>