<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>下单结果</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <meta name="viewport"
          content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta name="format-detection" content="address=no">
    <link rel="stylesheet" type="text/css" href="${path }/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path }/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path }/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path }/css/order-success.css">
    <style>
        a:link {
            color: #999999
        }

        a:visited {
            color: #999999
        }

        a:hover {
            color: #999999
        }

        a:active {
            color: #999999
        }

    </style>
</head>
<body>
<c:choose>
    <c:when test="${!empty orderNum}">
        <div class="order-div order-success">
            <img src="${path}/img/gou.png" width="50px" height="50px"/>
            <span> 下单成功 </span>
            <div class="order-num">
                <span>订单号：</span>
                <span>${orderNum}</span>
            </div>
            <div class="my-order"><a href="${path}/order/query/orderDetail?orderNo=${orderNum}">查看订单详情 &gt;</a></div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="order-div order-fail">
            <img src="${path}/img/cha.png" width="50px" height="50px"/>
            <span>下单失败：网络异常</span>
        </div>
    </c:otherwise>
</c:choose>
<div style="width: 100%;height: 30px;"></div>
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
            <div><img src="${path}/img/foot/mys.png" width="20px" height="20px"></div>
            <p>我的</p>
        </a>
    </div>
</footer>
</body>
</html>
