<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>设置中心</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/shezhi.css"/>
    <script type="text/javascript" src="${path}/js/layer.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/onclick.js"></script>
</head>
<body>
<!--header star-->
<header class="hasManyCity hasManyCitytwo" id="header">
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
    <div class="header-tit">
        设置中心
    </div>
</header>
<!--header end-->
<div id="container">
    <div id="main">
        <div style="width: 100%;height: 50px"></div>
        <div class="warp clearfloat">
            <div class="cashlist clearfloat">
                <ul>
                    <%--<li class="box-s">
                        <a href="${path}/sys/phone-reset-passwd">
                            <p class="fl">重置密码</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                        </a>
                    </li>--%>
                    <%--<li class="box-s">
                        <a href="${path}/sys/login-reset">
                            <p class="fl">重置密码</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                        </a>
                    </li>--%>
                    <li class="box-s" data-type="0" data-method="${userMobile}">
                        <em>手机绑定</em>
                        <i class="iconfont icon-jiantou1 fr">
                            <c:choose>
                                <c:when test="${empty userMobile || userMobile==''}">
                                    <span onclick="toBangPhone()">未绑定/去绑定</span>
                                </c:when>
                                <c:otherwise>
                                    ${userMobile}/去解绑
                                </c:otherwise>
                            </c:choose>
                        </i>
                    </li>
                    <li class="box-s" data-type="4" data-method="${snsType4}">
                        <em>微信绑定</em>
                        <c:choose>
                            <c:when test="${!empty snsType4}">
                                <i class="iconfont icon-jiantou1 fr">已绑定/去解绑</i>
                            </c:when>
                            <c:otherwise>
                                <i class="iconfont icon-jiantou1 fr">未绑定/去绑定</i>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!--footer star-->
<!--footer star-->
<footer id="footer">
    <div>
        <a href="${path}/index/main">
            <div><img src="${path}/img/foot/main-home.png" width="20px" height="20px"></div>
            <p>首页</p>
        </a>
    </div>
    <div>
        <a href="${path}/goods/goodsListPage">
            <div><img src="${path}/img/foot/shop-card.png" width="20px" height="20px"></div>
            <p>超市</p>
        </a>
    </div>
    <div>
        <a href="${path}/category/listCategoryPage">
            <div><img src="${path}/img/foot/catogry.png" width="20px" height="20px"></div>
            <p>分类</p>
        </a>
    </div>
    <%--    <div>
            <a href="coupon.html">
                <div><img src="${path}/img/foot/icon-coupon.png" width="20px" height="20px"></div>
                <p>优惠券</p>
            </a>
        </div>--%>
    <%--<div>--%>
    <%--<a href="${path}/user/shop-card">--%>
    <%--<div><img src="${path}/img/foot/shop-card.png" width="20px" height="20px"></div>--%>
    <%--<p>购物车</p>--%>
    <%--</a>--%>
    <%--</div>--%>
    <div>
        <a href="${path}/center/userCenter">
            <div><img src="${path}/img/foot/my.png" width="20px" height="20px"></div>
            <p>我的</p>
        </a>
    </div>
</footer>
</body>
<script>
    function toBangPhone() {
        window.location.href = "${path}/user/phone-bang";
    }

    $(".box-s").on('click', function (e) {
        //
        // //判断是解绑还是绑定
        // var dataMethod = $(this).attr("data-method");
        // if(dataMethod == null || dataMethod == ''){
        //     //去绑定
        // }else{
        //     //去解绑
        //
        // }

        var userMobile = '${userMobile}';
        var isBoundWX = '${snsType4}';

        var snsType = $(this).attr("data-type");
        if (snsType == 0) {
            if (userMobile == null || userMobile == '') {
                //绑定手机
                window.location.href = "${path}/setting/user/phoneBoundPage?op=add"
            } else {
                //解绑手机
                if (isBoundWX == null || isBoundWX == '') {
                    alertMsgCommon("未绑定微信,不允许解绑", 2);
                    return;
                }
                window.location.href = "${path}/setting/user/phoneBoundPage?op=delete&phone=" + userMobile;
            }
        } else if (snsType == 4) {
            if (isBoundWX == null || isBoundWX == '') {
                //绑定微信
                window.location.href = "${path}/other/weixin/toBoundWX";
            } else {
                //解绑微信
                if (userMobile == null || userMobile == '') {
                    alertMsgCommon("未绑定手机号码,不允许解绑", 2);
                    return;
                }
                layer.open({
                    content: '确定解绑微信？',
                    btn: ['确认', '取消'],
                    yes: function (index) {
                        window.location.href = "${path}/other/weixin/unBoundWXPage";
                        layer.closeAll();
                    }
                });
            }
        }
    })
    //页面提示
    var msg = '${msg}';
    if (msg != null && msg != '') {
        alertMsgCommon(msg, 2);
    }


</script>
</html>

