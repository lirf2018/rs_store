package com.yufan.bean;

import com.alibaba.fastjson.annotation.JSONField;

import java.math.BigDecimal;

/**
 * 创建人: lirf
 * 创建时间:  2018-01-12 10:24
 * 功能介绍:
 */
public class OrderDetailGoodsBean {

    @JSONField(name = "is_time_goods")
    private Integer isTimeGoods;//是否是抢购商品0不是1是

    @JSONField(name = "get_addr_id")
    private Integer getAddrId;

    @JSONField(name = "goods_name")
    private String goodsName;//格瓦斯饮料秋林格瓦斯面包发酵饮品哈尔滨特产350ml*12瓶官方正品",

    @JSONField(name = "partners_id")
    private Integer partnersId;

    @JSONField(name = "goods_img")
    private String goodsImg;

    @JSONField(name = "back_addr_id")
    private Integer backAddrId;

    @JSONField(name = "get_goods_date")
    private String getGoodsDate;//自取类取货时间

    @JSONField(name = "time_price")
    private BigDecimal timePrice;//抢购价格

    @JSONField(name = "goods_count")
    private Integer goodsCount;//商品数量

    @JSONField(name = "is_ticket")
    private Integer isTicket;//是否是卡券 0不是卡券1是卡券商品

    @JSONField(name = "shop_id")
    private Integer shopId;

    @JSONField(name = "detail_id")
    private Integer detailId;

    @JSONField(name = "get_time")
    private String getTime;//租赁取货时间

    @JSONField(name = "status")
    private Integer status;//详情状态

    @JSONField(name = "shop_name")
    private String shopName;//店铺名称

    @JSONField(name = "goods_id")
    private String goodsId;//商品标识

    @JSONField(name = "partners_name")
    private String partnersName;//"融水e购",

    @JSONField(name = "detail_status")
    private Integer detailStatus;//详情状态

    @JSONField(name = "back_time")
    private String backTime;//租赁归还时间

    @JSONField(name = "goods_spec")
    private String goodsSpec;

    @JSONField(name = "goods_spec_name")
    private String goodsSpecName;

    @JSONField(name = "goods_spec_name_str")
    private String goodsSpecNameStr;

    @JSONField(name = "cart_id")
    private Integer cartId;

    @JSONField(name = "sale_price")
    private BigDecimal salePrice;//销售价

    @JSONField(name = "is_single")
    private Integer isSingle;

    public Integer getIsTimeGoods() {
        return isTimeGoods;
    }

    public void setIsTimeGoods(Integer isTimeGoods) {
        this.isTimeGoods = isTimeGoods;
    }

    public Integer getGetAddrId() {
        return getAddrId;
    }

    public void setGetAddrId(Integer getAddrId) {
        this.getAddrId = getAddrId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public Integer getPartnersId() {
        return partnersId;
    }

    public void setPartnersId(Integer partnersId) {
        this.partnersId = partnersId;
    }

    public String getGoodsImg() {
        return goodsImg;
    }

    public void setGoodsImg(String goodsImg) {
        this.goodsImg = goodsImg;
    }

    public Integer getBackAddrId() {
        return backAddrId;
    }

    public void setBackAddrId(Integer backAddrId) {
        this.backAddrId = backAddrId;
    }

    public String getGetGoodsDate() {
        return getGoodsDate;
    }

    public void setGetGoodsDate(String getGoodsDate) {
        this.getGoodsDate = getGoodsDate;
    }

    public BigDecimal getTimePrice() {
        return timePrice;
    }

    public void setTimePrice(BigDecimal timePrice) {
        this.timePrice = timePrice;
    }

    public Integer getGoodsCount() {
        return goodsCount;
    }

    public void setGoodsCount(Integer goodsCount) {
        this.goodsCount = goodsCount;
    }

    public Integer getIsTicket() {
        return isTicket;
    }

    public void setIsTicket(Integer isTicket) {
        this.isTicket = isTicket;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getDetailId() {
        return detailId;
    }

    public void setDetailId(Integer detailId) {
        this.detailId = detailId;
    }

    public String getGetTime() {
        return getTime;
    }

    public void setGetTime(String getTime) {
        this.getTime = getTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getPartnersName() {
        return partnersName;
    }

    public void setPartnersName(String partnersName) {
        this.partnersName = partnersName;
    }

    public Integer getDetailStatus() {
        return detailStatus;
    }

    public void setDetailStatus(Integer detailStatus) {
        this.detailStatus = detailStatus;
    }

    public String getBackTime() {
        return backTime;
    }

    public void setBackTime(String backTime) {
        this.backTime = backTime;
    }

    public String getGoodsSpec() {
        return goodsSpec;
    }

    public void setGoodsSpec(String goodsSpec) {
        this.goodsSpec = goodsSpec;
    }

    public String getGoodsSpecName() {
        return goodsSpecName;
    }

    public void setGoodsSpecName(String goodsSpecName) {
        this.goodsSpecName = goodsSpecName;
    }

    public String getGoodsSpecNameStr() {
        return goodsSpecNameStr;
    }

    public void setGoodsSpecNameStr(String goodsSpecNameStr) {
        this.goodsSpecNameStr = goodsSpecNameStr;
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }

    public Integer getIsSingle() {
        return isSingle;
    }

    public void setIsSingle(Integer isSingle) {
        this.isSingle = isSingle;
    }
}
