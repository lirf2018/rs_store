<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单详情</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loading.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/order-comfirm.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/order-detail.css"/>
    <script type="text/javascript" src="${path}/js/layer.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript">$(window).load(function () {
        $(".loading").addClass("loader-chanage");
        $(".loading").fadeOut(200);
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
    <a href="javascript:history.go(-1)" class="fl fanhui"><i class="iconfont icon-fanhui"></i></a>
    <span class="title-name">订单详情</span>
    <div id="homeBtn" class="homeBtn"></div>
</header>
<div class="clear-header"></div>
<div>
    <%--还货地址标识--%>
    <input type="hidden" value="${data.back_addr_id}" id="backAddrId">
    <input type="hidden" value="${data.back_time}" id="backDate">

    <div class="order-num">订单编号：${data.order_no}</div>
    <c:if test="${!empty failMark && failMark=='1' }">
        <div class="order-fail">失败原因:<p>${data.service_remark}</p></div>
    </c:if>
    <div class="ordermessage nopadding">
            <span class="shouh">
                <dl>
                    <dd>收货人：<span>${data.user_name}</span></dd>
                    <dd>电   话： <span>${data.user_phone}</span></dd>
                    <div class="clearx" style="height:10px"></div>
                </dl>
                <p>收货地址：<span>${data.user_addr}</span></p>
                 <c:if test="${data.business_type == 4 && data.order_status==6}">
                     <p class="chose-back-addr" style="margin-top: 10px">还货地址：
                         <span>
                             <c:choose>
                                 <c:when test="${data.back_addr_name == '' || empty data.back_addr_name }">
                                     选择还货地址
                                 </c:when>
                                 <c:otherwise>
                                     ${data.back_addr_name}
                                 </c:otherwise>
                             </c:choose>
                         </span></p>
                 </c:if>
             </span>
    </div>
    <div class="orderlist">
        <div class="orderpage">
            <div class="colorline"></div>
            <article class="nopadding">
                <div class="shop-name">
                    <i class="iconfont icon-shoplogo fl"></i><span
                        style="color: grey;font-size: 13px">&nbsp;${data.partners_name}</span>
                </div>
                <div class="clearx"></div>
                <div style="width: 100%;border-bottom: 1px dashed  #D1D1D1"></div>
                <em class="flag">${data.order_status_name}</em>
                <c:forEach items="${data.order_detail}" var="detail">
                    <span class="Orgoods" data-goodsId="${detail.goods_id}" data-timeGoodsId="${detail.time_goods_id}">
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
            </article>
            <article class="pay-detail">
                <dl>
                    <dt>
                        <p><span>订单总额</span>（含运费）</p>
                        <p><span>预付款</span></p>
                        <p><span>待付款</span></p>
                        <p>优惠金额</p>
                        <p>押金总额</p>
                        <p>
                            <c:choose>
                                <c:when test="${data.post_way == 1}">
                                    邮费
                                </c:when>
                                <c:when test="${data.post_way == 4}">
                                    自取费
                                </c:when>
                                <c:when test="${data.post_way == 5}">
                                    配送费
                                </c:when>
                                <c:otherwise>
                                    邮费(配送\自取费)
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </dt>
                    <dd>
                        <p class="red">￥${data.order_price} </p>
                        <p>￥${data.advance_price} </p>
                        <p class="red">￥${data.needpay_price} </p>
                        <p>￥${data.discounts_price} </p>
                        <p>￥${data.deposit_price} </p>
                        <p>￥${data.post_price} </p>
                    </dd>
                    <div class="clearx"></div>
                    <p>下单时间：${data.order_time}</p>
                </dl>
            </article>
            <article class="pay-detail">
                <dl>
                    <dt>
                        <p><span>支付方式</span></p>
                        <p><span>取货方式</span></p>
                    </dt>
                    <dd>
                        <p>${data.advance_pay_way_name} </p>
                        <p>${data.post_way_name} </p>
                    </dd>
                    <div class="clearx"></div>
                </dl>
            </article>
            <%--<c:if test="${!empty data.get_time &&  data.get_time !=''}">--%>
            <article class="pay-detail">
                <dl>
                    <dt>
                        <p><span>取货日期</span></p>
                    </dt>
                    <dd>
                        <p>${data.get_time}</p>
                    </dd>
                    <div class="clearx"></div>
                </dl>
            </article>
            <%--</c:if>--%>
            <c:if test="${data.business_type == 4 && data.order_status==6}">
                <article class="pay-detail">
                    <dl>
                        <dt>
                            <p><span>还货日期</span></p>
                        </dt>
                        <dd>
                            <p class="chose-getdate">
                                <c:choose>
                                    <c:when test="${data.back_time == '' || empty data.back_time }">
                                        选择还货日期
                                    </c:when>
                                    <c:otherwise>
                                        ${data.back_time}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </dd>
                        <div class="clearx"></div>
                    </dl>
                </article>
            </c:if>
            <div class="order-detail-user-msg">
                <span>买家留言：</span>
                <div>${data.user_remark}</div>
            </div>
        </div>
        <article class="orer-detail-btn">
            <!-- 0待付款1已付款2确认中3已失败4待发货5待收货6已完成7已取消8已删除9退款中10已退款 -->
            <c:if test="${data.order_status==2}">
                <p data-orderno="${data.order_no}" data-status="7">取消订单</p>
            </c:if>
            <c:if test="${data.order_status==5}">
                <p data-orderno="${data.order_no}" data-status="6">完成订单</p>
            </c:if>
            <c:if test="${data.business_type == 4 && data.order_status==6}">
                <p data-orderno="${data.order_no}" data-status="12">申请还货</p>
            </c:if>
            <c:if test="${data.order_status==6}">
                <p data-orderno="${data.order_no}" data-status="">申请售后</p>
                <p data-orderno="${data.order_no}" data-status="8">删除订单</p>
            </c:if>
        </article>
    </div>
    <%--平台地址--%>
    <div id="getClassDiv" style="height: 100%;display: none;">
        <section class="searchBar wap">
            <div class="searchBox">
                <input type="text" onkeyup="searchAddr()" placeholder="搜索收货地址" value="">
            </div>
            <span class="searchBar search-button onclick-hand" onclick="searchAddr()">搜索</span>
        </section>
        <div class="addr-content">
            <div class="get-addr">
                <div class="get-addr-list">
                    <div style="display: none;" id="platformAddr">
                    </div>
                </div>
            </div>
            <div style="height: 1.12rem;"></div>
            <div class="sure" onclick="clickChoseAddr()">
                <span>确认</span>
            </div>
        </div>
    </div>
</div>
</body>
<!--插件-->
<script type="text/javascript" src="${path}/js/onclick.js"></script>
<script>
    $(".Orgoods").on('click', function (e) {
        var goodsId = $(this).attr("data-goodsId");
        var timeGoodsId = $(this).attr("data-timeGoodsId");
        window.location.href = "${path}/goods/query/goodsInfo?goodsId=" + goodsId + "&timeGoodsId=" + timeGoodsId;
    });
    $(".orer-detail-btn>p").on('click', function (e) {
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
        } else if (status == 12) {
            backGoods(12, orderNo);
            return;
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
                            alertMsgCommon("操作成功", 2);
                            location.reload();
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

    //申请还货
    function backGoods(status, orderNo) {
        var backDate = $("#backDate").val();//还货日期
        var backAddrId = $("#backAddrId").val();//还货地址
        if (backAddrId == 0 || backAddrId == "" || backAddrId == null) {
            alertMsgCommon("请先选择还货地址", 2);
            return;
        }
        if (backDate == "" || backDate == null) {
            alertMsgCommon("请先选择还货日期", 2);
            return;
        }
        //询问框
        layer.open({
            content: '是否要归还商品'
            , btn: ['确认', '返回']
            , yes: function (index) {
                $.ajax({
                    type: "post",
                    data: {orderNo: orderNo, backDate: backDate, backAddrId: backAddrId},
                    async: false,
                    cache: false,
                    url: "${path}/order/update/s",
                    dataType: "json",
                    type: "post",
                    success: function (data) {
                        if (data.flag == 1) {
                            alertMsgCommon("操作成功", 2);
                            location.reload();
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
    }

    var backDateArrayJson = '${data.list_back_date}';

    //选择日期
    $(".chose-getdate").on('click', function (e) {
        var backDate = $("#backDate").val();//当前选择的日期
        var backDateArray = eval("(" + backDateArrayJson + ")");
        var payHtml = "";
        for (var i = 0; i < backDateArray.length; i++) {
            if (backDate != '' && backDate == backDateArray[i]) {
                payHtml = payHtml + "<div class='chose-date' style='border: 1px solid #00cc7d' onclick='choseDateClick(this)' data-value='" + backDateArray[i] + "'>" + backDateArray[i] + "</div>";
            } else {
                payHtml = payHtml + "<div class='chose-date' onclick='choseDateClick(this)' data-value='" + backDateArray[i] + "'>" + backDateArray[i] + "</div>";
            }
        }
        var html = "<div class='pay-way-new'><div class='pay-title' >选择日期 <u style='font-size: 8px;padding-left: 10px'></u></div>" + payHtml + "</div>";
        var payLayer = layer.open({
            type: 1
            , content: html
            , anim: 'up'
            , style: 'position:fixed; bottom:0; left:0; width: 100%;  padding:0px 0; border:none;'
        });

    })

    //选择日期
    function choseDateClick(obj) {
        var valueDate = $(obj).attr("data-value");
        //设置颜色、
        $(".pay-way-new>div").css("border", "none");
        $(".pay-way-new>div:not(:last-child)").css("border-bottom", "1px solid grey");
        $(obj).css("border", "1px solid #00cc7d");

        //设置选择日期
        $("#backDate").val(valueDate);
        $(".chose-getdate").html(valueDate);

        layer.closeAll()
    }
</script>
<script>
    //选择平台地址
    $(".chose-back-addr").on('click', function (e) {
        showPlatformAddr();//弹出平台地址
    });

    var htmlOld = $("#getClassDiv").html();

    function showPlatformAddr() {
        $(".searchBox>input").val("");
        $("#getClassDiv").empty();
        var pageii = layer.open({
            type: 1,
            content: htmlOld,
            anim: 'up',
            style: 'position:fixed; left:0; top:0; width:100%; height:100%; border: none; -webkit-animation-duration: .5s; animation-duration: .5s;'
        });
        searchAddr();
        $("#platformAddr").show();
    }

    //选中地址
    function choseAddr(id, obj) {
        $(".get-addr-list-detail>li").css("border", "none");
        $(obj).css("border", "1px solid #00cc7d");

        //选择平台收货的地址名称
        var inChoseAddr = $("#" + id).children(0).attr("data-addr");
        $(".chose-back-addr>span:last-child").html(inChoseAddr);
        //选择的平台标识
        $("#backAddrId").val(id);
        //
        $(".add-addr-detail").show();
        $(".add-addr-word").hide();
    }

    //平台地址确认
    function clickChoseAddr() {
        /* var backAddrId = $("#backAddrId").val();//还货地址
         if(backAddrId ==0 || backAddrId == "" || backAddrId ==null){
             alertMsgCommon("请先选择还货地址", 2);
             return;
         }*/
        layer.closeAll();
    }

    /**
     * 搜索地址平台地址
     */
    function searchAddr() {
        var searchName = $(".searchBox>input").val();
        searchName = searchName.trim();
        var addrList = eval("(" + '${addrList}' + ")");
        var msg = "未添加有效地址";
        $(".get-addr-list>div:first-child").empty();
        if (addrList.length > 0) {
            var isDataExist = false;
            for (var i = 0; i < addrList.length; i++) {
                var jsIsp_pa = false;//用于记录查询关键词
                var item = addrList[i];
                var html = "<div>"
                    + "<div class='get-addr-list-title'>"
                    + "<span>" + item.char_word + "</span>"
                    + "<span>费用&nbsp;&nbsp;&nbsp;</span>"
                    + "</div>"
                    + "<div>"
                    + "<ul class='get-addr-list-detail'>";
                var htmlSub = "";
                for (var j = 0; j < item.addr_detail.length; j++) {
                    var itemSub = item.addr_detail[j];
                    var liChoseStype = "";
                    var backAddrId = $("#backAddrId").val();//还货地址
                    if (backAddrId == itemSub.id) {
                        liChoseStype = "style='border: 1px solid #00cc7d;'";
                    }
                    var detailDddr = itemSub.detail_addr;
                    if (searchName != null && searchName != "") {
                        if (detailDddr.indexOf(searchName) > -1) {
                            jsIsp_pa = true;
                            isDataExist = true;
                            var showDetailDddr = detailDddr;
                            var searchNameColor = "<span style='font-size:15px;color: #00cc7d;'><strong>" + searchName + "</strong></span>";
                            detailDddr = detailDddr.replace(searchName, searchNameColor);
                            htmlSub = htmlSub + "<li " + liChoseStype + " onclick='choseAddr(" + itemSub.id + ",this)' id='" + itemSub.id + "'> <span data-addr='" + showDetailDddr + "' data-freight='" + itemSub.freight + "' >" + detailDddr + "</span> <span>" + itemSub.freight + "</span></li>";
                        }
                    } else {
                        jsIsp_pa = true;
                        isDataExist = true;
                        htmlSub = htmlSub + "<li " + liChoseStype + "  onclick='choseAddr(" + itemSub.id + ",this)' id='" + itemSub.id + "'> <span data-addr='" + detailDddr + "'  data-freight='" + itemSub.freight + "' >" + detailDddr + "</span> <span>" + itemSub.freight + "</span></li>";
                    }
                    htmlSub = htmlSub + "<div style='clear: left'></div>";
                }
                html = html + htmlSub + "</ul></div></div>";
                if (jsIsp_pa) {
                    $(".get-addr-list>div:first-child").append(html);
                }
            }
            if (!isDataExist) {
                alertMsgCommon(msg, 2);
            }
        } else {
            alertMsgCommon(msg, 2);
        }
    }
</script>
</html>