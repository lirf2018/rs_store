<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/login.css"/>
    <link rel="stylesheet" href="${path}/js/need/layer.css"/>
    <script type="text/javascript" src="${path}/js/jquery-1.10.1.min.js"></script>
    <style>
        .other-login-div {
            text-align: center;
            clear: both;
            margin: .3rem 0;
            padding: 20px 0;
            position: absolute;
            bottom: 0px;
            width: 100%;
        }

        .other-login {
            display: block;
            text-align: center;
            color: #06c1ae;
        }

        .other-login-show > div {
            /*text-align: center;*/
            font-size: 14px;
            display: flex;
            color: grey;
            padding: 14px;
        }

        .other-login-show > div:not(:last-child) {
            border-bottom: 1px solid grey;
        }

        .other-login-show > div > span {
            display: block;
        }

        .other-login-show > div > span > img {
            width: auto;
        }

        .other-login-show > div > span:nth-child(2) {
            padding-left: 15px;
        }

        .other-login-show > div > span:last-child {
            position: absolute;
            right: 15px;
            font-size: 18px;
        }

        .other-login-show > div > span:not(:first-child) {
            line-height: 30px;
        }
    </style>
</head>
<body>
<form action="${path}/user/login" method="post">
    <div class="login-body">
        <div class="all-style returnback cancel"><a href="${path}/sys/main">首页</a></div>
        <div class="all-style div-login"><h1>登录账号</h1></div>
        <div class="all-style div-login-name"><input type="text" value="" placeholder="手机号码" id="loginName"></div>
        <div class="all-style div-login-name"><input type="password" value="" placeholder="密码" id="loginPasswd"></div>
        <div class="all-style div-login-btn"><span>登录</span></div>
        <div class="all-style bottom-style">
            <span><a href="${path}/user/login/phoneResetPassWd">重置密码</a></span>
            <span><a href="${path}/user/login/phoneRegister">注册</a></span>
        </div>
        <div class="other-login-div">
            <div class="other-login">
                <span>其它账号登录&gt;&gt;</span>
            </div>
        </div>
    </div>
</form>
<script>
    $(".all-style.div-login-btn").on('click', function (e) {
        var loginName = $("#loginName").val() + "";
        var loginPasswd = $("#loginPasswd").val() + "";
        if (loginName.trim() == '' || loginPasswd.trim() == '') {
            alertMsg("账号密码不能为空", 2);
            return;
        }
        $.ajax({
            type: "post",
            data: {loginName: loginName, loginPasswd: loginPasswd},
            async: false,
            cache: false,
            url: "${path}/user/login",
            dataType: "json",
            success: function (data) {
                if (data.flag == '1') {
                    alertMsg("登录成功", 3);
                    window.location.href = data.toUrl;
                } else {
                    alertMsg(data.msg, 2);
                }
            }
        });
    });

    function alertMsg(msg, time) {
        //提示
        layer.open({
            content: msg
            , skin: 'msg'
            , time: time //2秒后自动关闭
        });
    }

    $(".other-login>span").on('click', function (e) {
        var accountPay = "<div data-value='4'  data-name='微信登录' onclick='weixinLogin()'>" +
            "   <span><img src='../img/wechat36x36.png' width='30px' height='30px'></span>" +
            "   <span>微信登录</span>" +
            "   <span>&gt;</span>" +
            "</div>";

        var payHtml = accountPay;

        // payHtml = nowPay+weixin+aliPay+noPay+otherPay+accountPay;

        var html = "<div class='other-login-show'><div class='other-login-title'><span>第三方账号登录</span><span onclick='closeX()'>X</span></div>" + payHtml + "</div>";

        var payLayer = layer.open({
            type: 1
            , content: html
            , anim: 'up'
            , shadeClose: false
            , style: 'position:fixed; bottom:0; left:0; width: 100%;  padding:0px 0; border:none;'
        });
    });

    function closeX() {
        layer.closeAll();
    }

    function weixinLogin() {
        window.location.href = "${path}/other/weixin/loginPage";
    }

    //页面提示
    var msg = '${msg}';
    if (msg != null && msg != '') {
        alertMsgCommon(msg, 2);
    }
</script>
</body>
<script type="text/javascript" src="${path}/js/layer.js"></script>
</html>
