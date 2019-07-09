<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>购物车</title>
    <%@ include file="./util/taglibs.jsp" %>
    <%@ include file="./util/meta.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/common.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/loading.css"/>
    <link rel="stylesheet" href="${path}/css/shop-card.css"/>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/math.js"></script>
    <script type="text/javascript">
        $(window).load(function () {
            $(".loading").addClass("loader-chanage");
            $(".loading").fadeOut(200);
        })
    </script>
</head>
<body>
<form id="data-form" action="${path}/order/commitPage" method="post">
    <input type="hidden" name="depositPrice" value="0">
    <input type="hidden" name="timeGoodsId" value="0">
    <input type="hidden" name="timePrice" value="0">
    <input type="hidden" name="advancePrice" value="${resultDate.advance_price}">
    <input type="hidden" id="selectCardIds" name="selectCardIds" value="">
    <!-- 系统设置的取货方式 1 全国地址 2 平台地址 -->
    <input type="hidden" id="addrType" name="addrType" value="${resultDate.addr_type}">
    <!-- 用户已选择的取货方式 1邮寄 4自取 5配送 -->
    <input type="hidden" id="userChoseAddrType" name="userChoseAddrType" value="${userChoseAddrType}">
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
        <span class="title-name">购物车</span>
        <div id="homeBtn" class="homeBtn"></div>
    </header>
    <div id="container">
        <div class="shopcar clearfloat all-shop-goods">
            <div class="select-all2">
                <div class="radio">
                    <label>
                        <input type="checkbox" name="selectAll">全选
                        <div class="option" onclick='choseCheckParent()'></div>
                    </label>
                </div>
                <div onclick="choseAddr()">
                    <div id="getWay_1" name="getWay" ${getWay_1}>选择商品取货方式: <span>全部</span></div>
                    <div id="getWay1" name="getWay" ${getWay1}>选择商品取货方式: <span>邮寄</span></div>
                    <div id="getWay4" name="getWay" ${getWay4}>选择商品取货方式: <span>自取</span></div>
                    <div id="getWay5" name="getWay" ${getWay5}>选择商品取货方式: <span>配送</span></div>
                </div>
                <div><i class="iconfont icon-lajixiang fr"></i></div>
            </div>
            <c:if test="${fn:length(resultDate.list_effective)==0}">
                <div style="height: 30px;width: 100%"></div>
                <div class="no-goods">
                    <div>
                        <a href="${path}/goods/goodsListPage?current=1&searchType=sort">点击去购物</a>
                    </div>
                    <div>
                        <a href="${path}/goods/goodsListPage?current=1&searchType=sort"><img
                                src="${path}/img/shop-car.png" width="230px" height="200px"></a>
                    </div>
                </div>
            </c:if>
            <div style="clear: both;width: 100%" class="clear-div"></div>
            <c:forEach items="${resultDate.list_effective}" var="item">
                <div class="shopcar clearfloat shop-goods-list">
                    <div class="shop-name">
                        <i class="iconfont icon-shoplogo fl"></i><span>&nbsp;${item.partners_name}</span>
                    </div>
                    <c:forEach items="${item.effective}" var="itemSub">
                        <input type="hidden" name="goodsSpaceCode" value="${itemSub.goods_spec}">
                        <input type="hidden" name="goodsSpaceCodeName" value="${itemSub.goods_spec_name}">
                        <input type="hidden" name="goodsSpaceCodeNameStr" value="${itemSub.goods_spec_name_str}">
                        <input type="hidden" name="goodsId" value="${itemSub.goods_id}">
                        <input type="hidden" name="goodsImg" value="${itemSub.goods_img}">
                        <input type="hidden" name="goodsName" value="${itemSub.goods_name}">
                        <input type="hidden" name="salePrice" value="${itemSub.goods_price}">
                        <input type="hidden" id="goodsCount${itemSub.cart_id}" name="goodsCount"
                               value="${itemSub.goods_count}">
                        <input type="hidden" id="getWay-${itemSub.cart_id}" name="getWay" value="${itemSub.get_way}">
                        <input type="hidden" name="isSingle" value="${itemSub.is_single}">
                        <input type="hidden" name="partnersId" value="${itemSub.partners_id}">
                        <input type="hidden" id="partnersId${itemSub.cart_id}" value="${itemSub.partners_id}">
                        <input type="hidden" name="partnersName" value="${itemSub.partners_name}">
                        <input type="hidden" name="isPayOnline" value="${itemSub.is_pay_online}">
                        <input type="hidden" name="cartId" value="${itemSub.cart_id}">
                        <input type="hidden" name="advancePrice" value="${itemSub.advance_price}"><!-- 订单预付款 -->
                        <input type="hidden" name="goodsAdvancePrice"
                               value="${itemSub.goods_advance_price}"><!-- 商品预付款 -->
                        <div class="list clearfloat fl">
                            <div class="xuan clearfloat fl">
                                <div class="radio">
                                    <label>
                                        <input type='checkbox' name='checkSub' value="${itemSub.cart_id}">
                                        <div class="option"></div>
                                    </label>
                                </div>
                            </div>
                            <a href="${path}/goods/query/goodsInfo?goodsId=${itemSub.goods_id}&isSingle=${itemSub.is_single}">
                                <div class="tu clearfloat fl">
                                    <span></span>
                                    <img src="${itemSub.goods_img}"/>
                                </div>
                            </a>
                            <div class="right clearfloat fl">
                                <a href="${path}/goods/query/goodsInfo?goodsId=${itemSub.goods_id}&isSingle=${itemSub.is_single}">
                                    <p class="tit over">${itemSub.goods_name}</p>
                                </a>
                                <p class="fu-tit over-space">${itemSub.goods_spec_name_str}</p>
                                <p class="price over"><span>￥</span><span>${itemSub.goods_price}</span></p>
                                <div class="bottom clearfloat">
                                    <input type="hidden" name="buy_count${itemSub.cart_id}"
                                           value="${itemSub.goods_count}"/>
                                    <input type="hidden" name="price${itemSub.cart_id}" value="${itemSub.goods_price}"/>
                                    <div class="zuo clearfloat fl">
                                        <ul>
                                            <li data-cardId="${itemSub.cart_id}"><img src="${path }/img/jian.png"/></li>
                                            <li>${itemSub.goods_count}</li>
                                            <li data-cardId="${itemSub.cart_id}"><img src="${path }/img/jia.png"/></li>
                                        </ul>
                                    </div>
                                    <i class="iconfont icon-lajixiang fr"><span
                                            style="display: none;">${itemSub.cart_id}</span></i>
                                    <span style="padding-left: 10px;line-height:25px">
                                        取货方式:
                                        <c:choose>
                                            <c:when test="${itemSub.get_way==1}">
                                                邮寄
                                            </c:when>
                                            <c:when test="${itemSub.get_way==4}">
                                                自取
                                            </c:when>
                                            <c:when test="${itemSub.get_way==5}">
                                                配送
                                            </c:when>
                                            <c:otherwise>
                                                未知
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
            <c:if test="${fn:length(resultDate.list_uneffective)>0}">
                <div class="shopcar clearfloat shop-goods-list">
                    <div class="shop-name" style="color: red;padding-right: 16px">
                        <span>无效商品</span>
                        <span style="padding-right: 16px;color: #06c1ae"><i
                                class="iconfont icon-lajixiang fr"></i></span>
                    </div>
                    <c:forEach items="${resultDate.list_uneffective}" var="item">
                        <div class="list clearfloat fl">
                            <div class="xuan clearfloat fl">
                                <div class="radio">
                                    <label>
                                    </label>
                                </div>
                            </div>
                            <div class="tu clearfloat fl">
                                <span></span>
                                <img src="${item.goods_img}"/>
                            </div>
                            <div class="right clearfloat fl">
                                <p class="tit over">${item.goods_name}</p>
                                <p class="fu-tit over-space">${item.goods_spec_name_str}<input name="uneff-goods"
                                                                                               type="hidden"
                                                                                               value="${item.cart_id}">
                                </p>
                                <p class="price over"><span>￥${item.goods_price}</span></p>
                                <div class="bottom clearfloat">
                                    <div class="zuo clearfloat fl">
                                        <ul>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <div class="repet"></div>
        </div>
    </div>
    <footer class="shopcard-footer">
        <div id="allPrice" class="div-p div-3">
            <span>合计：0.00</span>
            <span class="post-desc"> (不含邮费)</span>
        </div>
        <div id="buyNow" class="div-p div-4">
            去结算
        </div>
    </footer>
</form>
</body>
<!--插件-->
<script type="text/javascript" src="${path}/js/onclick.js"></script>
<script type="text/javascript" src="${path}/js/shopcar2.js"></script>
<script type="text/javascript" src="${path}/js/layer.js"></script>
<script>
    //选择商品取货方式
    function choseAddrOnclick(mark) {
        window.location.href = "${path}/car/shopCar?userChoseAddrType=" + mark;
    }
</script>
</html>
