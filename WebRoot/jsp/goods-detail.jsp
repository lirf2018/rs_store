<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>商品详情</title>
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
    <link rel="stylesheet" type="text/css" href="${path }/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/loading.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/goods-detail.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <script type="text/javascript" src="${path }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path }/js/mui.js"></script>
    <script type="text/javascript" src="${path}/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="${path}/js/layer.js"></script>
    <script type="text/javascript">
        $(window).load(function () {
            $(".loading").addClass("loader-chanage")
            $(".loading").fadeOut(300)
        })
    </script>
</head>
<body>
<form id="data-form" action="${path}/order/commitPage" method="post">
    <!-- -->
    <input type="hidden" id="goodsId" name="goodsId" value="${resultDate.goods_id}">
    <input type="hidden" name="goodsImg" value="${resultDate.goods_img}">
    <input type="hidden" name="goodsName" value="${resultDate.goods_name}">
    <input type="hidden" id="salePrice" name="salePrice" value="${salePricePage}">
    <input type="hidden" name="timePrice" value="${resultDate.time_price}">
    <input type="hidden" name="depositPrice" value="${resultDate.deposit_money}">
    <input type="hidden" id="goodsCount" name="goodsCount" value="1">
    <input type="hidden" name="isSingle" value="${resultDate.is_single}">
    <input type="hidden" name="partnersId" value="${resultDate.partners_id}">
    <input type="hidden" name="partnersName" value="${resultDate.partners_name}">
    <input type="hidden" name="advancePrice" value="${resultDate.advance_price}"><!-- 订单预付款 -->
    <input type="hidden" id="timeGoodsId" name="timeGoodsId" value="${timeGoodsId}">
    <input type="hidden" name="isPayOnline" value="${resultDate.is_pay_online}">
    <input type="hidden" name="goodsAdvancePrice" value="${resultDate.goods_advance_price}"><!-- 商品预付款 -->
    <input type="hidden" name="cartId" value="0">
    <input type="hidden" id="addrType" name="addrType" value="${resultDate.addr_type}"><!-- 系统设置的取货方式1邮寄2平台地址 -->
    <input type="hidden" id="getWay" name="getWay" value="${resultDate.get_way}">
</form>
<!-- -->
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
    <span class="title-name">商品详情</span>
    <div id="shopCardBtn" class="link-url shopCardBtn"></div>
    <span class="shopCardBtn-buyCount">${resultDate.card_count}</span>
    <div id="homeBtn" class="homeBtn"></div>
</header>
<div id="container">
    <div class="warp warptwo clearfloat">
        <div class="detail clearfloat">
            <!--banner star-->
            <div class="banner swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach items="${resultDate.goods_bannel}" var="item">
                        <div class="swiper-slide">
                            <a href="javascript:void(0)"><img class="swiper-lazy" data-src="${item.img_url}" alt=""></a>
                        </div>
                    </c:forEach>
                </div>
                <div class="swiper-pagination"></div>
            </div>
            <!--banner end-->
            <div class="top clearfloat box-s">
                <div class="shang clearfloat">
                    <div class="zuo clearfloat fl over2 box-s">
                        ${resultDate.goods_name}
                    </div>
                </div>
                <div class="xia clearfloat">
                    <p class="price fl box-s"><samp class="now-price-fh">￥</samp><samp
                            class="now-price">${salePricePage}</samp><samp
                            class="true-price">￥<s>${truePricePage}</s></samp></p>
                    <span class="fr">
                        销量${resultDate.shell_count} ${resultDate.goods_unit}<br>
                        库存${storePage} ${resultDate.goods_unit}
                    </span>
                </div>
            </div>
            <div class="clearfloat" style="padding-right: 10px">
                <h2 class="fl" style="line-height: .4rem;padding: 0 5%;">购买数量</h2>
                <div class="fr">
                    <div class="mui-numbox" data-numbox-min='0'>
                        <button class="mui-btn mui-numbox-btn-minus" type="button">-</button>
                        <input class="mui-numbox-input" type="number"/>
                        <button class="mui-btn mui-numbox-btn-plus" type="button">+</button>
                    </div>
                </div>
            </div>
            <div class="middle clearfloat box-s">
                <span class="fl">取货方式</span>
                <i class="fr">
                    <c:choose>
                        <c:when test="${resultDate.get_way==1}">
                            邮寄
                        </c:when>
                        <c:when test="${resultDate.get_way==4}">
                            自取
                        </c:when>
                        <c:when test="${resultDate.get_way==5}">
                            配送
                        </c:when>
                        <c:otherwise>
                            未知
                        </c:otherwise>
                    </c:choose>
                </i>
            </div>
            <div class="middle clearfloat box-s" onclick="showNeedNotice()">
                <span class="fl">订购须知</span>
                <i class="iconfont icon-jiantou1 fr" id="needKnow"></i>
            </div>
            <div class="goods-detail">
                <div class="goods-need-notice">
                    <div>
                        <p>注意：</p>
                        <p>1、为了提供更优质的商品和贴心的服务,本平台主要目的是方便消费者选择商品,平台不做任何在线付款。</p>
                        <p>2、平台所有商品保证来源于正规途径,实事求是,不夸大商品性质,消费者可以放心下单。</p>
                        <p>3、下单后,生成的订单价格即为消费者认可的总价格。</p>
                        <p>4、如果平台方认为订单价格或者商品价格不正确,则有权利取消订单,并告知消费者取消原因。</p>
                        <p>5、为了维护消费着权益,下单后收到商品,如果消费者不满意,任何时候都可以拒收。没有特别注明,不会收取任何费用。</p>
                        <p>
                            6、为了防止不法分子篡改和利用本平台作从事非法事情,消费者在收到商品时,应当认真核对商品,确认商品是否有质量问题和安全问题,确认无误后再付款。如果因为签收的商品给消费者带来损失,由消费者自己承担,平台方不承担任何法律责任。</p>
                        <p>7、用户收到货时,应该认真确认商品质量,如果有问题,请务必拒收。签收付款后,如果因为签收的商品给消费者带来损失,由消费者自己承担,平台方不承担任何法律责任。</p>
                        <p>
                            8、用户应提前了解选择下单商品是否合适自己,确认商品是否会给自己或者家人造成损失,然后再决定是否要签收商品。签收付款后,如果因为签收的商品给消费者带来损失,由消费者自己承担,平台方不承担任何法律责任。</p>
                        <p>9、最终是否发货,由平台方决定,最终解释权归平台所有。</p>
                    </div>
                </div>
                <div class="middle clearfloat box-s">
                    <span class="fl">商品详情</span>
                </div>
                <div class="goods-detail">
                    <div class="goods-detail-info">
                        <div>${resultDate.goods_intro}</div>
                    </div>
                    <div class="goods-detail-img">
                        <c:forEach items="${resultDate.goods_img_info}" var="item">
                            <span><img src="${item.img_url}"></span>
                        </c:forEach>
                    </div>
                </div>
                <div style="height: .13rem;"></div>
            </div>
        </div>
    </div>
    <footer class="detail-footer">
        <div class="div-1">
            <a href="${path}/center/userCenter">
                <div class="icon i-4"></div>
                <p>我的</p>
            </a>
        </div>
        <div class="div-2">
            <a href="${path}/center/toServicePage">
                <div class="icon i-5"></div>
                <p>客服</p>
            </a>
        </div>
        <c:choose>
            <c:when test="${isAddtoCard=='1'}">
                <div id="addToCard" onclick="javascript:addToOrderCard(${resultDate.goods_id})" class="div-p div-3">
                    加入购物车
                </div>
                <div id="buyNow" class="div-p div-4">立即购买</div>
            </c:when>
            <c:otherwise>
                <div id="buyNow" class="div-p div-5" onclick="submitData()">立即购买</div>
            </c:otherwise>
        </c:choose>
    </footer>
</body>
<!--插件-->
<link rel="stylesheet" type="text/css" href="${path }/css/swiper.min.css">
<script type="text/javascript" src="${path }/js/swiper.jquery.min.js"></script>
<script type="text/javascript" src="${path }/js/onclick.js"></script>
<script>

    $(function () {
        var banner = new Swiper('.banner', {
            autoplay: 5000,
            pagination: '.swiper-pagination',
            paginationClickable: true,
            lazyLoading: true,
            loop: true
        });

        $('a.slide-menu').on('click', function (e) {
            var wh = $('div.wrapper').height();
            $('div.slide-mask').css('height', wh).show();
            $('aside.slide-wrapper').css('height', wh).addClass('moved');
        });

        $('div.slide-mask').on('click', function () {
            $('div.slide-mask').hide();
            $('aside.slide-wrapper').removeClass('moved');
        });

        $('.div-p.div-4').on('click', function () {
            var store = '${resultDate.goods_num}';
            if (Number(store) > 0) {
                submitData();
            } else {
                alertMsg("商品库存不足", 2);
            }
        });

    });

    function alertMsg(msg, time) {
        //提示
        layer.open({
            content: msg
            , skin: 'msg'
            , time: time //2秒后自动关闭
        });
    }

    //下单
    function submitData() {
        var store = '${storePage}';//商品库存
        var goodsCount = $(".mui-numbox-input").val();//购买数
        if (Number(store) < Number(goodsCount)) {
            alertMsg("商品库存不足", 2);
            return;
        }
        $("#goodsCount").val(goodsCount);

        //检验商品收货方式
        var addrType = $("#addrType").val();//系统设置的收货方式1全国地址2平台地址
        var getWay = $("#getWay").val();//取货方式1邮寄4自取5配送
        if ((addrType == '1' && getWay != 1) || (addrType == '2' && getWay == 1)) {
            alertMsg("当前平台不支持该商品取货方式", 2);
            return;
        }
        var data = {
            goodsId: $("#goodsId").val(),
            timeGoodsId: $("#timeGoodsId").val(),
            orderCount: goodsCount,
            goodsSpace: "",
            salePrice: $("#salePrice").val()
        }

        $.ajax({
            type: "post",
            data: data,
            async: false,
            cache: false,
            url: "${path}/goods/checkGoodsOrder",
            dataType: "json",
            type: "post",
            success: function (data) {
                if (data.flag == 1) {
                    $("#data-form").submit();
                } else if (data.flag == 2) {
                    alertMsg("请先登录", 2);
                    window.location.href = "${path}/user/loginPage";
                } else {
                    alertMsg(data.msg, 2);
                }
            }
        });
    }

    //增加到购物车
    function addToOrderCard(goodsId) {
        var goodsCount = $(".mui-numbox-input").val();
        $.ajax({
            type: "post",
            data: {goodsId: goodsId, isSingle:${resultDate.is_single}, goodsCount: goodsCount},
            async: false,
            cache: false,
            url: "${path}/car/add/shopCar",
            dataType: "json",
            success: function (data) {
                if (data.flag == 1) {
                    alertMsg(data.msg, 2);
                    var num = $(".shopCardBtn-buyCount").html();
                    $(".shopCardBtn-buyCount").html(Number(num) + Number(goodsCount));
                } else if (data.flag == 2) {
                    alertMsg("请先登录", 2);
                    window.location.href = "${path}/user/loginPage";
                } else {
                    alertMsg(data.msg, 2);
                }
            }
        });

    }
</script>
<script>
    function showNeedNotice() {
        var none = $(".goods-need-notice").css('display');
        if ("none" == none) {
            $("#needKnow").attr("class", "iconfont icon-jiantouxia fr");
            $(".goods-need-notice").show();
        } else {
            $("#needKnow").attr("class", "iconfont icon-jiantou1 fr");
            $(".goods-need-notice").hide();
        }

    }
</script>
</html>
