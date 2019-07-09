<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>分类</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loading.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/hmt.js"></script>
    <script type="text/javascript" src="${path}/js/index.js"></script>
    <script type="text/javascript" src="${path}/js/swiper.min.js"></script>
    <script type="text/javascript">
        $(window).load(function () {
            $(".loading").addClass("loader-chanage")
            $(".loading").fadeOut(1000)
        })
    </script>
</head>
<body>
<!--loading页开始-->
<div class="loading">
    <div class="loader">
        <div class="loader-inner pacman">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
</div>
<!--loading页结束-->
<header class="header-two" id="header">
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
    <span class="title-name">分类信息</span>
    <div id="homeBtn" class="homeBtn"></div>
</header>
<div style="height: 50px;"></div>
<div class="category clearfloat">
    <c:forEach items="${categoryLeve1RespBeanList}" var="item">
        <div class="list clearfloat fl">
            <p class="tit box-s">
                    ${item.level_name}
            </p>
            <div class="bottom clearfloat box-s">
                <ul>
                    <c:forEach items="${item.category_list}" var="itemSub">
                        <li>
                            <a href="${path}/goods/goodsListPage?current=1&searchType=hot&categoryIds=${itemSub.category_id}">${itemSub.category_name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:forEach>
    <div class="list clearfloat fl"></div>
</div>
</body>
<script type="text/javascript" src="${path}/js/onclick.js"></script>
</html>
