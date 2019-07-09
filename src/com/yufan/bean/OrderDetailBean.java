package com.yufan.bean;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.stereotype.Controller;

import java.math.BigDecimal;
import java.util.List;

/**
 * 创建人: lirf
 * 创建时间:  2018-01-11 18:31
 * 功能介绍: 订单提交
 */
public class OrderDetailBean {

    @JSONField(name = "post_way")
    private Integer postWay;//配送方式 1.邮寄4.自取5商家配送

    @JSONField(name = "discounts_price")
    private BigDecimal discountsPrice;//优惠金额数

    @JSONField(name = "order_id")
    private Integer orderId;

    @JSONField(name = "order_price")
    private BigDecimal orderPrice;//订单总价

    @JSONField(name = "order_status_name")
    private String orderStatusName;//订单状态描述

    @JSONField(name = "order_no")
    private String orderNo;//订单号

    @JSONField(name = "real_price")
    private BigDecimal realPrice;//订单实际支付价格

    @JSONField(name = "advance_pay_time")
    private String advancePayTime;//预付款支付时间

    @JSONField(name = "order_time")
    private String orderTime;//下单时间

    @JSONField(name = "user_id")
    private Integer userId;

    @JSONField(name = "post_price")
    private BigDecimal postPrice;//邮费

    @JSONField(name = "needpay_price")
    private BigDecimal needpayPrice;//待付款

    @JSONField(name = "goods_count")
    private Integer goodsCount;//订单商品数量

    @JSONField(name = "advance_price")
    private BigDecimal advancePrice;//订单预付款

    @JSONField(name = "user_addr")
    private String userAddr;//收货地址

    @JSONField(name = "pay_time")
    private String payTime;//付款时间

    @JSONField(name = "order_status")
    private Integer orderStatus;//订单状态 0待付款1已付款2确认中3已失败4待发货5待收货6已完成7已取消8已删除9退款中10已退款

    @JSONField(name = "user_name")
    private String userName;//收货人

    @JSONField(name = "user_remark")
    private String userRemark;//用户备注

    @JSONField(name = "user_phone")
    private String userPhone;//手机号码

    @JSONField(name = "business_type")
    private String businessType;//业务类型

    @JSONField(name = "partners_name")
    private String partnersName;//商家名称

    @JSONField(name = "post_time")
    private String postTime;//发货时间

    @JSONField(name = "order_detail")
    private List<OrderDetailGoodsBean> orderDetail; //订单详情列表

    public Integer getPostWay() {
        return postWay;
    }

    public void setPostWay(Integer postWay) {
        this.postWay = postWay;
    }

    public BigDecimal getDiscountsPrice() {
        return discountsPrice;
    }

    public void setDiscountsPrice(BigDecimal discountsPrice) {
        this.discountsPrice = discountsPrice;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public BigDecimal getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(BigDecimal orderPrice) {
        this.orderPrice = orderPrice;
    }

    public String getOrderStatusName() {
        return orderStatusName;
    }

    public void setOrderStatusName(String orderStatusName) {
        this.orderStatusName = orderStatusName;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public BigDecimal getRealPrice() {
        return realPrice;
    }

    public void setRealPrice(BigDecimal realPrice) {
        this.realPrice = realPrice;
    }

    public String getAdvancePayTime() {
        return advancePayTime;
    }

    public void setAdvancePayTime(String advancePayTime) {
        this.advancePayTime = advancePayTime;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public BigDecimal getPostPrice() {
        return postPrice;
    }

    public void setPostPrice(BigDecimal postPrice) {
        this.postPrice = postPrice;
    }

    public BigDecimal getNeedpayPrice() {
        return needpayPrice;
    }

    public void setNeedpayPrice(BigDecimal needpayPrice) {
        this.needpayPrice = needpayPrice;
    }

    public Integer getGoodsCount() {
        return goodsCount;
    }

    public void setGoodsCount(Integer goodsCount) {
        this.goodsCount = goodsCount;
    }

    public BigDecimal getAdvancePrice() {
        return advancePrice;
    }

    public void setAdvancePrice(BigDecimal advancePrice) {
        this.advancePrice = advancePrice;
    }

    public String getUserAddr() {
        return userAddr;
    }

    public void setUserAddr(String userAddr) {
        this.userAddr = userAddr;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserRemark() {
        return userRemark;
    }

    public void setUserRemark(String userRemark) {
        this.userRemark = userRemark;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getBusinessType() {
        return businessType;
    }

    public void setBusinessType(String businessType) {
        this.businessType = businessType;
    }

    public String getPartnersName() {
        return partnersName;
    }

    public void setPartnersName(String partnersName) {
        this.partnersName = partnersName;
    }

    public String getPostTime() {
        return postTime;
    }

    public void setPostTime(String postTime) {
        this.postTime = postTime;
    }

    public List<OrderDetailGoodsBean> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(List<OrderDetailGoodsBean> orderDetail) {
        this.orderDetail = orderDetail;
    }
}
