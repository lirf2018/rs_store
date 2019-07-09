<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>提交订单</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" href="${path}/css/ydui.css">
    <link rel="stylesheet" href="${path}/css/demo.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" href="${path}/css/reset.css">
    <link rel="stylesheet" href="${path}/js/need/layer.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loading.css"/>
    <link rel="stylesheet" href="${path}/css/order-comfirm2.css"/>
    <link rel="stylesheet" href="${path}/css/on-off.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <%--<script src="${path}/js/ydui.flexible.js"></script>--%>
    <style>
        .g-scrollview:after {
            height: 0.15rem;
        }

        .cityselect-title {
            font-size: 16px;
        }

        .cityselect-nav > a {
            font-size: 14px;
            color: #222;
            display: block;
            height: 40px;
            line-height: 46px;
            position: relative;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 40%;
            padding: 0;
            padding-left: 5px;
        }

        .cityselect-item-box > a {
            font-size: 14px;
        }

        .cityselect-nav {
            padding-left: 0px;
        }

        .cityselect-item-box {
            width: 100%;
            height: inherit;
            display: block;
            padding: 0 .1rem;
            line-height: 20px;
        }

        .cityselect-item-box > a {
            line-height: 18px;
        }
    </style>
    <script type="text/javascript">$(window).load(function () {
        $(".loading").addClass("loader-chanage");
        $(".loading").fadeOut(300);
    });
    //当前存在的支付方式 //支付方式（根据入口环境得到支付方式） 预付支付方式 0现金付款1微信2支付宝3账户余额
    var payTypeArray = '${payTypeArray}';
    var getDateArrayJson = '${getDateArray}';
    var addrType = '${sysAddrType}';
    var phone = '${phone}';
    //计算账单
    doPriceAll();

    function doPriceAll() {

        var goodsPriceAll = '${goodsPriceAll}';//商品总价格
        var advancePriceSys = '${advancePrice}';//订单预付款价格
        var goodsAdvancePriceAll = '${goodsAdvancePriceAll}';//商品预付款价格(支持线下付款类商品)
        var onlinePriceAll = '${goodsPayOnlinePriceAll}';//商品只能线上支付总价格
        var depositPriceAll = '${depositPriceAll}';//押金总额
        var postPrice = $("#postPrice").val();//运费
        var discountsPrice = $("#discountsPrice").val();//优惠金额


        //订单实际总额 = 商品总价格 + 商品押金总额 + 邮费
        var orderRealyPrice = Number(goodsPriceAll) + Number(depositPriceAll) + Number(postPrice);
        var advanceOrderPrice = 0;//订单预付款
        var needOrderPrice = 0;//待付款
        var orderPrice = 0;//订单支付总额
        if (Number(discountsPrice) > 0) {
            var orderRealyPrice2 = 0;
            //如果存在优惠金额,则
            if (Number(discountsPrice) > Number(goodsPriceAll)) {//商品免费
                discountsPrice = goodsPriceAll;
                //实际订单价格2 = 邮费 + 押金总额
                orderRealyPrice2 = Number(postPrice) + Number(depositPriceAll)
            } else {
                //实际订单价格2 = 邮费 + 押金总额 + 商品总额 - 优惠券金额
                orderRealyPrice2 = Number(postPrice) + Number(depositPriceAll) + Number(goodsPriceAll) - Number(discountsPrice)
            }

            //预付款 = 邮费 + 订单预付款
            advanceOrderPrice = Number(postPrice) + Number(advancePriceSys)
            if (Number(advanceOrderPrice) > Number(orderRealyPrice2)) {
                advanceOrderPrice = orderRealyPrice2;
                needOrderPrice = 0;
            } else {
                needOrderPrice = Number(orderRealyPrice2) - Number(advanceOrderPrice);
            }
            orderPrice = orderRealyPrice2;//订单支付价格
        } else {
            //-------------------------------------------------------------------------------------无优惠券---------------------------------
            //订单预付款 = 系统配置的订单预付款 + 商品预付款总额(支持线下付款类商品) + 邮费 + 商品只能线上付款总额
            advanceOrderPrice = Number(advancePriceSys) + Number(goodsAdvancePriceAll) + Number(postPrice) + Number(onlinePriceAll);
            if (Number(advanceOrderPrice) > Number(orderRealyPrice)) {
                advanceOrderPrice = orderRealyPrice;
                needOrderPrice = 0; //待付款
            } else {
                //待付款 = 订单实际总额 - 订单预付款
                needOrderPrice = Number(orderRealyPrice) - Number(advanceOrderPrice);
            }
            orderPrice = orderRealyPrice;//订单支付价格
        }

        var inPayWay = $("#inPayWay").val();//已选择的支付方式
        if (inPayWay == '0') {//现金支付
            advanceOrderPrice = orderPrice;
            needOrderPrice = 0;
        }

        //如果预付款为0
        /*if (Number(advanceOrderPrice) == 0) {
            $(".chose-payway>b").html("货到付款");
            $("#inPayWay").val(4);
        }*/
        if (Number(advanceOrderPrice) > 0 && inPayWay == '4') {
            $(".chose-payway>b").html("选择支付方式");
            $("#inPayWay").val(0);
        }


        //运费
        $(".span-post").html(returnFloat(postPrice));
        //优惠
        $(".span-discounts").html(returnFloat(-discountsPrice));
        //预付款
        $(".span-advancePrice").html(returnFloat(advanceOrderPrice));
        //订单总价
        $(".span-orderPrice").html(returnFloat(orderPrice));
        //待付款=订单总价-预付款
        $(".span-needPrice").html(returnFloat(needOrderPrice));

        //设置订单提交参数
        $("#advancePrice").val(advanceOrderPrice);
        $("#needpayPrice").val(needOrderPrice);
        $("#orderPrice").val(orderPrice);
        $("#realPrice").val(orderRealyPrice);

    }

    function returnFloat(value) {
        var value = Math.round(parseFloat(value) * 100) / 100;
        var xsd = value.toString().split(".");
        if (xsd.length == 1) {
            value = value.toString() + ".00";
            return value;
        }
        if (xsd.length > 1) {
            if (xsd[1].length < 2) {
                value = value.toString() + "0";
            }
            return value;
        }
    }
    </script>
</head>

<body>
<form id="data-form" action="${path}/order/createOrder" method="post">
    <!-- 支付方式-->
    <input type="hidden" id="inPayWay" name="advancePayWay" value="-1"/>
    <!-- 配送运费-->
    <input type="hidden" id="postPrice" name="postPrice" value="${freight}"/>
    <!-- 优惠价格标识（用户优惠券标识）-->
    <input type="hidden" id="discountsId" name="discountsId" value="0"/>
    <!-- 优惠价格-->
    <input type="hidden" id="discountsPrice" name="discountsPrice" value="0"/>
    <!-- 用户已选择地址标识-->
    <!-- 用户地址标识,或者平台地址标识-->
    <input type="hidden" id="userAddrId" name="userAddrId" value="${userAddrId}"/>
    <!-- 全国地址所选的城市或者选择的平台地址名称-->
    <input type="hidden" id="inChoseAddr" name="inChoseAddr" value=""/>
    <!-- 全国地址编码-->
    <input type="hidden" id="inChoseAddrCode" name="inChoseAddrCode" value=""/>
    <!-- 平台配置的取货方式 -->
    <input type="hidden" id="sysAddrType" name="sysAddrType" value="${sysAddrType}"/>

    <input type="hidden" id="userName" name="userName" value="${userName}">
    <input type="hidden" id="userPhone" name="userPhone" value="${userPhone}">


    <!-- 订单参数 -->
    <input type="hidden" id="advancePrice" name="advancePrice" value="0"/><!-- 预付款 -->
    <input type="hidden" id="goodsCounts" name="goodsCounts" value="${goodsCounts}"/><!-- 订单商品总数 -->
    <input type="hidden" id="needpayPrice" name="needpayPrice" value="0"/>
    <input type="hidden" id="orderPrice" name="orderPrice" value="0"/>
    <input type="hidden" id="realPrice" name="realPrice" value="0"/>
    <input type="hidden" id="timeGoodsId" name="timeGoodsId" value="${timeGoodsId}"/>
    <input type="hidden" id="timePrice" name="timePrice" value="${timePrice}"/>
    <input type="hidden" id="depositPriceAll" name="depositPriceAll" value="${depositPriceAll}"/>
    <input type="hidden" id="depositPrice" name="depositPrice" value="${depositPrice}"/>

    <%--取货时间--%>
    <input type="hidden" id="getDate" name="getDate" value=""/>

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
        <span class="title-name">提交订单</span>
        <div id="homeBtn" class="homeBtn"></div>
    </header>
    <div class="clear-header"></div>
    <div id="container">
        <div class="add-addr-div">
            <div class="add-addr-detail" style="${showAddAddr}">
                <ul>
                    <li><span>&nbsp;</span></li>
                    <li><img src="${path}/img/updateimg.png" width="36px" height="36px"></li>
                    <li><span>&nbsp;</span></li>
                </ul>
                <ul class="add-addr-detail-ul">
                    <li>
                        <span>收 货 人 :</span>
                        <span>${userName}</span>
                    </li>
                    <li>
                        <span> &nbsp;电 &nbsp;话 :</span>
                        <span>${userPhone}</span>
                    </li>
                    <li>
                        <span>收货地址 :</span>
                        <span>${addr}</span>
                    </li>
                </ul>
            </div>
            <div class="add-addr-word" style="${addAddr}">
                <span><u>添加收货地址</u></span>
            </div>
        </div>
        <div class="orderlist">
            <div class="orderpage">
                <div class="colorline"></div>
                <c:forEach items="${listPartners}" var="item">
                    <article class="nopadding">
                        <div class="shop-name">
                            <i class="iconfont icon-shoplogo fl"></i><span
                                style="color: grey;font-size: 13px">&nbsp;${item.partners_name}</span>
                        </div>
                        <div class="clearx"></div>
                        <div style="width: 100%;border-bottom: 1px dashed  #D1D1D1"></div>
                        <em class="flag"></em>
                        <c:forEach items="${orderDetailGoodsBeanList}" var="itemSub">
                            <c:if test="${itemSub.partnersId==item.partners_id}">
                            <span class="Orgoods">
                                <span><img src="${itemSub.goodsImg}"></span>
                                <span class="message">
                                    <span>${itemSub.goodsName}</span>
                                    <i>${itemSub.goodsSpecNameStr}</i>
                                </span>
                                <span class="price">
                                    <b><i class="pr">￥</i>${itemSub.salePrice}</b>
                                    <em>X${itemSub.goodsCount}</em>
                                </span>
                            <div class="clearx"></div>
                            </span>
                                <input type="hidden" name="goodsCount" value="${itemSub.goodsCount}"/>
                                <input type="hidden" name="goodsId" value="${itemSub.goodsId}"/>
                                <input type="hidden" name="saleMoney" value="${itemSub.salePrice}"/>
                                <input type="hidden" name="goodsPpec" value="${itemSub.goodsSpec}"/>
                                <input type="hidden" name="goodsSpecName" value="${itemSub.goodsSpecName}"/>
                                <input type="hidden" name="goodsSpecNameStr" value="${itemSub.goodsSpecNameStr}"/>
                                <input type="hidden" name="cartId" value="${itemSub.cartId}"/>
                                <input type="hidden" name="isSingle" value="${itemSub.isSingle}">
                            </c:if>
                        </c:forEach>
                    </article>
                </c:forEach>
                <article class="pay_way">
                    <a class="chose-payway">(预付款)支付方式<b>选择支付方式</b><i></i></a>
                    <c:choose>
                        <c:when test="${getWay == 1}">

                        </c:when>
                        <c:when test="${getWay == 4}">
                            <a class="chose-getdate">取货日期<b>选择取货日期</b><i></i></a>
                        </c:when>
                        <c:when test="${getWay == 5}">
                            <a class="chose-getdate">配送日期<b>选择配送日期</b><i></i></a>
                        </c:when>
                        <c:otherwise>
                            <a class="chose-getdate">取货/配送日期<b>选择取货/配送日期</b><i></i></a>
                        </c:otherwise>
                    </c:choose>
                    <!--<a class="chose-ticket">优惠详情<b>未使用</b><i></i></a>-->
                    <a class="chose-ticket"><span>买家留言</span><span><input type="text" value="" name="userRemark"></span></a>
                    <span>
			                <span>
                                小计：<i>￥</i><b><em class="span-orderPrice">0.00</em></b><br/>
                                预付款：<em class="span-advancePrice">0.00</em><br/>
                                待付款：<em class="span-needPrice">0.00</em><br/>
                                优惠金额：<em class="span-discounts">0.00</em><br/>
                                押金总金额：<em class="deposit-discounts">${depositPriceAll}</em><br/>
                                <c:choose>
                                    <c:when test="${getWay == 1}">
                                        邮费：<em class="span-post">${freight}</em></span>
                                    </c:when>
                                    <c:when test="${getWay == 4}">
                                        自取费：<em class="span-post">${freight}</em></span>
                    </c:when>
                    <c:when test="${getWay == 5}">
                        配送费：<em class="span-post">${freight}</em></span>
                    </c:when>
                    <c:otherwise>
                        邮费(配送\自取费)：<em class="span-post">${freight}</em></span>
                    </c:otherwise>
                    </c:choose>

                    <span>共2件商品</span>
                    <div class="clearx"></div>
                    </span>
                </article>
            </div>
        </div>
        <div style="height: 0.7rem;"></div>
    </div>
    <!--
        作者：512164882@qq.com
        时间：2017-09-08
        描述：
    -->
    <footer class="shopcard-footer">
        <div id="allPrice" class="div-p div-3">
            <span>合计：0.00</span>
            <span class="post-desc"> (含邮费)</span>
        </div>
        <div id="buyNow" class="div-p div-4" onclick="checkOrderAndSubmit()">
            提交订单
        </div>
    </footer>
    <%--选择收货地址--%>
    <div style="display: none" id="selectAddr">
        <div class="m-cityselect">
            <div class="cityselect-header">
                <p class="cityselect-title">所在地区</p>
                <div class="cityselect-nav">
                    <a href="javascript:;" class="" cid="1"></a>
                    <a href="javascript:;" class="" cid="1"></a>
                    <a href="javascript:;" cid="1" class=""></a>
                    <a href="javascript:;" cid="2" class=""></a>
                </div>
            </div>
            <ul class="cityselect-content cityselect-next-two cityselect-move-animate">
                <li class="cityselect-item">
                    <div class="cityselect-item-box"></div>
                </li>
                <li class="cityselect-item">
                    <div class="cityselect-item-box"></div>
                </li>
                <li class="cityselect-item">
                    <div class="cityselect-item-box"></div>
                </li>
                <li class="cityselect-item">
                    <div class="cityselect-item-box"></div>
                </li>
            </ul>
        </div>
    </div>
    <%--平台地址--%>
    <div id="getClassDiv" style="height: 100%;display: none;">
        <section class="user-name-phone-section">
            <div class="user-name-phone">
                <input type="text" id="userNameAdd" placeholder="收货人姓名" value="">
                <input type="text" id="userPhoneAdd" placeholder="收货人电话" maxlength="15" value="">
            </div>
        </section>
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
</form>
<!--插件-->
<script type="text/javascript" src="${path}/js/onclick.js"></script>
<script type="text/javascript" src="${path}/js/order-confirm2.js"></script>
<script type="text/javascript" src="${path}/js/layer.js"></script>
<script src="${path}/js/jquery-1.10.1.min.js"></script>
<script src="${path}/js/ydui.my.js"></script>
<script type="text/javascript">
    document.write("<scr" + "ipt src=\"../js/ydui.citys.my.min.js\"></sc" + "ript>")
</script>
</body>
<script>
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
                    var userAddrId = $("#userAddrId").val();
                    if (userAddrId == itemSub.id) {
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