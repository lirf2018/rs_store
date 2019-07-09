<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>首页</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path }/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path }/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path }/css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path }/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/loading.css"/>
    <script type="text/javascript" src="${path }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path }/js/iscroll.js"></script>
    <script type="text/javascript" src="${path }/js/jquery.flexslider-min.js"></script>
    <script type="text/javascript" src="${path }/js/hmt.js"></script>
    <script type="text/javascript" src="${path }/js/index.js"></script>
    <script type="text/javascript" src="${path }/js/swiper.min.js"></script>
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
    <script type="text/javascript">
        $(window).load(function () {
            $(".loading").addClass("loader-chanage")
            $(".loading").fadeOut(300)
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
<header class="hasManyCity" id="header">
    <!--<div id="" class="cityBtn">宿州</div>-->
    <div id="" class="searchBox">
        <a href="${path}/goods/search/goodsList?searchType=sort">
            <i class="icon-search"></i>
            <span>请输入您想找的内容</span>
        </a>
    </div>
</header>
<div id="container">
    <div id="main">
        <c:if test="${fn:length(resultDate.bannel_list)>0}">
            <div id="scroller">
                <section class="banner">
                    <div class="swiper-container swiper-container1">
                        <div class="swiper-wrapper bannerwidth">
                            <c:forEach items="${resultDate.bannel_list}" var="item">
                                <div class="swiper-slide">
                                    <a href="${path}/${item.bannel_link}">
                                        <img src="${item.bannel_img}">
                                    </a>
                                </div>
                            </c:forEach>
                            <div class="swiper-pagination swiper-pagination1"></div>
                        </div>
                    </div>
                </section>
            </div>
        </c:if>
        <c:if test="${fn:length(resultDateMenu.menu01)>0}">
            <section class="slider">
                <div class="swiper-container swiper-container2">
                    <div class="swiper-wrapper tuangouwidth">
                        <div class="swiper-slide swiper-slide-duplicate">
                            <ul class="icon-list">
                                <c:forEach items="${resultDateMenu.menu01}" var="item">
                                    <li class="icon">
                                        <a href="${path}/${item.menu_url}">
                                        <span class="icon-circle">
                                            <img src="${item.menu_img}">
                                        </span>
                                            <span class="icon-desc">${item.menu_name}</span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:if test="${fn:length(resultDateMenu.menu02)>0}">
                            <div class="swiper-slide swiper-slide-duplicate">
                                <ul class="icon-list">
                                    <c:forEach items="${resultDateMenu.menu02}" var="item">
                                        <li class="icon">
                                            <a href="${path}/${item.menu_url}">
                                        <span class="icon-circle">
                                            <img src="${item.menu_img}">
                                        </span>
                                                <span class="icon-desc">${item.menu_name}</span>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${fn:length(resultDateMenu.menu03)>0}">
                            <div class="swiper-slide swiper-slide-duplicate">
                                <ul class="icon-list">
                                    <c:forEach items="${resultDateMenu.menu03}" var="item">
                                        <li class="icon">
                                            <a href="${path}/${item.menu_url}">
                                        <span class="icon-circle">
                                            <img src="${item.menu_img}">
                                        </span>
                                                <span class="icon-desc">${item.menu_name}</span>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${fn:length(resultDateMenu.menu04)>0}">
                            <div class="swiper-slide swiper-slide-duplicate">
                                <ul class="icon-list">
                                    <c:forEach items="${resultDateMenu.menu04}" var="item">
                                        <li class="icon">
                                            <a href="${path}/${item.menu_url}">
                                        <span class="icon-circle">
                                            <img src="${item.menu_img}">
                                        </span>
                                                <span class="icon-desc">${item.menu_name}</span>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                    <c:if test="${fn:length(resultDateMenu.menu02)>0}">
                        <div class="swiper-pagination swiper-pagination2"></div>
                    </c:if>
                </div>
            </section>
        </c:if>
        <c:if test="${fn:length(resultDate.time_goods_list)>0 &&resultDate.out_time_goods !='' }">
        <div id="index" class="page-center-box">
            <div>
                <!--首页限时抢购开始-->
                <div class="sy_title"><span class="left">限时抢购 &gt;&gt;</span>
                    <div class="sy_limit_buy_time left">
                        <em class="ico"></em>
                        距离结束
                        <span class="time">
                            <span>00</span>天
                            <span>00</span>时
                            <span>00</span>分
                            <span>00</span>秒
                         </span>
                    </div>
                </div>
                <div class="sy_limit_buy mb10">
                    <div class="locatLabel_switch swiper-container5 swiper-container-horizontal swiper-container-free-mode swiper-container-android">
                        <div class="swiper-wrapper">
                            <c:forEach items="${resultDate.time_goods_list}" var="item">
                                <div class="box swiper-slide">
                                    <a href="${path}/goods/query/goodsInfo?goodsId=${item.goods_id}&timeGoodsId=${item.id}&isSingle=1">
                                        <img src="${item.goods_img}" width="" height="">
                                        <p class="txt_center overflow_clear">${item.goods_name}</p>
                                        <p class="txt_center fontcl1" style="font-size: .1rem">¥${item.time_price}<span
                                                style="color: grey;margin-left: 2px;font-size: .035rem;line-height: 2px"><s>${item.now_money}</s></span>
                                        </p>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                </c:if>
                <!--首页限时抢购结束-->

                <!--热门商家-->
                <c:if test="${fn:length(resultDate.hot_goods_list)>0}">
                    <div class="sy_title">
                        <span class="left">商城热销</span>
                        <a href="${path}/goods/goodsListPage?current=1&searchType=hot"
                           class="fr morethree">更多&gt;&gt;</a>
                    </div>
                    <div class="sy_hot_seller">
                        <div class="sy_limit_buy mb10">
                            <div class="locatLabel_switch swiper-container6 swiper-container-horizontal swiper-container-free-mode swiper-container-android">
                                <div class="swiper-wrapper">
                                    <c:forEach items="${resultDate.hot_goods_list}" var="item">
                                        <div class="box swiper-slide">
                                            <a href="${path}/goods/query/goodsInfo?goodsId=${item.goods_id}&isSingle=${item.is_single}&timeGoodsId=0">
                                                <img src="${item.goods_img }">
                                                <p class="txt_center overflow_clear">${item.goods_name }</p>
                                                <p class="fontcl2" style="font-size: .08rem">
                                                    已售${item.shell_counts } </p>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!--热门商家end-->

                <!--广告轮播-->
                <c:if test="${fn:length(resultDate.activity_list)>0}">
                    <div class="flexslider">
                        <ul class="slides">
                            <c:forEach items="${resultDate.activity_list}" var="item">
                                <li>
                                    <a href="${path}/${item.activity_link }">
                                        <img src="${item.activity_img }">
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <!--广告轮播end-->
                <!--专享推荐-->
                <c:if test="${fn:length(resultDate.sort_goods_list)>0}">
                    <div class="sy_title mb10 mt10">
                        <span class="left">专享推荐</span>
                        <a href="${path}/goods/goodsListPage?current=1&searchType=sort"
                           class="fr morethree">更多&gt;&gt;</a>
                    </div>
                    <div class="sy_recmd">
                        <div class="sy_recmd_list_box">
                            <ul>
                                <c:forEach items="${resultDate.sort_goods_list}" var="item">
                                    <c:if test="${item.is_single=='1'}">
                                        <li class="sy_recmd_list">
                                            <div class="box">
                                                <div class="pub_img">
                                                    <a href="${path}/goods/query/goodsInfo?goodsId=${item.goods_id}&isSingle=${item.is_single}&timeGoodsId=0"><img
                                                            src="${item.goods_img }"></a>
                                                </div>
                                                <div class="pub_wz">
                                                    <h3 class="overflow_clear"><a href="#">${item.goods_name }</a></h3>
                                                    <div class="nr_box" style="padding-top: 0.05rem;">
                                                        <p class="fl price fontcl2">
                                                            <span class="black9"
                                                                  style="font-size: .07rem">库存${item.goods_num }</span>
                                                        </p>
                                                        <p class="fr price fontcl2"><span
                                                                class="black9">已售${item.shell_counts }</span></p>
                                                    </div>
                                                    <div class="nr_box">
                                                        <p class="fl fontcl2">¥${item.now_money }</p>
                                                        <span class="fl black9"
                                                              style="margin-left: 10px"><s>¥${item.true_money }</s></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:if>
                                    <c:if test="${item.is_single=='0'}">
                                        <li class="sy_recmd_list">
                                            <div class="box">
                                                <div class="pub_img">
                                                    <a href="${path}/goods/query/goodsInfo?goodsId=${item.goods_id}&isSingle=${item.is_single}&timeGoodsId=0"><img
                                                            src="${item.goods_img }"></a>
                                                </div>
                                                <div class="pub_wz">
                                                    <h3 class="overflow_clear"><a href="#">${item.goods_name }</a></h3>
                                                    <div class="nr_box" style="padding-top: 0.05rem;">
                                                        <p class="fl price fontcl2">
                                                            <span class="black9"
                                                                  style="font-size: .07rem">库存${item.goods_num }</span>
                                                        </p>
                                                        <p class="fr price fontcl2"><span
                                                                class="black9">已售${item.shell_counts }</span></p>
                                                    </div>
                                                    <div class="nr_box">
                                                        <p class="fl fontcl2">¥${item.sku_now_money }</p>
                                                        <span class="fl black9" style="margin-left: 10px"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                            <div class="clear"></div>
                        </div>
                    </div>
                </c:if>
                <!--专享推荐end-->
                <!--新品专区-->
                <c:if test="${fn:length(resultDate.new_goods_list)>0}">
                    <div class="sy_title mb10 mt10">
                        <span class="left">新品专区</span>
                        <a href="${path}/goods/goodsListPage?current=1&searchType=new"
                           class="fr morethree">更多&gt;&gt;</a>
                    </div>
                    <div class="sy_recmd">
                        <div class="sy_recmd_list_box">
                            <ul>
                                <c:forEach items="${resultDate.new_goods_list}" var="item">
                                    <c:if test="${item.is_single=='1'}">
                                        <li class="sy_recmd_list">
                                            <div class="box">
                                                <div class="pub_img">
                                                    <a href="${path}/goods/query/goodsInfo?goodsId=${item.goods_id}&isSingle=${item.is_single}&timeGoodsId=0"><img
                                                            src="${item.goods_img }"></a>
                                                </div>
                                                <div class="pub_wz">
                                                    <h3 class="overflow_clear"><a href="#">${item.goods_name }</a></h3>
                                                    <div class="nr_box" style="padding-top: 0.05rem;">
                                                        <p class="fl price fontcl2">
                                                            <span class="black9"
                                                                  style="font-size: .07rem">库存${item.goods_num }</span>
                                                        </p>
                                                        <p class="fr price fontcl2"><span
                                                                class="black9">已售${item.shell_counts }</span></p>
                                                    </div>
                                                    <div class="nr_box">
                                                        <p class="fl fontcl2">¥${item.now_money }</p>
                                                        <span class="fl black9"
                                                              style="margin-left: 10px"><s>¥${item.true_money }</s></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:if>
                                    <c:if test="${item.is_single=='0'}">
                                        <li class="sy_recmd_list">
                                            <div class="box">
                                                <div class="pub_img">
                                                    <a href="${path}/goods/query/goodsInfo?goodsId=${item.goods_id}&isSingle=${item.is_single}&timeGoodsId=0"><img
                                                            src="${item.goods_img }"></a>
                                                </div>
                                                <div class="pub_wz">
                                                    <h3 class="overflow_clear"><a href="#">${item.goods_name }</a></h3>
                                                    <div class="nr_box" style="padding-top: 0.05rem;">
                                                        <p class="fl price fontcl2">
                                                            <span class="black9"
                                                                  style="font-size: .07rem">库存${item.goods_num }</span>
                                                        </p>
                                                        <p class="fr price fontcl2"><span
                                                                class="black9">已售${item.shell_counts }</span></p>
                                                    </div>
                                                    <div class="nr_box">
                                                        <p class="fl fontcl2">¥${item.sku_now_money }</p>
                                                        <span class="fl black9" style="margin-left: 10px"><s></s></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                            <div class="clear"></div>
                            <div style="text-align: center;width: 100%;height: auto;padding-bottom: 10px;margin-bottom:10px;color: #999999 !important;">
                                <a href="${path}/goods/goodsListPage?current=1&searchType=sort" class="bottom-a">---新爱的, 下面没有东西啦---点击查看更多---</a>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!--新品专区end-->
            </div>
        </div>
    </div>
</div>
<footer id="footer">
    <div>
        <a href="${path}/index/main">
            <div><img src="${path}/img/foot/main-homes.png" width="20px" height="20px"></div>
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
    <%--<div>
        <a href="${path}/user/shop-card">
            <div><img src="${path}/img/foot/shop-card.png" width="20px" height="20px"></div>
            <p>购物车</p>
        </a>
    </div>--%>
    <div>
        <a href="${path}/center/userCenter">
            <div><img src="${path}/img/foot/my.png" width="20px" height="20px"></div>
            <p>我的</p>
        </a>
    </div>
</footer>
</body>
<script language="javascript" type="text/javascript">
    beginTimeGoods();

    function beginTimeGoods() {
        var passTime = '${resultDate.out_time_goods}';
        if ("" == passTime) {
            return;
        }
        go(passTime);
    }

    // 倒计时
    var _ordertimer = null;
    var data = new Date();

    function leftTimer(enddate) {
        var leftTime = (new Date(enddate)) - new Date(); //计算剩余的毫秒数
        var days = parseInt(leftTime / 1000 / 60 / 60 / 24, 10); //计算剩余的天数
        var hours = parseInt(leftTime / 1000 / 60 / 60 % 24, 10); //计算剩余的小时
        var minutes = parseInt(leftTime / 1000 / 60 % 60, 10);//计算剩余的分钟
        var seconds = parseInt(leftTime / 1000 % 60, 10);//计算剩余的秒数
        days = checkTime(days);
        hours = checkTime(hours);
        minutes = checkTime(minutes);
        seconds = checkTime(seconds);
        if (days >= 0 || hours >= 0 || minutes >= 0 || seconds >= 0) {
//            document.getElementById("timer").innerHTML = days + "天" + hours + "小时" + minutes + "分" + seconds + "秒";
            $(".time>span:nth-child(1)").html(days);
            $(".time>span:nth-child(2)").html(hours);
            $(".time>span:nth-child(3)").html(minutes);
            $(".time>span:nth-child(4)").html(seconds);
        }
        if (days <= 0 && hours <= 0 && minutes <= 0 && seconds <= 0) {
            window.clearInterval(_ordertimer);
            _ordertimer = null;
        }
    }

    function checkTime(i) { //将0-9的数字前面加上0，例1变为01
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }

    function go(v) {
        var date1 = new Date(), data2 = new Date(v);
        if (data2 < date1) return;//设置的时间小于现在时间退出
        _ordertimer = setInterval(function () {
            leftTimer(data2)
        }, 1000);
    }

</script>
<script type="text/javascript" src="${path}/js/index-activity.js" charset="utf-8"></script>
</html>
