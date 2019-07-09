<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>新增投诉建议</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/suggest.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/iscroll.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.flexslider-min.js"></script>
    <script type="text/javascript" src="${path}/js/hmt.js"></script>
    <script type="text/javascript" src="${path}/js/index.js"></script>
    <script type="text/javascript" src="${path}/js/swiper.min.js"></script>
    <script type="text/javascript" src="${path}/js/layer.js"></script>
</head>

<body>
<!--header star-->
<header class="hasManyCity hasManyCitytwo" id="header">
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
    <div class="header-tit">
        投诉建议
    </div>
    <div id="homeBtn" class="homeBtn"></div>
</header>
<!--header end-->
<div id="container">
    <div id="main">
        <div class="warp clearfloat">
            <div class="cashlist clearfloat">
                <ul>
                    <div class="suggest-info">
                        <div class="suggest-info-title-add">
                            <span style="color: red">*</span>联系方式: <input placeholder="输入联系方式" type="text" value=""
                                                                          maxlength="20" name="information"
                                                                          id="information">
                        </div>
                    </div>
                </ul>
            </div>
        </div>
        <div class="contents-textarea">
            <textarea rows="15" placeholder="输入内容" maxlength="555" name="contents" id="contents"></textarea>
        </div>
        <div style="height: .5rem;width: 100%;"></div>
        <div class="suggest-bottom">
            <span class="submit-add" onclick="addSuggest()">提交</span>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="${path}/js/onclick.js"></script>
</html>
<script>
    function addSuggest() {
        var information = $("#information").val() + "";
        var contents = $("#contents").val() + "";
        if (information.trim() == '') {
            alertMsg("联系方式不能为空", 2);
            return;
        }
        if (contents.trim() == '') {
            alertMsg("内容不能为空", 2);
            return;
        }

        $.ajax({
            type: "post",
            data: {information: information, contents: contents},
            async: false,
            cache: false,
            url: "${path}/center/add/suggest",
            dataType: "json",
            success: function (data) {
                if (data.flag == 1) {
                    alertMsg("提交成功,即将跳转到列表页面", 2);
                    setTimeout("toPage()", 2000);
                } else if (data.flag == 2) {
                    alertMsg("用户未登录", 2);
                } else {
                    alertMsg(data.msg, 2);
                }
            }
        });
    }

    function toPage() {
        window.location.href = "${path}/center/suggestPageList";
    }

    function alertMsg(msg, time) {
        //提示
        layer.open({
            content: msg
            , skin: 'msg'
            , time: time //2秒后自动关闭
        });
    }
</script>