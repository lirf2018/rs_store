<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单列表</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loading.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/order-comfirm.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/order-list.css"/>
    <link rel='stylesheet' type="text/css" href='${path}/css/swiper.min.css'>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path }/js/iscroll-probe.js"></script>
    <script type="text/javascript" src="${path}/js/layer.js"></script>
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
            height: 88%;
            margin-top: 10px;
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
    <script type="text/javascript">$(window).load(function () {
        $(".loading").addClass("loader-chanage");
        $(".loading").fadeOut(200)
    });</script>
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
<header class="header-two" id="header">
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i>${statusName}</a>
    <span class="title-name">订单列表</span>
    <div id="homeBtn" class="homeBtn"></div>
</header>
<div class="clear-header"></div>
<div id="container" class="main">
    <div id="main" class="warpper">
        <div class="swiper-container favor-list">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <div class="orderlist">
                        <c:forEach items="${data.order_list}" var="order">
                            <div class="orderpage" data-orderno="${order.order_no}" id="${order.order_no}">
                                <article class="nopadding">
                                    <div class="shop-name" data-orderno="${order.order_no}">
                                        <i class="iconfont icon-shoplogo fl"></i><span
                                            style="color: grey;font-size: 13px">&nbsp;${order.partners_name}</span>
                                    </div>
                                    <div class="clearx"></div>
                                    <em class="flag">${order.order_status_name}</em>
                                    <div style="width: 100%;border-bottom: 1px dashed  #D1D1D1"></div>
                                    <c:forEach items="${order.order_detail}" var="detail">
                                    <span class="Orgoods" data-orderno="${order.order_no}">
                                        <span><img src="${detail.goods_img}"></span>
                                        <span class="message">
                                            <span>${detail.goods_name}</span>
                                            <i>${detail.goods_spec_name_str}</i>
                                        </span>
                                        <span class="price">
                                            <b><i class="pr">￥</i>${detail.sale_money}</b>
                                            <em>X${detail.goods_count}</em>
                                        </span>
                                    <div class="clearx"></div>
						        </span>
                                    </c:forEach>
                                    <div class="orer-detail-btn">
                                        <div class="order-list-detail" data-orderno="${order.order_no}">
                                            <span>共${order.goods_count}件商品</span>
                                            <span>合计：</span>
                                            <span>￥</span>
                                            <span>${order.order_price}</span>
                                            <span>(含运费、预付款)</span>
                                        </div>
                                        <div class="order-list-do">
                                            <!-- 0待付款1已付款2确认中3已失败4待发货5待收货6已完成7已取消8已删除9退款中10已退款 -->
                                            <c:if test="${order.order_status==2}">
                                                <p data-orderno="${order.order_no}" data-status="7">取消订单</p>
                                            </c:if>
                                            <c:if test="${order.order_status==5}">
                                                <p data-orderno="${order.order_no}" data-status="6">完成订单</p>
                                            </c:if>
                                            <c:if test="${order.order_status==6}">
                                                <p>申请售后</p>
                                                <p data-orderno="${order.order_no}" data-status="8">删除订单</p>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="clearx"></div>
                                </article>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div id="PullUp" class="scroller-pullUp" style="display: none;">
                <img style="width: 20px; height: 20px;" src="${path}/js/rolling.svg"/>
                <span id="pullUp-msg" class="pull-up-msg">上拉刷新</span>
            </div>
            <div id="bootDesc"
                 style="text-align: center;width: 100%;height: auto;padding-bottom: 10px;margin-bottom:10px;color: #999999 !important;">
                <c:choose>
                    <c:when test="${orderCount==0}">---没有查询到相关订单---</c:when>
                    <c:when test="${hasNext==false && orderCount>0}">---我是有底线的---</c:when>
                    <c:when test="${hasNext==true}">---上拉查看更多---</c:when>
                    <c:otherwise>---我是有底线的---</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<div style="width: 100%;height: 10px">
    <input type="hidden" id="hasNext" value="${hasNextValue}">
</div>
</body>
<!--插件-->
<script type="text/javascript" src="${path}/js/jquery-1.10.1.min.js"></script>
<script type="text/javascript" src="${path}/js/onclick.js"></script>
<script type="text/javascript" src="${path}/js/swiper.jquery.min.js"></script>  <!--选项卡-->
<script type="text/javascript" src="${path}/js/idangerous.swiper.min.js"></script> <!--选项卡-->
<script type="text/javascript" src="${path}/js/layer.js"></script>
<script>

    $(".Orgoods").on('click', function (e) {
        var orderNo = $(this).attr("data-orderno");
        window.location.href = "${path}/order/query/orderDetail?orderNo=" + orderNo;
    });
    $(" .order-list-detail").on('click', function (e) {
        var orderNo = $(this).attr("data-orderno");
        window.location.href = "${path}/order/query/orderDetail?orderNo=" + orderNo;
    });
    $(" .shop-name").on('click', function (e) {
        var orderNo = $(this).attr("data-orderno");
        window.location.href = "${path}/order/query/orderDetail?orderNo=" + orderNo;
    });

    function appendContent(current) {
        var orderStatus = '${orderStatus}';
        $.ajax({
            type: "post",
            data: {
                current: current,
                orderStatus: orderStatus
            },
            async: false,
            cache: false,
            url: "${path}/order/query/orderList",
            dataType: "json",
            success: function (data) {
                $("#bootDesc").empty();
                $("#hasNext").val(0);
                if (data.flag == 1) {
                    var orderList = data.orderList;
                    if (orderList.length > 0) {
                        for (var i = 0; i < orderList.length; i++) {
                            var h = "<div class='orderpage' data-orderno='" + orderList[i].order_no + "'>"
                                + " <article class='nopadding'>"
                                + " <div class='shop-name' data-orderno='" + orderList[i].order_no + "'>"
                                + " <i class='iconfont icon-shoplogo fl'></i><span  style='color: grey;font-size: 13px'>&nbsp;" + orderList[i].partners_name + "</span>"
                                + "  </div>"
                                + "   <div class='clearx'></div>"
                                + "  <em class='flag'>" + orderList[i].order_status_name + "</em>"
                                + "  <div style='width: 100%;border-bottom: 1px dashed  #D1D1D1'></div>";

                            var detail = orderList[i].order_detail;
                            var detailStr = "";
                            for (var j = 0; j < detail.length; j++) {
                                detailStr = detailStr + " <span class='Orgoods' data-orderno='" + orderList[i].order_no + "' id='" + orderList[i].order_no + "'>"
                                    + "     <span><img src='" + detail[j].goods_img + "'></span>"
                                    + "     <span class='message'>"
                                    + "     <span>" + detail[j].goods_name + "</span>"
                                    + "     <i>" + detail[j].goods_spec_name_str + "</i>"
                                    + "    </span>"
                                    + "   <span class='price'>"
                                    + "   <b><i class='pr'>￥</i>" + detail[j].sale_money + "</b>"
                                    + "    <em>X" + detail[j].goods_count + "</em>"
                                    + "   </span>"
                                    + "   <div class='clearx'></div>"
                                    + "   </span>";
                            }
                            h = h + detailStr + " <div class='orer-detail-btn'>"
                                + "    <div class='order-list-detail'  data-orderno='" + orderList[i].order_no + "'>"
                                + "    <span>共" + orderList[i].goods_count + "件商品</span>"
                                + "     <span>合计：</span>"
                                + "   <span>￥</span>"
                                + "    <span>" + orderList[i].order_price + "</span>"
                                + "   <span>(含运费、预付款)</span>"
                                + "   </div>"
                                + "   <div class='order-list-do'>";
                            //0待付款1已付款2确认中3已失败4待发货5待收货6已完成7已取消8已删除9退款中10已退款
                            var orderStatus = orderList[i].order_status;
                            var orderDo = "";
                            if (Number(orderStatus) == 0) {
                                orderDo = " <p>去支付</p><p data-orderno='" + orderList[i].order_no + "' data-status='7'>取消订单</p>";
                            }
                            if (Number(orderStatus) == 1) {//取消订单--->申请退款
                                orderDo = " <p>申请退款</p>";
                            }
                            if (Number(orderStatus) == 2) {
                                orderDo = "<p data-orderno='" + orderList[i].order_no + "' data-status='7'>取消订单</p>";
                            }
                            if (Number(orderStatus) == 5) {
                                orderDo = "<p data-orderno='" + orderList[i].order_no + "' data-status='6'>完成订单</p>";
                            }
                            if (Number(orderStatus) == 6) {
                                orderDo = "<p>申请售后</p><p data-orderno='" + orderList[i].order_no + "' data-status='8'>删除订单</p>";
                            }

                            h = h + orderDo + "  </div>"
                                + " </div>"
                                + " <div class='clearx'></div>"
                                + " </article>"
                                + "  </div>"
                            $(".orderlist").append(h);
                        }
                        if (data.hasNext == true) {
                            $("#hasNext").val(1);
                            $("#bootDesc").append("---上拉查看更多---");
                        } else {
                            $("#bootDesc").append("---我是有底线的---");
                        }
                    } else {
                        $("#bootDesc").append("---没有查询到相关订单---");
                    }
                } else {
                    alertMsgCommonCommon(data.msg, 2);
                    $("#bootDesc").append("---网络异常,请稍后重试---");
                }
            }
        });
    }

    window.onload = function () {
        var page = 2;
        // 初始化body高度
        document.body.style.height = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
        var pullUp = document.querySelector("#PullUp"),
            isPulled = false; // 拉动标记

        var myScroll = new IScroll('#container', {
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

    $(".order-list-do>p").on('click', function (e) {
        //0待付款1已付款2确认中3已失败4待发货5待收货6已完成7已取消8已删除9退款中10已退款
        var orderNo = $(this).attr("data-orderno");
        var status = $(this).attr("data-status");
        var titalName = "";
        if (status == 7) {
            titalName = "是否要取消订单"
        } else if (status == 6) {
            titalName = "是否要完成订单"
        } else if (status == 8) {
            titalName = "是否要删除订单"
        } else {
            alertMsgCommon("功能未开发", 2);
            return;
        }

        //询问框
        layer.open({
            content: titalName
            , btn: ['确认', '返回']
            , yes: function (index) {
                $.ajax({
                    type: "post",
                    data: {orderNo: orderNo, status: status},
                    async: false,
                    cache: false,
                    url: "${path}/order/update/orderStatus",
                    dataType: "json",
                    type: "post",
                    success: function (data) {
                        if (data.flag == 1) {
                            // location.reload();
                            alertMsgCommon("操作成功", 2);
                            $("#" + orderNo).remove();
                            layer.close(index);
                        } else if (data.flag == 2) {
                            alertMsgCommon("请先登录", 2);
                            window.location.href = "${path}/user/loginPage";
                        } else {
                            alertMsgCommon(data.msg, 2);
                        }
                    }
                });
            }
        });

    });
</script>
</html>