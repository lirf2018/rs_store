<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>增加收货地址</title>
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
    </script>
</head>

<body>
<form id="data-form" action="" method="post">
    <input type="hidden" id="inChoseAddr" name="inChoseAddr" value=""/><!-- 全国地址所选的城市或者选择的平台地址名称-->
    <input type="hidden" id="inChoseAddrCode" name="inChoseAddrCode" value=""/><!-- 全国地址编码-->
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
        <span class="title-name">增加收货地址</span>
        <div id="homeBtn" class="homeBtn"></div>
    </header>
    <div class="clear-header"></div>
    <div style="position:fixed; top25px:0; left:0; width: 100%; height:100%; padding:0px 0; border:none;">
        <div class="add-edit-box">
            <span class="shouh">
             <dl>
                 <dd>收货人：<input id="addrUserName" name="addrUserName" type="text" value=""/></dd>
                 <dd>电   话： <input id="addrUserPhone" name="addrUserPhone" type="text" value=""/></dd>
                 <div class="clearx" style="height:10px"></div>
             </dl>
            </span>
            <section class="g-flexview">
                <section class="g-scrollview">
                    <div class="m-cell">
                        <div class="cell-item">
                            <div class="cell-left">所在城市：</div>
                            <div class="cell-right cell-arrow">
                                <input type="text" class="cell-input" readonly="" id="J_Address" value=""
                                       placeholder="请选择收货地址">
                            </div>
                        </div>
                    </div>
                </section>
                <div class="input-detail-addr">
                    <span>详情地址:</span>
                    <span><input id="inChoseAddrDetail" value="" type="text" placeholder=""></span>
                </div>
            </section>
            <div class="default-addr">
                <span>设置为默认收货地址</span>
                <span>
                 <div class="toggle-button-wrapper">
                     <input type="checkbox" id="toggle-button-1" class="chooseBtn">
                     <label for="toggle-button-1" class="button-label">
                         <span class="circle"></span>
                         <span class="text on">ON</span>
                         <span class="text off">OFF</span>
                     </label>
                 </div>
             </span>
            </div>
            <div class="submit-add"><span>添加收货地址</span></div>
            <div class="user-addr-list-titel">
                <ul class="user-addr-list-ul">
                    <li><span>设置默认</span></li>
                    <li><span>地址详情</span></li>
                    <li><span>操作</span></li>
                </ul>
            </div>
        </div>
        <div class="add-list-box" style="position: relative;overflow-y:scroll;">
            <div class="user-addr-list"></div>
        </div>
    </div>
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
</form>
<!--插件-->
<script type="text/javascript" src="${path}/js/onclick.js"></script>
<script type="text/javascript" src="${path}/js/layer.js"></script>
<script src="${path}/js/jquery-1.10.1.min.js"></script>
<script src="${path}/js/ydui.citys.my.min.js"></script>
<script src="${path}/js/ydui.my.js"></script>
</body>
<script>
    var $target = $('#J_Address');
    $target.citySelect();

    $target.on('click', function (event) {
        event.stopPropagation();
        $target.citySelect('open');
    });

    $target.on('done.ydui.cityselect', function (ret) {
        // console.log(ret)
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

    loadUserAddr();

    function loadUserAddr() {
        $.ajax({
            type: "post",
            data: {},
            async: false,
            cache: false,
            url: "${path}/address/query/userAddress",
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
                            + "<li class='addr-info' data-id='" + id + "' data-phone='" + phone + "' data-username='" + userName + "' data-addr='" + addr + "' data-freight='" + freight + "' >"
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
                    alertMsgCommon("网络异常,请稍后再试", 2);
                }
                // checkDefaultList();//初始化绑定设置默认列表收货地址事件
            }
        });
    }

    var addeditbox = $('.add-edit-box').height();
    $('.add-list-box').css({
        height: $('body').height() - addeditbox - 50,
        overflow: 'auto'
    });

    //删除地址
    function deleteUserAddr(id) {
        layer.open({
            content: '您确定要删除吗？'
            , btn: ['确定', '取消']
            , yes: function (index) {
                $.ajax({
                    type: "post",
                    data: {id: id},
                    async: false,
                    cache: false,
                    url: "${path}/address/delete/userAddress",
                    dataType: "json",
                    success: function (data) {
                        var flag = data.flag;
                        if (flag === 1) {
                            alertMsgCommon("操作成功", 2);
                            loadUserAddr();//加载用户收货地址列表
                            return;
                        } else {
                            alertMsgCommon("网络异常,请稍后再试", 2);
                        }
                    }
                });
                layer.close(index);
            }
        });
    }

    //设置成为默认收货地址
    $(".toggle-button-wrapper-list").on('click', function (e) {
        var checkBox = $(this).children("input");
        console.log(checkBox.prop("checked"));

        if (false == checkBox.prop("checked")) {
            //调用接口设置为默认收货地址
            var id = $(this).attr("data-id");
            $.ajax({
                type: "post",
                data: {id: id},
                async: false,
                cache: false,
                url: "${path}/address/update/userAddressDefault",
                dataType: "json",
                success: function (data) {
                    var flag = data.flag;
                    $("input[type='checkbox']").prop("checked", false);//设置其它为false
                    checkBox.prop("checked", true);//设置当前地址为true
                    if (flag === 1) {
                        alertMsgCommon("设置成功", 2);
                        return;
                    } else {
                        alertMsgCommon("网络异常,请稍后再试", 2);
                    }
                }
            });
        } else {
            // checkBox.prop("checked", false);
            return;
        }
    });
    $(".toggle-button-wrapper").on('click', function (e) {
        var checkBox = $(this).children("input");
        if (false == checkBox.prop("checked")) {
            checkBox.prop("checked", true);//设置当前地址为true
        } else {
            checkBox.prop("checked", false);
        }
    });

    $(".submit-add").on('click', function (e) {

        var addrUserName = $("#addrUserName").val();
        var addrUserPhone = $("#addrUserPhone").val();
        var inChoseAddrCode = $("#inChoseAddrCode").val() + "";//地址编码
        var inChoseAddr = $("#inChoseAddr").val() + "";//地址名称
        var inChoseAddrDetail = $("#inChoseAddrDetail").val() + "";

        if (addrUserName.trim() == '') {
            alertMsgCommon("收货人姓名不能为空", 2);
            return;
        }

        if (addrUserPhone.trim() == '') {
            alertMsgCommon("收货人电话不能为空", 2);
            return;
        }

        if (inChoseAddrCode == '') {
            alertMsgCommon("所在城市不能为空", 2);
            return;
        }
        if (inChoseAddr == '') {
            alertMsgCommon("所在城市不能为空", 2);
            return;
        }
        if (inChoseAddrDetail.trim() == '') {
            alertMsgCommon("详细地址不能为空", 2);
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
            url: "${path}/address/add/userAddress",
            dataType: "json",
            success: function (data) {
                var flag = data.flag;
                if (flag === 1) {
                    alertMsgCommon("增加成功", 2);
                    resetPage()
                    loadUserAddr();//加载用户收货地址列表
                    // location.reload();
                } else {
                    alertMsgCommon("网络异常,请稍后再试", 2);
                }
            }
        });
    });

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
</script>
</html>
