<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>消息详情</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/suggest.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/iscroll.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.flexslider-min.js"></script>
    <script type="text/javascript" src="${path}/js/hmt.js"></script>
    <script type="text/javascript" src="${path}/js/index.js"></script>
    <script type="text/javascript" src="${path}/js/swiper.min.js"></script>
    <style>
        .cashlist ul li p {
            font-size: .13rem;
            color: #333333;
        }
    </style>
</head>

<body>
<!--header star-->
<header class="hasManyCity hasManyCitytwo" id="header">
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
    <div class="header-tit">
        消息详情
    </div>
    <div id="homeBtn" class="homeBtn"></div>
</header>
<!--header end-->
<div id="container">
    <div id="main">
        <div class="warp clearfloat">
            <div class="cashlist clearfloat">
                <ul>
                    <li class="box-s">
                        <p class="fl">${data.user_news_info.news_title}</p>
                        <c:choose>
                            <c:when test="${data.user_news_info.is_read==1}">
                                <i class="iconfont icon-isread-greed fr">已处理</i>
                            </c:when>
                            <c:otherwise>
                                <i class="iconfont icon-isread fr">未处理</i>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </div>
        </div>
        <div class="warp clearfloat">
            <div class="contents">
                ${data.user_news_info.contents}
            </div>
        </div>
        <div class="warp clearfloat">
            <div class="cashlist clearfloat">
                <ul>
                    <div class="suggest-info">
                        <div class="suggest-info-time">${data.user_news_info.createtime}</div>
                    </div>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="${path}/js/onclick.js"></script>
</html>