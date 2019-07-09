<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>搜索</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <script type="text/javascript" src="${path}/js/layer.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/iscroll.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.flexslider-min.js"></script>
    <script type="text/javascript" src="${path}/js/hmt.js"></script>
    <script type="text/javascript" src="${path}/js/index.js"></script>
    <script type="text/javascript" src="${path}/js/swiper.min.js"></script>
    <style>
        /*body{*/
        /*background: #fafafa;*/
        /*}*/
        .hotKeyUl {
            border-radius: 5%;
        }

        .clear-history-search {
            padding: 5px;
        }
    </style>
</head>

<body>
<form id="data-form" action="${path}/goods/goodsListPage" method="post">
    <input type="hidden" id="goodsName" name="goodsName" value="${goodsName}">
    <input type="hidden" id="searchType" name="searchType" value="${searchType}">
</form>
<div id="container">
    <section class="searchBar wap">
        <div class="searchBox">
            <form>
                <input type="search" id="keyword" placeholder="搜索商品" autocomplete="off">
            </form>
        </div>
        <span class="searchBar search-button onclick-hand">搜索</span>
    </section>
    <c:if test="${fn:length(data.hot_search_history)>0}">
        <section class="hotBox">
            <div class="title">热门搜索</div>
            <ul class="hotKeyUl">
                <c:forEach items="${data.hot_search_history}" var="list">
                    <li>
                        <span>${list.type_word}</span>
                    </li>
                </c:forEach>
            </ul>
        </section>
    </c:if>
    <c:if test="${fn:length(data.user_search_history)>0}">
        <section class="hotBox">
            <div class="title">搜索历史</div>
            <ul class="hotKeyUl">
                <c:forEach items="${data.user_search_history}" var="list">
                    <li>
                        <span>${list.type_word}</span>
                    </li>
                </c:forEach>
            </ul>
        </section>
        <section class="historyBox" style="">
            <ul class="hotKeyUl">
                <li class="clear clear-history-search">清除搜索记录</li>
            </ul>
        </section>
    </c:if>
    <section class="historyBox" style="">
        <ul class="hotKeyUl">
            <li class="clear return-back">返回</li>
        </ul>
    </section>
</div>
</body>
<script type="text/javascript" src="${path}/js/onclick.js"></script>
<script>

    function alertMsgCommon(msg, time) {
        //提示
        layer.open({
            content: msg
            , skin: 'msg'
            , time: time //2秒后自动关闭
        });
    }

    function sleepReload(type) {
        if (type == 1) {
            window.location.href = "${path}/user/loginPage";
        } else {
            location.reload();
        }

    }

    $('.hotKeyUl>li>span').on('click', function (e) {
        var name = $(this).html();
        $("#goodsName").val(name);
        $("#data-form").submit();
    });
    $('.onclick-hand').on('click', function (e) {
        var name = $("#keyword").val() + "";
        // if(name.trim()==''){
        //     alertMsgCommon("输入要查询的商品名称",2)
        //     return;
        // }
        $("#goodsName").val(name.trim());
        $("#data-form").submit();
    });
    $('.clear-history-search').on('click', function () {
        $.ajax({
            type: "post",
            data: {},
            async: true,
            cache: false,
            url: "${path}/category/cleanSearchHistory",
            dataType: "json",
            success: function (data) {
                if (data.flag == 1) {
                    alertMsgCommon("操作成功", 2);
                    setTimeout("sleepReload(0)", 1000);
                } else if (data.flag == 2) {
                    alertMsgCommon('请先登录', 2)
                    setTimeout("sleepReload(1)", 1000);
                } else {
                    alertMsgCommon(data.msg, 2);
                }
            }
        });
    });

    var searchType = getQueryVariable('searchType');
    $("#searchType").val(searchType);

    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (pair[0] == variable) {
                return pair[1];
            }
        }
        return (false);
    }

</script>
</html>
