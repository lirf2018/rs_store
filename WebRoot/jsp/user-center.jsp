<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>个人中心</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loading.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/center.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/iscroll.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.flexslider-min.js"></script>
    <script type="text/javascript" src="${path}/js/hmt.js"></script>
    <script type="text/javascript" src="${path}/js/index.js"></script>
    <script type="text/javascript" src="${path}/js/swiper.min.js"></script>
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
    <script type="text/javascript">
        $(window).load(function () {
            $(".loading").addClass("loader-chanage")
            $(".loading").fadeOut(300)
        })
    </script>
    <style>
        body {
            line-height: 1;
        }
    </style>
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
<!--header star-->
<header class="hasManyCity hasManyCitytwo" id="header">
    <div class="header-tit">
        会员中心
    </div>
    <a href="${path}/center/settingPage" class="fr shoucang sousuo"><i class="iconfont icon-shezhi"></i></a>
</header>
<!--header end-->
<div id="container">
    <div id="main">
        <div class="warp clearfloat">
            <div class="h-top clearfloat box-s">
                <div class="tu clearfloat fl">
                    <img src="${path}/img/touxiang.png"/>
                </div>
                <div class="content clearfloat fl">
                    <p class="hname"></p>
                    <p class="htel">
                        <c:choose>
                            <c:when test="${user_mobile=='' || empty user_mobile}">
                                ${nick_name}
                            </c:when>
                            <c:otherwise>${user_mobile}</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <%--<div class="h-bottom clearfloat">
                    <samp></samp>
                    <ul>
                        <li>
                            <a href="recharge.html">
                                <p>200</p>
                                <span>余额</span>
                            </a>
                        </li>
                        <li>
                            <a href="jfguanli.html">
                                <p>${resultDate.user_jifen}</p>
                                <span>积分</span>
                            </a>
                        </li>
                        <li>
                            <a href="coupon.html">
                                <p>${resultDate.ticket_counts}</p>
                                <span>优惠券</span>
                            </a>
                        </li>
                    </ul>
                </div>--%>
            </div>
            <div class="cash clearfloat">
                <div class="cash-tit clearfloat box-s" onclick="toOrderList()">
                    <ul>
                        <li class="box-s">
                            <p class="fl">全部订单</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                        </li>
                    </ul>
                </div>
                <div class="shang clearfloat">
                    <ul>
                        <li data-value="0">
                            <div>
                                <div class="order-num">${wait_payorder}</div>
                                <img src="${path}/img/icon/group1.png"/>
                            </div>
                            <span>待付款</span>
                        </li>
                        <li data-value="1">
                            <div>
                                <div class="order-num">${ispay_order}</div>
                                <img src="${path}/img/icon/group5.png"/>
                            </div>
                            <span>已付款</span>
                        </li>
                        <li data-value="2">
                            <div>
                                <div class="order-num">${sure_order}</div>
                                <img src="${path}/img/icon/group9.png"/>
                            </div>
                            <span>确认中</span>
                        </li>
                        <li data-value="5">
                            <div>
                                <div class="order-num">${wait_getorder}</div>
                                <img src="${path}/img/icon/group3.png"/>
                            </div>
                            <span>待收货</span>
                        </li>
                        <li data-value="3">
                            <div>
                                <div class="order-num">${fail_order}</div>
                                <img src="${path}/img/icon/group11.png"/>
                            </div>
                            <span>已失败</span>
                        </li>
                    </ul>
                </div>
                <div class="shang clearfloat">
                    <ul>
                        <li data-value="9">
                            <div>
                                <div class="order-num">${watting_tuikuang}</div>
                                <img src="${path}/img/icon/group6.png"/>
                            </div>
                            <span>退款中</span>
                        </li>
                        <li data-value="10">
                            <div>
                                <div class="order-num">${is_tuikuang}</div>
                                <img src="${path}/img/icon/group10.png"/>
                            </div>
                            <span>已退款</span>
                        </li>
                        <li data-value="11">
                            <div>
                                <div class="order-num">${is_doing}</div>
                                <img src="${path}/img/icon/group9.png"/>
                            </div>
                            <span>处理中</span>
                        </li>
                        <li data-value="6">
                            <div>
                                <div class="order-num">${is_finish}</div>
                                <img src="${path}/img/icon/group7.png"/>
                            </div>
                            <span>已完成</span>
                        </li>

                    </ul>
                </div>
            </div>
            <!--
            <div class="cash cashthree clearfloat">
                <div class="cash-tit clearfloat box-s">
                    收藏关注
                </div>
                <div class="shang xia clearfloat">
                    <ul>
                        <li>
                            <a href="tuan.html">
                                <img src="img/tuan1.png"/>
                                <span>收藏</span>
                            </a>
                        </li>
                        <li>
                            <a href="mall.html">
                                <img src="img/tuan2.png"/>
                                <span>百货收藏</span>
                            </a>
                        </li>
                        <li>
                            <a href="remen.html">
                                <img src="img/tuan3.png"/>
                                <span>关注商家</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            -->
            <div class="cashlist clearfloat">
                <ul>
                    <li class="box-s">
                        <a href="${path}/car/shopCar">
                            <p class="fl">购物车</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                            <c:if test="${card_count !='0'}">
                                <div class="shop-card-count">${card_count}</div>
                            </c:if>
                        </a>
                    </li>
                    <%--<li class="box-s">
                        <a href="${path}/center/toUserAddressPage">
                            <p class="fl">收货地址</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                        </a>
                    </li>--%>
                    <li class="box-s">
                        <a href="${path}/center/query/messageListPage">
                            <p class="fl">我的消息</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                        </a>
                    </li>
                    <li class="box-s">
                        <a href="${path}/center/toServicePage">
                            <p class="fl">售后服务</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                        </a>
                    </li>
                    <li class="box-s">
                        <a href="${path}/center/suggestPageList">
                            <p class="fl">投诉建议</p>
                            <i class="iconfont icon-jiantou1 fr"></i>
                        </a>
                    </li>
                </ul>
            </div>
            <a href="${path}/user/login/out" class="center-btn db ra3">退出登录</a>
        </div>
    </div>
</div>

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
<!--footer end-->
</body>
<script>
    function toOrderList() {
        <%--window.location.href = "${path}/user/order-list"--%>
        window.location.href = "${path}/order/query/otherOrderList?orderStatus=-1";
    }

    $(".shang.clearfloat>ul>li").bind("click", function () {
        //0待付款1已付款2确认中3已失败5待收货
        var value = $(this).attr("data-value");
        window.location.href = "${path}/order/query/otherOrderList?orderStatus=" + value;
    });
</script>
</html>
