<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>投诉建议列表</title>
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
        .box-s {
            box-sizing: border-box;
            -webkit-box-sizing: border-box;
            display: flex;
        }
    </style>
</head>
<body>
<!--header star-->
<header class="hasManyCity hasManyCitytwo" id="header">
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
    <div class="header-tit">
        我的投诉建议
    </div>
    <div id="homeBtn" class="homeBtn"></div>
</header>
<!--header end-->
<div id="container">
    <div id="main">
        <div class="warp clearfloat">
            <div class="cashlist clearfloat">
                <ul>
                    <c:forEach items="${data.user_complain_list}" var="item">
                        <c:choose>
                            <c:when test="${item.is_read==1}">
                                <li class="box-s">
                                    <a href="${path}/center/suggestInfo?complainId=${item.id}">
                                        <div class="fl suggest-time"><i
                                                class="iconfont icon-isread-greed"> </i>${item.createtime}</div>
                                        <div class="fr suggest-title">${item.contents}</div>
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="box-s">
                                    <a href="${path}/center/suggestInfo?complainId=${item.id}">
                                        <div class="fl suggest-time"><i
                                                class="iconfont icon-isread"> </i>${item.createtime}</div>
                                        <div class="fr suggest-title">${item.contents}</div>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${fn:length(data.user_complain_list)==0}">
                        <li class="box-s">
                            <div class="suggest-time" style="text-align: center;color: grey;width: 100%">无投诉建议</div>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
    <div style="height: .5rem;width: 100%;"></div>
    <div class="suggest-bottom">
        <a href="${path}/center/toAddsuggestPage">新增投诉建议</a>
    </div>
</div>
</body>
<script type="text/javascript" src="${path}/js/onclick.js"></script>
</html>

