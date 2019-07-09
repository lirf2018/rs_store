/**
 * 提交订单
 */
function checkOrderAndSubmit() {

    //检验
    var advancePrice = $("#advancePrice").val();//预付款
    var discountsPrice = $("#discountsPrice").val();//优惠金额
    var discountsId = $("#discountsId").val();//用户优惠券标识
    var goodsCounts = $("#goodsCounts").val();//商品总数
    var needpayPrice = $("#needpayPrice").val();//待付款
    var orderPrice = $("#orderPrice").val();//订单付款价格
    var postPrice = $("#postPrice").val();//邮费
    var realPrice = $("#realPrice").val();//订单实际价格
    var advancePayWay = $("#inPayWay").val();//预付支付方式 //支付方式（根据入口环境得到支付方式） 预付支付方式 0现金付款1微信2支付宝3账户余额
    var userRemark = $("#userRemark").val();//用户留言
    var timeGoodsId = $("#timeGoodsId").val();
    var timePrice = $("#timePrice").val();
    var depositPriceAll = $("#depositPriceAll").val();
    var userAddrId = $("#userAddrId").val() + "";
    var getDate = $("#getDate").val() + "";
    var sysAddrType = $("#sysAddrType").val() + "";//1全国地址2平台地址

    var userName = $("#userName").val();
    var userPhone = $("#userPhone").val();
    if (userName == '' || userName == null || userPhone == '' || userPhone == null) {
        alertMsg("缺少收货人信息", 2);
        return;
    }
    //判断选择地址
    if (userAddrId == '') {
        alertMsg("选择收货地址", 2);
        return;
    }
    //判断支付方式
    if (advancePayWay == -1 || advancePayWay == '') {
        alertMsg("选择支付方式", 2);
        return;
    }
    if (sysAddrType == 2 && getDate == "") {
        alertMsg("选择取货/配送日期", 2);
        return;
    }

    var goodsId = "";
    var goodsIdObj = $("input[name='goodsId']");
    goodsIdObj.each(function (e) {
        goodsId = goodsId + $(this).val() + ",";
    });
    var saleMoney = "";
    var saleMoneyObj = $("input[name='saleMoney']");
    saleMoneyObj.each(function (e) {
        saleMoney = saleMoney + $(this).val() + ",";
    });
    var cartId = "";
    var cartIdObj = $("input[name='cartId']");
    cartIdObj.each(function (e) {
        cartId = cartId + $(this).val() + ",";
    });
    var goodsCount = "";
    var goodsCountObj = $("input[name='goodsCount']");
    goodsCountObj.each(function (e) {
        goodsCount = goodsCount + $(this).val() + ",";
    });
    var goodsPpec = "";
    var goodsPpecObj = $("input[name='goodsPpec']");
    goodsPpecObj.each(function (e) {
        goodsPpec = goodsPpec + $(this).val() + ",";
    });
    var goodsSpecName = "";
    var goodsSpecNameObj = $("input[name='goodsSpecName']");
    goodsSpecNameObj.each(function (e) {
        goodsSpecName = goodsSpecName + $(this).val() + ",";
    });
    var goodsSpecNameStr = "";
    var goodsSpecNameStrObj = $("input[name='goodsSpecNameStr']");
    goodsSpecNameStrObj.each(function (e) {
        goodsSpecNameStr = goodsSpecNameStr + $(this).val() + ",";
    });
    var isSingle = "";
    var isSingleObj = $("input[name='isSingle']");
    isSingleObj.each(function (e) {
        isSingle = isSingle + $(this).val() + ",";
    });
    var getDate = $("#getDate").val();

    var data = {
        advancePrice: advancePrice,
        discountsPrice: discountsPrice,
        discountsId: discountsId,
        goodsCounts: goodsCounts,
        needpayPrice: needpayPrice,
        orderPrice: orderPrice,
        postPrice: postPrice,
        realPrice: realPrice,
        advancePayWay: advancePayWay,
        userRemark: userRemark,
        timeGoodsId: timeGoodsId,
        timePrice: timePrice,
        depositPriceAll: depositPriceAll,
        goodsId: goodsId,
        saleMoney: saleMoney,
        cartId: cartId,
        goodsCount: goodsCount,
        goodsPpec: goodsPpec,
        goodsSpecName: goodsSpecName,
        goodsSpecNameStr: goodsSpecNameStr,
        isSingle: isSingle,
        userAddrId: userAddrId,
        userName: userName,
        userPhone: userPhone,
        getDate: getDate
    }

    $.ajax({
        type: "post",
        data: data,
        async: false,
        cache: false,
        url: path + "/order/checkOrderData",
        dataType: "json",
        success: function (data) {
            var flag = data.flag;
            if (flag === "ok") {
                //提交订单
                $("#data-form").submit();
            } else if (flag === "false") {
                alertMsgCommon(data.msg, 2);
            } else {
                alertMsgCommon("网络异常,请稍后再试", 2);
            }
        }
    });
}


/**
 * 选择支付方式 //支付方式（根据入口环境得到支付方式） 预付支付方式 0现金付款1微信2支付宝3账户余额
 */
$(".chose-payway").on('click', function (e) {
    var payHtml = "<div data-value='0'  data-name='现金付款'>" +
        "   <span><img src='../img/nowPay36x36.png' width='30px' height='30px'></span>" +
        "   <span>现金付款</span>" +
        "   <span>&gt;</span>" +
        "</div>";
    var weixin = "<div data-value='1'  data-name='微信'>" +
        "   <span><img src='../img/wechat36x36.png' width='30px' height='30px'></span>" +
        "   <span>微信</span>" +
        "   <span>&gt;</span>" +
        "</div>";
    var aliPay = "<div data-value='2'  data-name='支付宝'>" +
        "   <span><img src='../img/alipay36x36.png' width='30px' height='30px'></span>" +
        "   <span>支付宝</span>" +
        "   <span>&gt;</span>" +
        "</div>";
    var accountPay = "<div data-value='3'  data-name='账户余额'>" +
        "   <span><img src='../img/accountmoney36x36.png' width='30px' height='30px'></span>" +
        "   <span>账户余额</span>" +
        "   <span>&gt;</span>" +
        "</div>";

    var array = eval("(" + payTypeArray + ")");
    for (var i = 0; i < array.length; i++) {
        if (array[i] == 1) {
            payHtml = payHtml + weixin
        } else if (array[i] == 2) {
            payHtml = payHtml + aliPay
        } else if (array[i] == 3) {
            payHtml = payHtml + accountPay
        }
    }
    // payHtml = nowPay+weixin+aliPay+noPay+otherPay+accountPay;

    var html = "<div class='pay-way-new'><div class='pay-title'>选择支付方式 <u style='font-size: 8px;padding-left: 10px'></u></div>" + payHtml + "</div>";

    var payLayer = layer.open({
        type: 1
        , content: html
        , anim: 'up'
        , style: 'position:fixed; bottom:0; left:0; width: 100%;  padding:0px 0; border:none;'
    });
    initPayWayOnclick(payLayer);
});

//选择日期
$(".chose-getdate").on('click', function (e) {
    var getDate = $("#getDate").val();//当前选择的日期
    var getDateArray = eval("(" + getDateArrayJson + ")");
    var payHtml = "";
    for (var i = 0; i < getDateArray.length; i++) {
        if (getDate != '' && getDate == getDateArray[i]) {
            payHtml = payHtml + "<div class='chose-date' style='border: 1px solid #00cc7d' onclick='choseDateClick(this)' data-value='" + getDateArray[i] + "'>" + getDateArray[i] + "</div>";
        } else {
            payHtml = payHtml + "<div class='chose-date' onclick='choseDateClick(this)' data-value='" + getDateArray[i] + "'>" + getDateArray[i] + "</div>";
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
    $("#getDate").val(valueDate);
    $(".chose-getdate>b").html(valueDate);

    layer.closeAll()
}

function initPayWayOnclick(payLayer) {
    $(".pay-way-new>div:not(:first-child)").on('click', function (e) {
        $("#inPayWay").val($(this).attr("data-value"));
        $(".chose-payway>b").html($(this).attr("data-name"));
        layer.close(payLayer);
        doPriceAll();
    });
}

function alertMsg(msg, time) {
    //提示
    layer.open({
        content: msg
        , skin: 'msg'
        , time: time //2秒后自动关闭
    });
}

$(".add-addr-word").on('click', function (e) {
    if (addrType == '1') {
        showAddUserAddr();//弹出选择或者增加收货地址(全国)
    } else if (addrType == '2') {
        showPlatformAddr();//弹出平台地址
    } else {
        alertMsg("网络有误,请稍后重试", 2);
    }
});

//弹出选择或者增加收货地址
function showAddUserAddr() {
    var html = "<div>"
        + "<div class='add-edit-box'>"
        + "<div class='close-addr-div'><span class='close-addr-span'>X</span></div>"
        + "<span class='shouh'>"
        + "     <dl>"
        + "         <dd>收货人：<input id='addrUserName' name='addrUserName' type='text' value=''/></dd>"
        + "         <dd>电   话： <input id='addrUserPhone' name='addrUserPhone' type='text' value='" + phone + "'/></dd>"
        + "         <div class='clearx' style='height:10px'></div>"
        + "     </dl>"
        + "</span>"
        + "<section class='g-flexview'>"
        + "     <section class='g-scrollview'>"
        + "         <div class='m-cell'>"
        + "             <div class='cell-item'>"
        + "                 <div class='cell-left'>所在城市：</div>"
        + "                 <div class='cell-right cell-arrow'>"
        + "                     <input type='text' class='cell-input' readonly='' id='J_Address' value=''  placeholder='请选择收货地址'>"
        + "                 </div>"
        + "             </div>"
        + "         </div>"
        + "     </section>"
        + "     <div class='input-detail-addr'>"
        + "         <span>详情地址:</span>"
        + "         <span><input id='inChoseAddrDetail' value='' type='text' placeholder=''></span>"
        + "     </div>"
        + "</section>"
        + "<div class='default-addr'>"
        + "     <span>设置为默认收货地址</span>"
        + "     <span>"
        + "         <div class='toggle-button-wrapper'>"
        + "             <input type='checkbox'  id='toggle-button-1' class='chooseBtn'>"
        + "             <label for='toggle-button-1' class='button-label'>"
        + "                 <span class='circle'></span>"
        + "                 <span class='text on'>ON</span>"
        + "                 <span class='text off'>OFF</span>"
        + "             </label>"
        + "         </div>"
        + "     </span>"
        + "</div>"
        + "<div class='submit-add'><span>添加收货地址</span></div>"
        + "<div class='user-addr-list-titel'>"
        + "     <ul class='user-addr-list-ul'>"
        + "         <li><span>设置默认</span></li>"
        + "         <li><span>地址详情</span></li>"
        + "         <li><span>操作</span></li>"
        + "     </ul>"
        + "</div>"
        + "</div>"
        + "<div class='add-list-box'>"
        + "     <div class='user-addr-list'></div>"
        + "</div>"
        + "</div>";
    // var html = $("#addAddrDiv").html();
    // $("#addAddrDiv").html("")
    var addrLayer = layer.open({
        type: 1
        , content: html
        , anim: 'up'
        , shade: false
        , style: 'position:fixed; bottom:0; left:0; width: 100%; height:100%; padding:0px 0; border:none;'
    });
    var addeditbox = $('.add-edit-box').height();
    $('.add-list-box').css({
        height: $('body').height() - addeditbox,
        overflow: 'auto'
    });
    initCheckAddr(addrLayer);//绑定设置弹出选择省市
    checkDefaultAdd();//绑定设置默认收货地址事件
}

//初始化弹出选择或者增加收货地址其它信息对象
function initCheckAddr(addrLayer) {
    loadUserAddr();//加载用户收货地址列表
    var $target = $('#J_Address');
    $target.citySelect();

    $target.on('click', function (event) {
        event.stopPropagation();
        $target.citySelect('open');
    });

    $target.on('done.ydui.cityselect', function (ret) {
        console.log("-->" + ret)
        // var addr = ret.country + ' ' + ret.provance + ' ' + ret.city + ' ' + ret.area;
        var codes = ret.r_c;
        var addr = ret.provance + ret.city + ret.county + ret.town;
        if (codes.substr(codes.length - 1, codes.length)) {
            addr = ret.provance + ret.city + ret.county;
        }
        $(this).val(addr);
        $("#inChoseAddr").val(addr);
        $("#inChoseAddrCode").val(codes);
    });

    $(".close-addr-div").on('click', function (e) {
        var $target = $('#J_Address');
        $target.val("");
        $target.citySelect('close');
        layer.close(addrLayer);
    });


    $(".submit-add").on('click', function (e) {

        var addrUserName = $("#addrUserName").val()
        var addrUserPhone = $("#addrUserPhone").val()
        var inChoseAddrCode = $("#inChoseAddrCode").val() + "";//地址编码
        var inChoseAddr = $("#inChoseAddr").val() + "";//地址名称
        var inChoseAddrDetail = $("#inChoseAddrDetail").val() + "";

        if (addrUserName.trim() == '') {
            alertMsg("收货人姓名不能为空", 2);
            return;
        }

        if (addrUserPhone.trim() == '') {
            alertMsg("收货人电话不能为空", 2);
            return;
        }

        if (inChoseAddrCode == '') {
            alertMsg("所在城市不能为空", 2);
            return;
        }
        if (inChoseAddr == '') {
            alertMsg("所在城市不能为空", 2);
            return;
        }
        if (inChoseAddrDetail.trim() == '') {
            alertMsg("详细地址不能为空", 2);
            return;
        }
        //是否设置为默认
        var isDefaul = 0;
        if ($("#toggle-button-1").prop("checked")) {
            isDefaul = 1;
        }
        var data = {
            addrUserName: addrUserName,
            addrUserPhone: addrUserPhone,
            inChoseAddrCode: inChoseAddrCode,
            inChoseAddr: inChoseAddr,
            inChoseAddrDetail: inChoseAddrDetail,
            isDefaul: isDefaul
        }
        $.ajax({
            type: "post",
            data: data,
            async: false,
            cache: false,
            url: path + "/address/add/userAddress",
            dataType: "json",
            success: function (data) {
                var flag = data.flag;
                if (flag === 1) {
                    alertMsg("增加成功", 2);
                    resetPage();//清空页面
                    loadUserAddr();//加载用户收货地址列表
                    // return;
                } else {
                    alertMsg("网络异常,请稍后再试", 2);
                }
            }
        });
    });
}

$(".add-addr-detail>ul:first-child").on('click', function (e) {
    if (addrType == '1') {
        showAddUserAddr();//弹出选择或者增加收货地址(全国)
    } else if (addrType == '2') {
        showPlatformAddr();//弹出平台地址
    } else {
        alertMsg("网络有误,请稍后重试", 2);
    }
});

function loadUserAddr() {
    $.ajax({
        type: "post",
        data: {},
        async: false,
        cache: false,
        url: path + "/address/query/userAddress",
        dataType: "json",
        success: function (data) {
            var flag = data.flag;
            $(".user-addr-list").empty();
            if (flag === 1) {
                var list = data.msg;
                for (var i = 0; i < list.length; i++) {
                    var id = list[i].id;
                    var userName = list[i].user_name;
                    var phone = list[i].user_phone;
                    var addr = list[i].addr_name;
                    var freight = list[i].freight;
                    var isDefault = list[i].is_default;
                    var isDefaultCheck = "";
                    if (isDefault == 1) {
                        isDefaultCheck = "checked";
                    }
                    var html = "<ul class='user-addr-list-ul' >"
                        + "<li>"
                        + "<div><span>&nbsp;</span></div>"
                        + "<div class='toggle-button-wrapper-list' data-id='" + id + "'>"
                        + "<input type='checkbox' " + isDefaultCheck + "  id='toggle-button-1-" + id + "' class='chooseBtn'>"
                        + "<label for='toggle-button-1-" + id + "' class='button-label'>"
                        + "<span class='circle'></span>"
                        + "<span class='text on'>ON</span>"
                        + "<span class='text off'>OFF</span>"
                        + "</label>"
                        + "</div>"
                        + "<div><span>&nbsp;</span></div>"
                        + "</li>"
                        + "<li class='addr-info' data-id='" + id + "' data-phone='" + phone + "' data-username='" + userName + "' data-addr='" + addr + "' data-freight='" + freight + "' onclick='clickAddr(this)'>"
                        + "<div>"
                        + "<span>收货人:</span>"
                        + "<span>" + userName + "</span>"
                        + "</div>"
                        + "<div>"
                        + "<span>电话:</span>"
                        + "<span>" + phone + "</span>"
                        + "</div>"
                        + "<div>"
                        + "<span>详细地址:</span>"
                        + "<span>" + addr + "</span>"
                        + "</div>"
                        + "</li>"
                        + "<li class='delete-user-addr' onclick='deleteUserAddr(" + id + ")'>"
                        + "<div><span>&nbsp;</span></div>"
                        + "<div><span>删除</span></div>"
                        + "<div><span>&nbsp;</span></div>"
                        + "</li>"
                        + "</ul>";
                    $(".user-addr-list").append(html);
                }
            } else {
                alertMsg("网络异常,请稍后再试", 2);
            }
            checkDefaultList();//初始化绑定设置默认列表收货地址事件
        }
    });
}

//添加收货地址的绑定事件
function checkDefaultAdd() {
    $(".toggle-button-wrapper").on('click', function (e) {
        var checkBox = $(this).children("input");
        if (true == checkBox.prop("checked")) {
            checkBox.prop("checked", false);
        } else {
            checkBox.prop("checked", true);
        }
    });
}

//设置成为默认收货地址
function checkDefaultList() {
    $(".toggle-button-wrapper-list").on('click', function (e) {
        var checkBox = $(this).children("input");
        if (false == checkBox.prop("checked")) {
            //调用接口设置为默认收货地址
            var id = $(this).attr("data-id");
            $.ajax({
                type: "post",
                data: {id: id},
                async: false,
                cache: false,
                url: path + "/address/update/userAddressDefault",
                dataType: "json",
                success: function (data) {
                    var flag = data.flag;
                    if (flag === 1) {
                        alertMsg("设置成功", 2);
                        $("input[type='checkbox']").prop("checked", false);//设置其它为false
                        checkBox.prop("checked", true);//设置当前地址为true
                        return;
                    } else {
                        alertMsg("网络异常,请稍后再试", 2);
                    }
                }
            });
        } else {
            // checkBox.prop("checked", false);
            return;
        }
    });
}

//重置页面
function resetPage() {
    $("input[type='checkbox']").prop("checked", false);
    $("#addrUserName").val("");
    $("#addrUserPhone").val("");
    $("#inChoseAddrDetail").val("");
    var $target = $('#J_Address');
    $target.val("");
    $target.citySelect('init');
}

//删除地址
function deleteUserAddr(id) {

    //不允许删除当前选中的地址
    var userAddrId = $("#userAddrId").val();
    if (userAddrId == id) {
        alertMsg("不允许删除当前已选择的收货地址", 2);
        return;
    }

    layer.open({
        content: '您确定要删除吗？'
        , btn: ['确定', '取消']
        , yes: function (index) {
            $.ajax({
                type: "post",
                data: {id: id},
                async: false,
                cache: false,
                url: path + "/address/delete/userAddress",
                dataType: "json",
                success: function (data) {
                    var flag = data.flag;
                    if (flag === 1) {
                        alertMsg("操作成功", 2);
                        loadUserAddr();//加载用户收货地址列表
                        return;
                    } else {
                        alertMsg("网络异常,请稍后再试", 2);
                    }
                }
            });
            layer.close(index);
        }
    });
}

//设置选中的地址(全国地址)
function clickAddr(obj) {
    var id = $(obj).attr("data-id");
    var phone = $(obj).attr("data-phone");
    var userName = $(obj).attr("data-username");
    var addr = $(obj).attr("data-addr");
    var freight = $(obj).attr("data-freight");

    //设置值
    $("#userAddrId").val(id);
    $(".add-addr-detail-ul>li:first-child>span:last-child").html(userName);
    $("#userName").val(userName);
    $(".add-addr-detail-ul>li:nth-child(2)>span:last-child").html(phone);
    $("#userPhone").val(phone);
    $(".add-addr-detail-ul>li:nth-child(3)>span:last-child").html(addr);
    layer.closeAll();
    //重置运费
    $("#postPrice").val(freight);
    doPriceAll();

    //
    $(".add-addr-detail").show();
    $(".add-addr-word").hide();
}

//showPlatformAddr();//弹出平台地址
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
    $("#userNameAdd").val($("#userName").val());
    $("#userPhoneAdd").val($("#userPhone").val());
    $("#platformAddr").show();
}

function choseAddr(id, obj) {
    $(".get-addr-list-detail>li").css("border", "none");
    $(obj).css("border", "1px solid #00cc7d");

    //价格
    var postPrice = $("#" + id).children(0).attr("data-freight");
    $(".span-post").html(returnFloat(postPrice));
    $("#postPrice").val(postPrice);
    //选择平台收货的地址名称
    var inChoseAddr = $("#" + id).children(0).attr("data-addr");
    $("#inChoseAddr").val(inChoseAddr);
    $(".add-addr-detail-ul>li:last-child>span:last-child").html(inChoseAddr);
    //选择的平台标识
    $("#userAddrId").val(id);
    doPriceAll();
    //
    $(".add-addr-detail").show();
    $(".add-addr-word").hide();
}

//平台地址确认
function clickChoseAddr() {
    var userNameAdd = $("#userNameAdd").val();
    var userPhoneAdd = $("#userPhoneAdd").val();
    if (userNameAdd == '' || userNameAdd == null || userPhoneAdd == null || userPhoneAdd == '') {
        alertMsg("收货人姓名和电话不能为空", 2);
        return;
    }
    //设置收货人姓名和电话
    $("#userName").val(userNameAdd);
    $("#userPhone").val(userPhoneAdd);
    $(".add-addr-detail-ul>li:first-child>span:last-child").html(userNameAdd);
    $(".add-addr-detail-ul>li:nth-child(2)>span:last-child").html(userPhoneAdd);
    /*var userAddrId = $("#userAddrId").val();
    if (null == userAddrId || userAddrId == '' || userAddrId == 0) {
        alertMsg("请选择地址", 2);
        return;
    }*/
    layer.closeAll();
}

