<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>重置密码</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/shezhi.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/posswd-update.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/slider.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/iscroll.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.flexslider-min.js"></script>
    <script type="text/javascript" src="${path}/js/hmt.js"></script>
    <script type="text/javascript" src="${path}/js/index.js"></script>
    <script type="text/javascript" src="${path}/js/swiper.min.js"></script>
    <script type="text/javascript" src="${path}/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layer.js"></script>
</head>

<body>
<form action="${path}/user/login/phoneResetPdResult" method="post" id="data-form">
    <!--header star-->
    <header class="hasManyCity hasManyCitytwo" id="header">
        <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
        <div class="header-tit">
            重置密码
        </div>
    </header>
    <!--header end-->
    <div id="container">
        <div id="main">
            <div class="warp clearfloat">
                <div class="cashlist clearfloat">
                    <div></div>
                    <ul>
                        <li class="box-s">
                            <div class="ui-input-text"><span>手机号码：</span>
                                <input type="text" value="${phone}" name="phone" id="phone">
                            </div>
                        </li>
                        <li class="box-s">
                            <div class="ui-input-text">
                                <!--	<div class="stage">-->
                                <div class="slider" id="slider">
                                    <div class="label"> 滑动获取图形码/随机码</div>
                                    <div class="track" id="track">
                                        <div class="bg-green"></div>
                                    </div>
                                    <div class="button" id="btn">
                                        <div class="icon" id="icon"></div>
                                        <div class="spinner" id="spinner"></div>
                                    </div>
                                </div>
                                <!--</div>-->
                            </div>
                        </li>
                        <li class="box-s">
                            <div class="ui-input-text">
                                <span>验证码：</span>
                                <input class="ui-input-text-code" type="text" value="" name="phoneCode" id="phoneCode"
                                       maxlength="4">
                                <span class="get-phone-code">获取验证码</span>
                            </div>
                        </li>
                        <li class="box-s">
                            <div class="ui-input-text"><span>图形码：</span>
                                <input class="ui-input-text-code" type="text" value="" name="imgCode" id="imgCode"
                                       maxlength="4">
                                <span class="get-img-code">
                                    <img class="get-img-code-img" onclick="generateCodeAndPic()"
                                         src="${path}/img/nullcode.jpg" width="75px" height="30px" alt="验证码"/>
                                </span>
                            </div>
                        </li>
                        <li class="box-s">
                            <div class="ui-input-text"><span>密码：</span><input type="password" value="" name="newPasswd"
                                                                              id="newPasswd">
                            </div>
                        </li>
                        <li class="box-s">
                            <div class="ui-input-text"><span>密码确认：</span><input type="password" value=""
                                                                                name="newPasswd2" id="newPasswd2">
                            </div>
                        </li>
                        <li class="box-s box-s-sure-btn">
                            <div class="sure-btn">
                                <span>确认</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
<script>
    var validType = 3;
    var conNum = 80;
    var countdown = conNum;
    $(".sure-btn").on('click', function (e) {

        var phone = $("#phone").val() + "";
        if (phone.trim() == '') {
            alertMsg("手机号码不能为空", 2);
            return;
        }
        var phoneCode = $("#phoneCode").val() + "";
        if (phoneCode.trim() == '') {
            alertMsg("验证码不能为空", 2);
            return;
        }
        var imgCode = $("#imgCode").val() + "";
        if (imgCode.trim() == '') {
            alertMsg("图形码不能为空", 2);
            return;
        }
        var newPasswd = $("#newPasswd").val() + "";
        if (newPasswd.trim() == '') {
            alertMsg("密码不能为空", 2);
            return;
        }
        var newPasswd2 = $("#newPasswd2").val() + "";
        if (newPasswd2.trim() != newPasswd.trim()) {
            alertMsg("两次输入密码不相等", 2);
            return;
        }
        //检验随即码和图形码
        $.ajax({
            type: "post",
            data: {phone: phone, imgCode: imgCode, phoneCode: phoneCode, validType: validType},
            async: false,
            cache: false,
            url: "${path}/ajax/check/allCode",
            dataType: "json",
            success: function (data) {
                if (data.flag == 1) {
                    //提交重置信息
                    $("#data-form").submit();
                } else {
                    alertMsg(data.msg, 2);
                    generateCodeAndPic();
                }
            }
        });

    });
    $(".get-phone-code").on('click', function (e) {
        if (flag == 1) {
            alertMsg("先向右滑动验证", 2);
            return;
        }
        var phone = $("#phone").val() + "";
        if (phone.trim() == '') {
            alertMsg("手机号码不能为空", 2);
            return;
        }
        if (conNum != countdown) {
            return;
        }
        //发送手机验证码
        generatePhoneCode(phone);
    });

    function settime(obj) { //发送验证码倒计时
        if (countdown == 0) {
            /*obj.attr('disabled', false);*/
            obj.html("获取验证码");
            countdown = conNum;
            return;
        } else {
            obj.html("重新发送(" + countdown + ")");
            countdown--;
        }
        setTimeout(function () {
            settime(obj)
        }, 1000)
    }

    //生成手机随机码
    function generatePhoneCode(phone) {
        var codeDesc = "手机密码重置";
        $.ajax({
            type: "post",
            data: {phone: phone, codeDesc: codeDesc, validType: validType},
            async: false,
            cache: false,
            url: "${path}/ajax/phone/generatePhoneCode",
            dataType: "json",
            success: function (data) {
                if (data.flag == 1) {
                    //倒计时
                    var obj = $(".get-phone-code");
                    alertMsg("手机验证码已发送", 2);
                    settime(obj);
                } else {
                    alertMsg(data.msg, 2);
                }
            }
        });
    }
</script>
</html>
<script>
    //生成图形码
    function generateCodeAndPic() {
        if (flag == 1) {
            alertMsg("先向右滑动验证", 2);
            return;
        }
        var urlImg = "${path}/image.image?time=" + new Date();
        $(".get-img-code-img").attr('src', urlImg);
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
<script>
    var oBtn = document.getElementById('btn');
    var oW, oLeft;
    var oSlider = document.getElementById('slider');
    var oTrack = document.getElementById('track');
    var oIcon = document.getElementById('icon');
    var oSpinner = document.getElementById('spinner');
    var flag = 1;

    oBtn.addEventListener('touchstart', function (e) {
        if (flag == 1) {
            /*console.log(e);*/
            var touches = e.touches[0];
            oW = touches.clientX - oBtn.offsetLeft;
            oBtn.className = "button";
            oTrack.className = "track";
        }

    }, false);

    oBtn.addEventListener("touchmove", function (e) {
        if (flag == 1) {
            var touches = e.touches[0];
            oLeft = touches.clientX - oW;
            if (oLeft < 0) {
                oLeft = 0;
            } else if (oLeft > oSlider.clientWidth - oBtn.clientWidth) {
                oLeft = oSlider.clientWidth - oBtn.clientWidth;
            }
            oBtn.style.left = oLeft + "px";
            oTrack.style.width = oLeft + 'px';
        }

    }, false);

    oBtn.addEventListener("touchend", function () {
        if (oLeft >= (oSlider.clientWidth - oBtn.clientWidth)) {
            oBtn.style.left = (document.documentElement.clientWidth - oBtn.offsetWidth - 30);
            oTrack.style.width = (document.documentElement.clientWidth - oBtn.offsetWidth - 30);
            oIcon.style.display = 'none';
            oSpinner.style.display = 'block';
            flag = 0;
            generateCodeAndPic();
        } else {
            oBtn.style.left = 0;
            oTrack.style.width = 0;
        }
        oBtn.className = "button-on";
        oTrack.className = "track-on";
    }, false);

</script>