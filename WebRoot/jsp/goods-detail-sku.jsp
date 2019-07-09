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
    <link rel="stylesheet" type="text/css" href="${path}/js/need/layer.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/goods-detail.css"/>
    <script type="text/javascript" src="${path }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path }/js/mui.js"></script>
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
    <input type="hidden" id="goodsSpaceCode" name="goodsSpaceCode" value="">
    <input type="hidden" id="goodsSpaceCodeName" name="goodsSpaceCodeName" value="">
    <input type="hidden" id="goodsSpaceCodeNameStr" name="goodsSpaceCodeNameStr" value="">
    <input type="hidden" name="goodsId" value="${resultDate.goods_id}">
    <input type="hidden" name="goodsImg" value="${resultDate.goods_img}">
    <input type="hidden" name="goodsName" value="${resultDate.goods_name}">
    <input type="hidden" id="salePrice" name="salePrice" value="${skuMaxPrice}">
    <input type="hidden" name="timePrice" value="${resultDate.time_price}">
    <input type="hidden" name="depositPrice" value="${resultDate.deposit_money}">
    <input type="hidden" id="goodsCount" name="goodsCount" value="1">
    <input type="hidden" name="isSingle" value="${resultDate.is_single}">
    <input type="hidden" name="partnersId" value="${resultDate.partners_id}">
    <input type="hidden" name="partnersName" value="${resultDate.partners_name}">
    <input type="hidden" name="advancePrice" value="${resultDate.advance_price}"><!-- 订单预付款 -->
    <input type="hidden" name="timeGoodsId" value="${timeGoodsId}">
    <input type="hidden" name="isPayOnline" value="${resultDate.is_pay_online}">
    <input type="hidden" name="goodsAdvancePrice" value="${resultDate.goods_advance_price}"><!-- 商品预付款 -->
    <input type="hidden" name="cartId" value="0">
    <input type="hidden" id="skuStore" value="0">
    <input type="hidden" id="addrType" name="addrType" value="${resultDate.addr_type}"><!-- 系统设置的取货方式1邮寄2平台地址 -->
    <input type="hidden" id="getWay" name="getWay" value="${resultDate.get_way}">
</form>
<input type="hidden" id="store" value="0">
<input type="hidden" id="clickBtn" value="0"><!-- 0 加入购物车  1 下单 -->
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
                            <a href="javascript:void(0)"><img class="swiper-lazy" data-src="${item.img_url}"></a>
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
                    <p class="price fl box-s">
                        <samp class="now-price-fh">￥</samp>
                        <samp class="now-price">${salePricePage}</samp>
                    </p>
                    <span class="fr">
                        销量${resultDate.shell_count} ${resultDate.goods_unit}<br>
                        库存${storePage} ${resultDate.goods_unit}
                    </span>
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
            <div id="addToCard" class="div-p div-3">
                加入购物车
            </div>
            <div id="buyNow" class="div-p div-4">立即购买</div>
        </c:when>
        <c:otherwise>
            <div id="buyNow" class="div-p div-4  div-5">
                立即购买
            </div>
        </c:otherwise>
    </c:choose>
</footer>

<!--选择商品属性弹出框-->
<div class="mui-backdrop"></div>
<div class="g-detail">
    <div class="g-detail-top">
        <div class="g-detail-close"><img src="${path}/img/quit_button.png"/></div>
        <div class="g-top-img fl"><img src="${resultDate.goods_img}"/></div>
        <div class="g-top-info fl">
            <h2>${resultDate.goods_name}</h2>
            <p class="price sku-price">
                <samp class="now-price-fh">￥</samp>${salePricePage}
            </p>
            <p class="select select-sku">请选择规格</p>
            <p class="select">库存：<span>${storePage}</span> ${resultDate.goods_unit}</p>
        </div>
    </div>
    <div class="goods-spece">
        <div class="g-detail-color">
            <c:forEach items="${resultDate.goods_item_sales}" var="itemP">
                <h2>${itemP.prop_name}</h2>
                <ul>
                    <c:forEach items="${itemP.value_list}" var="itemS">
                        <li data-valueId="${itemS.value_id}" data-valueName="${itemS.value_name}"
                            data-propName="${itemP.prop_name}">${itemS.value_name}</li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
        <div class="g-detail-num">
            <h2 class="fl">购买数量</h2>
            <div class="fr">
                <div class="mui-numbox" data-numbox-min='0'>
                    <button class="mui-btn mui-numbox-btn-minus" type="button">-</button>
                    <input class="mui-numbox-input" type="number"/>
                    <button class="mui-btn mui-numbox-btn-plus" type="button">+</button>
                </div>
            </div>
        </div>
    </div>
    <div class="g-detail-btn">
        <button type="button">确定</button>
    </div>
</div>
</body>
<!--插件-->
<link rel="stylesheet" type="text/css" href="${path }/css/swiper.min.css">
<script type="text/javascript" src="${path }/js/swiper.jquery.min.js"></script>
<script type="text/javascript" src="${path }/js/onclick.js"></script>
<script>$(function () {
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

    //确定
    $('.g-detail-btn>button').on('click', function (e) {
        var goodsCount = $(".mui-numbox-input").val();
        //判断是否已经选择了规格
        var spaceSize = '${resultDate.goods_item_sales.size()}';
        var count = 0;
        var goodsSpec = "";
        var i = $(".g-detail-color , .g-detail-size");
        var p = i.find("ul > li");
        p.each(function () {
            if ($(this).hasClass("current")) {
                count = count + 1;
                goodsSpec = goodsSpec + $(this).attr("data-valueId") + ";"
            }
        })
        if (parseInt(spaceSize) != parseInt(count)) {
            //提示
            alertMsg("请选择商品规格", 2);
            return;
        }
        //判断库存
        var skuStore = $("#skuStore").val();
        if (Number(skuStore) < goodsCount) {
            alertMsg("该商品规格库存不足", 2);
            return;
        }
        var clickBtn = $("#clickBtn").val();
        if (Number(clickBtn) == 1) {
            submitData();
        } else {
            //加入购物车
            $.ajax({
                type: "post",
                data: {
                    goodsId: ${resultDate.goods_id},
                    isSingle:${resultDate.is_single},
                    goodsSpec: goodsSpec,
                    goodsCount: goodsCount
                },
                async: false,
                cache: false,
                url: "${path}/car/add/shopCar",
                dataType: "json",
                success: function (data) {
                    if (data.flag == 1) {
                        alertMsg(data.msg, 2);
                        var num = $(".shopCardBtn-buyCount").html();
                        $(".shopCardBtn-buyCount").html(Number(num) + 1);
                        $(".mui-backdrop").hide();
                        $(".g-detail").slideUp();
                    } else if (data.flag == 2) {
                        alertMsg("请先登录", 2);
                        window.location.href = "${path}/user/loginPage";
                    } else {
                        alertMsg(data.msg, 2);
                    }
                }
            });
        }
    });

});
//点击购买弹出遮罩
$(function () {
    $("#addToCard").click(function () {
        //初始化规格选择
        $(".g-detail-color>ul>li").removeClass("current");//
        $(".mui-backdrop").show();
        $(".g-detail").slideDown();
        $("#clickBtn").val(0);
    })
    $(".g-detail-close").click(function () {
        $(".mui-backdrop").hide();
        $(".g-detail").slideUp();
    })
})
$(function () {
    $("#buyNow").click(function () {
        //初始化规格选择
        $(".g-detail-color>ul>li").removeClass("current");//
        $(".mui-backdrop").show();
        $(".g-detail").slideDown();
        $("#clickBtn").val(1);
    })
    $(".g-detail-close").click(function () {
        $(".mui-backdrop").hide();
        $(".g-detail").slideUp();
    })
})
$(function () {
    $(".g-detail-color , .g-detail-size").each(function () {
        //初始值
        $(".select>span").html('${storePage}');
        $(".sku-price").html('<samp class="now-price-fh">￥</samp>${salePricePage}');
        $("#goodsSpaceCode").val("");
        $("#goodsSpaceCodeName").val("");
        $("#goodsSpaceCodeNameStr").val("");
        $("#skuStore").val(0);
        $("#salePrice").val('${skuMaxPrice}');

        var i = $(this);
        var p = i.find("ul > li");
        p.click(function () {
            if (!!$(this).hasClass("current")) {
                $(this).removeClass("current");
            }
            else {
                $(this).addClass("current").siblings("li").removeClass("current");
            }
            setSkuInfo();
        })
    })

    //设置sku信息
    function setSkuInfo() {
        var spaceSize = '${resultDate.goods_item_sales.size()}';
        var count = 0;
        var goodsSpec = "";//选中的规则
        var goodsSpecName = "";//选中的规则名称
        var goodsSpecNameStr = "";//选中的规则名称Str
        var i = $(".g-detail-color , .g-detail-size");
        var p = i.find("ul > li");
        p.each(function () {
            if ($(this).hasClass("current")) {
                count = count + 1;
                goodsSpec = goodsSpec + $(this).attr("data-valueId") + ";"
                goodsSpecName = goodsSpecName + $(this).attr("data-valueName") + ";"
                goodsSpecNameStr = goodsSpecNameStr + $(this).attr("data-propName") + ":" + $(this).attr("data-valueName") + " "
            }
        })
        if (parseInt(spaceSize) == parseInt(count)) {
            //每项规格选择后
            $("#goodsSpaceCode").val(goodsSpec);
            $("#goodsSpaceCodeName").val(goodsSpecName);
            $("#goodsSpaceCodeNameStr").val(goodsSpecNameStr.trim());
            $(".select.select-sku").html(goodsSpecNameStr.trim());

            //设置为sku具体规格参数(sku库存)
            var skuStoreSize = '${listSkuStore}';
            var skuObj = eval("(" + skuStoreSize + ")");
            for (var i = 0; i < skuObj.length; i++) {
                var map = skuObj[i];
                for (var key in map) {
                    if (key == goodsSpec) {
                        $(".select>span").html(map[key]);
                        $("#skuStore").val(map[key]);
                    }
                }
            }
            //设置为sku具体规格参数(sku价格)
            var skuPriceSize = '${listSkuPrice}';
            var skuPriceObj = eval("(" + skuPriceSize + ")");
            for (var i = 0; i < skuPriceObj.length; i++) {
                var map = skuPriceObj[i];
                for (var key in map) {
                    if (key == goodsSpec) {
                        $(".g-top-info.fl>.price").html(map[key]);
                        $(".sku-price").html('<samp class="now-price-fh">￥</samp>' + map[key]);
                        $("#salePrice").val(map[key]);
                    }
                }
            }
            //设置为sku具体规格参数(sku价格图片)
            var skuImgSize = '${listSkuImg}';
            var skuImgObj = eval("(" + skuImgSize + ")");
            for (var i = 0; i < skuImgObj.length; i++) {
                var map = skuImgObj[i];
                for (var key in map) {
                    if (key == goodsSpec) {
                        $(".g-top-img,.fl>img").attr('src', map[key]);
                    }
                }
            }

        } else {
            //默认商品参数
            $(".select>span").html('${storePage}');
            $(".sku-price").html('<samp class="now-price-fh">￥</samp>${salePricePage}');
            $("#goodsSpaceCode").val("");
            $("#goodsSpaceCodeName").val("");
            $("#goodsSpaceCodeNameStr").val("");
            $("#store").val(0);
            $(".select.select-sku").html("请选择规格");
            $("#skuStore").val(0);
            $("#salePrice").val('${skuMaxPrice}');

        }
    }
})

function submitData() {
    var goodsCount = $(".mui-numbox-input").val();
    $("#goodsCount").val(goodsCount);

    //检验商品收货方式
    var addrType = $("#addrType").val();//系统设置的收货方式1全国地址2平台地址
    var getWay = $("#getWay").val();//取货方式1邮寄4自取5配送
    if ((addrType == '1' && getWay != 1) || (addrType == '2' && getWay == 1)) {
        alertMsg("当前平台不支持该商品取货方式", 2);
        return;
    }

    $.ajax({
        type: "post",
        data: {
            goodsId: '${resultDate.goods_id}',
            timeGoodsId: 0,
            orderCount: goodsCount,
            goodsSpace: $("#goodsSpaceCode").val(),
            salePrice: $("#salePrice").val()
        },
        async: false,
        cache: false,
        url: "${path}/goods/checkGoodsOrder",
        dataType: "json",
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

    function alertMsg(msg, time) {
        //提示
        layer.open({
            content: msg
            , skin: 'msg'
            , time: time //2秒后自动关闭
        });
    }
</script>
</html>
