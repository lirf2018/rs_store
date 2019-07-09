<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>微信绑定</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/shezhi.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/posswd-update.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/iscroll.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.flexslider-min.js"></script>
    <script type="text/javascript" src="${path}/js/hmt.js"></script>
    <script type="text/javascript" src="${path}/js/index.js"></script>
    <script type="text/javascript" src="${path}/js/swiper.min.js"></script>
    <script type="text/javascript" src="${path}/js/jquery-1.10.1.min.js"></script>
</head>

<body>
<!--header star-->
<header class="hasManyCity hasManyCitytwo" id="header">
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
    <div class="header-tit">
        微信绑定
    </div>
</header>
<!--header end-->
<div id="container">
    <div id="main">
        <div class="warp clearfloat">
            <div class="cashlist clearfloat">
                <ul>
                    <li class="box-s">
                        <div class="ui-input-text"><span>绑定结果</span></div>
                    </li>
                    <li class="box-s">
                        <span style="font-size: 14px;color: red;">${desc}</span>
                    </li>
                    <li class="box-s box-s-sure-btn">
                        <div class="sure-btn">
                            <span>返回</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(".sure-btn>span").on('click', function (e) {
        window.location.href = "${path}/setting/settingPage";
    });
</script>

</html>
