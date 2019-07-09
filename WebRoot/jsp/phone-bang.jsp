<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>手机号码绑定/解绑</title>
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
    <style>
        a:link {
            color: white;
        }

        a:visited {
            color: white;
        }

        a:hover {
            color: white;
        }

        a:active {
            color: white;
        }
    </style>
</head>

<body>
<form action="${path}/user/submit-phone-bang" method="post" id="data-form">
    <!--header star-->
    <header class="hasManyCity hasManyCitytwo" id="header">
        <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
        <div class="header-tit">
            <c:choose>
                <c:when test="${op == 'add'}">
                    手机号码绑定
                </c:when>
                <c:otherwise>
                    手机号码解绑
                </c:otherwise>
            </c:choose>
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
                                <input type="text" value="${phone}" name="phone" id="phone"></div>
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
                        <li class="box-s box-s-sure-btn">
                            <div class="sure-btn">
                                <span>确认</span>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="pla-remind"><span>温馨提示:本平台每个手机号每天只能成功发送3条短信</span></div>
            </div>
        </div>
    </div>
</form>
</body>
<script>
    var validType = '${validType}';
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
                    phoneBoundOP(phone, phoneCode);
                } else {
                    alertMsg(data.msg, 2);
                    generateCodeAndPic();
                }
            }
        });
    });

    //手机号码解绑/绑定
    function phoneBoundOP(phone, validCode) {
        var op = '${op}';
        $.ajax({
            type: "post",
            data: {phone: phone, validCode: validCode, op: op},
            async: false,
            cache: false,
            url: "${path}/setting/user/phoneBound",
            dataType: "json",
            success: function (data) {
                if (data.flag == 1) {
                    if ("add" == op) {
                        alertMsg("绑定成功", 2);
                        setTimeout("toPage('add')", 2000);
                    } else {
                        alertMsg("解绑成功,请重新登录", 2);
                        setTimeout("toPage()", 2000);
                    }
                } else {
                    alertMsg(data.msg, 2);
                    generateCodeAndPic();
                    $("#imgCode").val("");
                }
            }
        });
    }

    function toPage(op) {
        var url = "${path}/user/login/out";
        if (op == 'add') {
            url = '${path}/center/settingPage';
        }
        window.location.href = url;
    }

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

    //发送手机验证码
    function generatePhoneCode(phone) {
        var codeDesc = "手机号码解绑";
        var op = '${op}';
        if (op == "add") {
            codeDesc = "手机号码绑定";
        }
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
        //因为上线（tomcat设置）已经去掉项目名称,所以
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