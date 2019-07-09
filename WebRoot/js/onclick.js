/**
 * 网站所有点击跳转
 */
$('.homeBtn').on('click', function (e) {
    window.location.href = path + "/index/main";
});
$('#shopCardBtn').on('click', function (e) {
    window.location.href = path + "/car/shopCar";
});
$('.shopCardBtn-buyCount').on('click', function (e) {
    window.location.href = path + "/car/shopCar";
});

/**
 * 搜索页面
 */

$('.return-back').on('click', function (e) {
    history.go(-1);
});

function alertMsgCommon(msg, time) {
    //提示
    layer.open({
        content: msg
        , skin: 'msg'
        , time: time //2秒后自动关闭
    });
}
