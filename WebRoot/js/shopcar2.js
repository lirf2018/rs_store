$(document).ready(function () {
    //减少购买数量  
    $(".zuo.clearfloat.fl>ul>li:first-child").bind("click", function () {
        var cardId = $(this).attr("data-cardId");
        var click = $(this).parent().children("li");
        var buyCount = $(this).parent().parent().parent().children("input:first-child");
        //当前数量
        var nowNum = Number(click.eq(1).html());
        if (Number(nowNum - 1) == 0) {
            return;
        }
        click.eq(1).html(Number(nowNum - 1));
        buyCount.val(Number(nowNum - 1));
        needMoney();
        updateShopCount(cardId, buyCount.val());
    });

    //增加购买数量
    $(".zuo.clearfloat.fl>ul>li:last-child").bind("click", function () {
        var cardId = $(this).attr("data-cardId");
        var click = $(this).parent().children("li");
        var buyCount = $(this).parent().parent().parent().children("input:first-child");
        //当前数量
        var nowNum = Number(click.eq(1).html());
        click.eq(1).html(Number(nowNum + 1));
        buyCount.val(Number(nowNum + 1))
        needMoney();
        updateShopCount(cardId, buyCount.val());
    });
    //删除商品
    $(".bottom.clearfloat>i").bind("click", function () {
        var deleteGoodsId = $(this).children("span").html();
        deletCardGoods(deleteGoodsId + ",");
        needMoney();
    });

    //修改购物车数量
    function updateShopCount(cardId, count) {
        $.ajax({
            type: "post",
            data: {cardId: cardId, count: count},
            async: false,
            cache: false,
            url: path + "/car/update/shopCar",
            dataType: "json",
            success: function (data) {
                if (data.flag == 1) {
                    // alertMsg(data.msg, 2);
                    $("#goodsCount" + cardId).val(count);
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

function choseCheckParent() {
    var obj = $("input[name='selectAll']");
    if (true == $(obj).prop("checked")) {
        $("input[name='checkSub']").prop("checked", false);
    } else {
        $("input[name='checkSub']").prop("checked", true);
    }
    needMoney();
}

$("input[name='checkSub']").on('click', function (e) {
    var checkSub = $("input[name='checkSub']:checkbox");
    var count = 0;
    checkSub.each(function () {
        if (true == $(this).prop("checked")) {
            count = count + 1;
        }
    })
    if (count == checkSub.size()) {
        $("input[name='selectAll']:checkbox").prop("checked", true);
    } else {
        $("input[name='selectAll']:checkbox").prop("checked", false);
    }
    needMoney();

});

$(".select-all2>div:last-child").on('click', function (e) {
    var checkSub = $("input[name='checkSub']:checkbox");
    var select = 0;
    checkSub.each(function () {
        if (true == $(this).prop("checked")) {
            select = select + 1;
        }
    })
    if (select == 0) {
        alertMsg("选择要删除的商品", 2);
        return;
    }
    layer.open({
        content: '是否删除选中商品？',
        btn: ['确认', '取消'],
        yes: function (index) {
            var checkSub = $("input[name='checkSub']:checkbox");
            var cardIds = "";
            checkSub.each(function () {
                if (true == $(this).prop("checked")) {
                    cardIds = cardIds + this.value + ",";
                }
            })
            deletCardGoods(cardIds);
        }
    });
});

//删除无效商品
$(".shop-name>span>i").on('click', function (e) {
    var cardIds = "";
    var uneffGoods = $("input[name='uneff-goods']");
    uneffGoods.each(function () {
        cardIds = cardIds + this.value + ",";
    })

    layer.open({
        content: '是否删除无效商品？',
        btn: ['确认', '取消'],
        yes: function (index) {
            deletCardGoods(cardIds);
            location.reload();
            layer.close(index);
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

//计算价格
function needMoney() {
    var checkSub = $("input[name='checkSub']:checkbox");
    var allPrice = 0;
    checkSub.each(function () {
        if (true == $(this).prop("checked")) {
            //价格=单价X数量
            var price = $("input[name=price" + this.value + "]").val();
            var buyCount = $("input[name=buy_count" + this.value + "]").val();
            var accMul = myAccMul(price, buyCount);
            allPrice = myAccAdd(allPrice, accMul);
        }
    })
    allPrice = allPrice + "";
    if (allPrice.indexOf(".") < 0) {
        allPrice = allPrice + ".00"
    }
    var length = allPrice.length;
    var pointIndex = allPrice.indexOf(".");
    var m = length - pointIndex;
    if (Number(m) == 2) {
        allPrice = allPrice + "0"
    }

    if (allPrice == 0) {
        allPrice = "0.00"
    }
    $("#allPrice>span:first-child").html("合计：" + allPrice);
}

/**
 * 购物车去结算
 */
$('.div-p.div-4').on('click', function (e) {

    //校验取货方式
    var userChoseAddrType = $("#userChoseAddrType").val();
    if (userChoseAddrType == -1) {
        alertMsg("先选择商品取货方式", 2);
        return;
    }

    var checkSub = $("input[name='checkSub']:checkbox");
    var cardIds = "";
    var f = false;
    checkSub.each(function () {
        if (true == $(this).prop("checked")) {
            cardIds = cardIds + this.value + ",";
            if (!f) {
                f = true;
            }
        }
    });
    if (!f) {
        alertMsg("选择商品", 2)
        return;
    }

    //判断商品取货方式与系统是否一致
    var addrType = $("#addrType").val();//1邮寄2平台地址
    f = false;
    checkSub.each(function () {
        if (true == $(this).prop("checked")) {
            var getWay = $("#getWay-" + this.value).val();
            if ((addrType == '1' && (getWay != 4 || getWay != 5)) || (addrType == '2' && (getWay == 4 || getWay == 5))) {
                if (!f) {
                    f = true;
                }
            }
        }
    });
    if (!f) {
        if (addrType == '1') {
            alertMsg("当前平台支持的取货方式为邮寄", 2);
        } else if (addrType == '2') {
            alertMsg("当前平台支持的取货方式为自取/配送", 2);
        } else {
            alertMsg("当前商品不支持订购", 2);
        }
        return;
    }


    $("#selectCardIds").val(cardIds);

    var flag = true;
    var indexPartnersId = "";
    checkSub.each(function () {
        if (true == $(this).prop("checked")) {
            if (indexPartnersId == '') {
                indexPartnersId = $("#partnersId" + this.value).val();
            } else {
                if (Number($("#partnersId" + this.value).val()) != Number(indexPartnersId)) {
                    flag = false;
                    return false;
                }
            }

        }
    })
    if (flag) {
        $.ajax({
            type: "post",
            data: {cardIds: cardIds},
            async: false,
            cache: false,
            url: path + "/car/check/shopCarOrder",
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
    } else {
        alertMsg("只能选择同一商家的商品", 2);
    }
});

function deletCardGoods(cardIds) {
    $.ajax({
        type: "post",
        data: {cardIds: cardIds},
        async: false,
        cache: false,
        url: path + "/car/delete/shopCar",
        dataType: "json",
        success: function (data) {
            if (data.flag == 1) {
                alertMsg(data.msg, 2);
                var userChoseAddrType = $("#userChoseAddrType").val();
                choseAddrOnclick(userChoseAddrType)
            } else if (data.flag == 2) {
                alertMsg("请先登录", 2);
                window.location.href = "${path}/user/login";
            } else {
                alertMsg(data.msg, 2);
            }
        }
    });
}

//选择取货方式
function choseAddr() {
    //取货方式
    var userChoseAddrType = $("#userChoseAddrType").val();
    var html = '<div class="show-chose-addr-btn">\n';
    if (userChoseAddrType == -1) {
        html = html + '        <span  style="border: 1px solid #06c1ae;" onclick="choseAddrOnclick(-1)" data-mark="-1">全部</span>\n';
    } else {
        html = html + '        <span onclick="choseAddrOnclick(-1)" data-mark="-1">全部</span>\n';
    }
    if (userChoseAddrType == 1) {
        html = html + '        <span  style="border: 1px solid #06c1ae;" onclick="choseAddrOnclick(1)" data-mark="1">邮寄</span>\n';
    } else {
        html = html + '        <span onclick="choseAddrOnclick(1)" data-mark="1">邮寄</span>\n';
    }
    if (userChoseAddrType == 4) {
        html = html + '        <span  style="border: 1px solid #06c1ae;" onclick="choseAddrOnclick(4)" data-mark="4">自取</span>\n';
    } else {
        html = html + '        <span onclick="choseAddrOnclick(4)" data-mark="4">自取</span>\n';
    }
    if (userChoseAddrType == 5) {
        html = html + '        <span  style="border: 1px solid #06c1ae;" onclick="choseAddrOnclick(5)" data-mark="5">配送</span>\n';
    } else {
        html = html + '        <span onclick="choseAddrOnclick(5)" data-mark="5">配送</span>\n';
    }
    html = html + '    </div>';

    //底部对话框
    layer.open({
        content: html
        , style: 'border:none;' //自定风格
    });
}
