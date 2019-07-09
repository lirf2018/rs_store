<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>商品列表</title>
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
    <script type="text/javascript" src="${path }/js/iscroll-probe.js"></script>
    <style type="text/css">
        body {
            overflow: hidden;
        }

        body,
        ul {
            padding: 0;
            margin: 0;
        }

        .main {
            position: relative;
            width: 100%;
            height: 95%;
        }

        .main .warpper {
            position: absolute;
            width: 100%;
        }

        .scroller-pullDown, .scroller-pullUp {
            width: 100%;
            height: 30px;
            padding: 10px 0;
            text-align: center;
        }

        .scroller-pullUp {

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
<header class="hasManyCity" id="header">
    <div id="" class="searchBox">
        <c:choose>
            <c:when test="${searchType=='time'}"> <span>抢购商品</span></c:when>
            <c:otherwise> <span>全部商品</span></c:otherwise>
        </c:choose>
        <a href="${path}/goods/search/goodsList?current=1&searchType=${searchType}">
            <i class="icon-search"></i>
            <c:choose>
                <c:when test="${!empty goodsName}">
                    <span>${goodsName}</span>
                </c:when>
                <c:otherwise>
                    <span>请输入您想找的内容</span>
                </c:otherwise>
            </c:choose>
        </a>
    </div>
</header>
<div style="width: 100%;height: 10px">
    <input type="hidden" id="hasNext" value="0">
</div>
<div id="MyScroller" class="main">
    <div id="main" class="warpper">
        <div class="sy_recmd">
            <div class="sy_recmd_list_box">
                <ul>
                </ul>
                <div class="clear"></div>
                <div id="PullUp" class="scroller-pullUp" style="display: none;">
                    <img style="width: 20px; height: 20px;" src="${path}/js/rolling.svg"/>
                    <span id="pullUp-msg" class="pull-up-msg">上拉刷新</span>
                </div>
                <div id="bootDesc"
                     style="text-align: center;width: 100%;height: auto;padding-bottom: 10px;margin-bottom:10px;color: #999999 !important;"></div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<footer id="footer">
    <div>
        <a href="${path}/index/main">
            <div><img src="${path}/img/foot/main-home.png" width="20px" height="20px"></div>
            <p>首页</p>
        </a>
    </div>
    <div>
        <a href="${path}/goods/goodsListPage">
            <div><img src="${path}/img/foot/shop-cards.png" width="20px" height="20px"></div>
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
<script type="text/javascript">
    function appendContent(current) {
        var searchType = '${searchType}';
        var categoryIds = '${categoryIds}';
        var leve1Ids = '${leve1Ids}';
        var goodsName = '${goodsName}';
        $.ajax({
            type: "post",
            data: {
                current: current,
                searchType: searchType,
                categoryIds: categoryIds,
                leve1Ids: leve1Ids,
                goodsName: goodsName
            },
            async: false,
            cache: false,
            url: "${path}/goods/query/goodsList",
            dataType: "json",
            success: function (data) {
                $("#bootDesc").empty();
                $("#hasNext").val(0);
                if (data.flag == 1) {
                    var goodsList = data.goodsList;
                    if (goodsList.length > 0) {
                        for (var i = 0; i < goodsList.length; i++) {
                            var h = "";
                            var isSingle = goodsList[i].is_single;
                            if (isSingle == 1) {
                                h = "<li class='sy_recmd_list'>"
                                    + " <div class='box'>"
                                    + " <div class='pub_img'>"
                                    + " <a href='${path}/goods/query/goodsInfo?goodsId=" + goodsList[i].goods_id + "&isSingle=" + goodsList[i].is_single + "&timeGoodsId=" + goodsList[i].time_goods_id + "'><img  src='" + goodsList[i].goods_img + "'></a>"
                                    + " </div>"
                                    + " <div class='pub_wz'>"
                                    + " <h3 class='overflow_clear'><a href='#'>" + goodsList[i].goods_name + "</a></h3>"
                                    + " <div class='nr_box' style='padding-top: 0.05rem;'>"
                                    + " <p class='fl price fontcl2'>"
                                    + " <span class='black9'  style='font-size: .07rem'>库存" + goodsList[i].goods_num + "</span>"
                                    + " </p>"
                                    + " <p class='fr price fontcl2'><span  class='black9'>已售" + goodsList[i].shell_counts + "</span></p>"
                                    + " </div>"
                                    + " <div class='nr_box'>"
                                    + " <p class='fl fontcl2'>¥" + goodsList[i].now_money + "</p>"
                                    + " <span class='fl black9'  style='margin-left: 10px'><s>¥" + goodsList[i].true_money + "</s></span>"
                                    + " </div>"
                                    + " </div>"
                                    + " </div>"
                                    + " </li>";
                            } else {
                                h = "<li class='sy_recmd_list'>"
                                    + " <div class='box'>"
                                    + " <div class='pub_img'>"
                                    + " <a href='${path}/goods/query/goodsInfo?goodsId=" + goodsList[i].goods_id + "&isSingle=" + goodsList[i].is_single + "&timeGoodsId=" + goodsList[i].time_goods_id + "'><img  src='" + goodsList[i].goods_img + "'></a>"
                                    + " </div>"
                                    + " <div class='pub_wz'>"
                                    + " <h3 class='overflow_clear'><a href='#'>" + goodsList[i].goods_name + "</a></h3>"
                                    + " <div class='nr_box' style='padding-top: 0.05rem;'>"
                                    + " <p class='fl price fontcl2'>"
                                    + " <span class='black9'  style='font-size: .07rem'>库存 " + goodsList[i].goods_num + "</span>"
                                    + " </p>"
                                    + " <p class='fr price fontcl2'><span  class='black9'>已售" + goodsList[i].shell_counts + "</span></p>"
                                    + " </div>"
                                    + " <div class='nr_box'>"
                                    + " <p class='fl fontcl2'>¥" + goodsList[i].sku_now_money + "</p>"
                                    + " <span class='fl black9' style='margin-left: 10px'><s></s></span>"
                                    + " </div>"
                                    + " </div>"
                                    + " </div>"
                                    + " </li>";
                            }
                            $(".sy_recmd_list_box>ul").append(h);
                        }
                        if (data.hasNext == true) {
                            $("#hasNext").val(1);
                            $("#bootDesc").append("---上拉查看更多---");
                        } else {
                            $("#bootDesc").append("---我是有底线的---");
                        }
                    } else {
                        $("#bootDesc").append("---没有查询到相关商品---");
                    }
                } else {
                    alertMsg(data.msg, 2);
                    $("#bootDesc").append("---网络异常,请稍后重试---");
                }
            }
        });
    }

    window.onload = function () {

        var page = 1;

        $(".loading").addClass("loader-chanage")
        $(".loading").fadeOut(300);
        // 初始化body高度
        document.body.style.height = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';

        appendContent(page);

        var pullUp = document.querySelector("#PullUp"),
            isPulled = false; // 拉动标记

        var myScroll = new IScroll('#MyScroller', {
            probeType: 3,
            mouseWheel: true,
            scrollbars: false,
            preventDefault: false,
            fadeScrollbars: true
        });

        // ref https://github.com/WICG/EventListenerOptions/pull/30
        function isPassive() {
            var supportsPassiveOption = false;
            try {
                addEventListener("test", null, Object.defineProperty({}, 'passive', {
                    get: function () {
                        supportsPassiveOption = true;
                    }
                }));
            } catch (e) {
            }
            return supportsPassiveOption;
        }

        document.addEventListener('touchmove', function (e) {
            e.preventDefault();
        }, isPassive() ? {
            capture: false,
            passive: false
        } : false);

        myScroll.on('scroll', function () {
            var height = this.y,
                bottomHeight = this.maxScrollY - height;

            //console.log("height:" + height);
            //console.log("bottomHeight:" + bottomHeight);

            // 控制上拉显示
            if (bottomHeight >= 60) {
                pullUp.style.display = "block";
                isPulled = true;
                return;
            }
            else if (bottomHeight < 60 && bottomHeight >= 0) {
                pullUp.style.display = "none";
                return;
            }
        })

        myScroll.on('scrollEnd', function () { // 滚动结束
            if (isPulled && $("#hasNext").val() == 1) { // 如果达到触发条件，则执行加载
                isPulled = false;
                page = page + 1;
                appendContent(page);
                myScroll.refresh();
            }
        });
    }
</script>
</body>
</html>
