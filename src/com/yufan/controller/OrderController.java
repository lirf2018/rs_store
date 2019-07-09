package com.yufan.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yufan.bean.OrderDetailGoodsBean;
import com.yufan.util.*;
import com.yufan.vo.req.UserInfoVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 创建人: lirf
 * 创建时间:  2018/11/15 15:56
 * 功能介绍: 用户订单
 */
@Controller
@RequestMapping("/order/")
public class OrderController {

    private Logger LOG = Logger.getLogger(OrderController.class);
    //============================================用户下单====================================================================

    /**
     * 跳转到提交订单页面
     *
     * @return
     */
    @RequestMapping("commitPage")
    public String toOrderConfirmPage(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getSession().setAttribute("orderConfirmMark", String.valueOf(System.currentTimeMillis()));
            if (null == request.getParameter("advancePrice")) {
                response.sendRedirect(request.getContextPath() + RsConstants.USER_CENTER_URL);
                return "";
            }
            //调用接口查询数据
            String[] goodsId = request.getParameterValues("goodsId");//商品标识
            String[] goodsImg = request.getParameterValues("goodsImg");//商品图片
            String[] goodsName = request.getParameterValues("goodsName");//商品名称
            String[] salePrices = request.getParameterValues("salePrice");//商品现价（销售价格）
            String[] goodsCountArray = request.getParameterValues("goodsCount");//商品数量
            String[] isSingle = request.getParameterValues("isSingle");//是否单品
            String[] goodsSpaceCode = request.getParameterValues("goodsSpaceCode");//商品规格编码
            String[] goodsSpaceCodeName = request.getParameterValues("goodsSpaceCodeName");//商品规格名称
            String[] goodsSpaceCodeNameStr = request.getParameterValues("goodsSpaceCodeNameStr");//商品规格名称str
            String[] partnersId = request.getParameterValues("partnersId");//
            String[] partnersName = request.getParameterValues("partnersName");//商家名称
            BigDecimal advancePrice = new BigDecimal(request.getParameter("advancePrice"));//订单预付款
            String[] goodsAdvancePrice = request.getParameterValues("goodsAdvancePrice");//商品预付款
            String[] goodsIsPayOnline = request.getParameterValues("isPayOnline");//是否线上支付 0不用线上支付 1只能线上支付
            String depositPrice = request.getParameter("depositPrice") == null ? "0" : request.getParameter("depositPrice");//押金(有押金的商品独立一个订单)======================
            String timePrice = request.getParameter("timePrice") == null ? "0" : request.getParameter("timePrice");//抢购价(抢购商品独立一个订单)======================
            String timeGoodsId = request.getParameter("timeGoodsId") == null ? "0" : request.getParameter("timeGoodsId");//抢购标识(来自于商品直接下单)

            //商品取货方式(系统设置的1邮寄2平台地址)
            int addrType = Integer.parseInt(request.getParameter("addrType"));
            request.setAttribute("sysAddrType", addrType);
            //商品取货方式
            String[] getWays = request.getParameterValues("getWay");
            int getWay = Integer.parseInt(getWays[0]);
            request.setAttribute("getWay", getWay);

            String[] cartId = request.getParameterValues("cartId");//(来自于购物车)购物车标识
            String selectCardIds = request.getParameter("selectCardIds");//选中的购物车商品
            Map<String, String> isSelectCardids = new HashMap<String, String>();
            if (StringUtils.isNotEmpty(selectCardIds)) {
                String[] selectCardIdsArray = selectCardIds.split(",");
                for (int i = 0; i < selectCardIdsArray.length; i++) {
                    if (StringUtils.isNotEmpty(selectCardIdsArray[i])) {
                        isSelectCardids.put(selectCardIdsArray[i], selectCardIdsArray[i]);//选中的购物车商品
                    }
                }
            }
            BigDecimal depositPriceAll = new BigDecimal(0);//押金总额
            BigDecimal goodsAdvancePriceAll = new BigDecimal(0);//商品预付款总额(支持线下付款类商品)
            BigDecimal goodsPayOnlinePriceAll = new BigDecimal(0);//商品只能在线付款总额
            if (!StringUtils.isEmpty(depositPrice)) {
                depositPriceAll = new BigDecimal(depositPrice);
            }

            Map<String, String> selectPartners = new HashMap<String, String>();//选中商品对应的商家
            int goodsCount = 0;//商品总数
            BigDecimal goodsPriceAll = new BigDecimal(0);//商品总价格
            //处理商品列表
            List<OrderDetailGoodsBean> orderDetailGoodsBeanList = new ArrayList<OrderDetailGoodsBean>();
            for (int i = 0; i < goodsId.length; i++) {
                OrderDetailGoodsBean orderDetailGoodsBean = new OrderDetailGoodsBean();
                orderDetailGoodsBean.setGoodsId(goodsId[i]);
                orderDetailGoodsBean.setGoodsImg(goodsImg[i]);
                orderDetailGoodsBean.setGoodsName(goodsName[i]);
                orderDetailGoodsBean.setCartId(Integer.parseInt(cartId[i]));
                if (Integer.parseInt(cartId[i]) > 0) {
                    if (isSelectCardids.get(cartId[i]) == null) {
                        continue;
                    }
                }
                selectPartners.put(partnersId[i], partnersId[i]);
                BigDecimal salePrice = new BigDecimal(salePrices[i]);
                BigDecimal buyCount = new BigDecimal(goodsCountArray[i]);//购买数量
                goodsCount = goodsCount + buyCount.intValue();
                BigDecimal goodsPrice = salePrice.multiply(buyCount);

                goodsPriceAll = goodsPriceAll.add(goodsPrice);//计算商品总额
                depositPriceAll = depositPriceAll.multiply(buyCount);//计算商品总押金

                int isPayOnline = Integer.parseInt(goodsIsPayOnline[i]);
                if (isPayOnline == 0) {//是否线上支付 0不用线上支付 1只能线上支付
                    BigDecimal gap = new BigDecimal(goodsAdvancePrice[i]);//商品预付款
                    BigDecimal goodsAdvancePrice_ = gap.multiply(buyCount);
                    goodsAdvancePriceAll = goodsAdvancePriceAll.add(goodsAdvancePrice_);
                } else {
                    goodsPayOnlinePriceAll = goodsPayOnlinePriceAll.add(goodsPrice);
                }
                //

                orderDetailGoodsBean.setGoodsCount(buyCount.intValue());
                orderDetailGoodsBean.setSalePrice(salePrice);//销售价格
                orderDetailGoodsBean.setPartnersId(Integer.parseInt(partnersId[i]));
                orderDetailGoodsBean.setPartnersName(partnersName[i]);
                orderDetailGoodsBean.setIsSingle(Integer.parseInt(isSingle[i]));
                int isSingle_ = Integer.parseInt(isSingle[i]);
                if (isSingle.length > 0 && isSingle_ == 0) {
                    orderDetailGoodsBean.setGoodsSpec(goodsSpaceCode[i]);
                    orderDetailGoodsBean.setGoodsSpecName(goodsSpaceCodeName[i]);
                    orderDetailGoodsBean.setGoodsSpecNameStr(goodsSpaceCodeNameStr[i]);
                }
                orderDetailGoodsBeanList.add(orderDetailGoodsBean);
            }

            //根据商家遍历商品列表
            List<Map<String, Object>> listPartners = new ArrayList<Map<String, Object>>();
            Map<String, String> partnerMap = new HashMap<String, String>();
            for (int i = 0; i < partnersId.length; i++) {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("partners_id", partnersId[i]);
                map.put("partners_name", partnersName[i]);
                if (null != selectPartners.get(partnersId[i]) && partnerMap.get(partnersId[i]) == null) {
                    listPartners.add(map);
                    partnerMap.put(partnersId[i], partnersId[i]);
                }
            }

            //查询地址
            Object user = request.getSession().getAttribute("userInfoVo");
            if (null == user) {
                return "400";
            }
            UserInfoVo userInfoVo = (UserInfoVo) user;
            request.setAttribute("showAddAddr", "display: none;");//展现地址
            request.setAttribute("addAddr", "display: block;");//添加地址
            request.setAttribute("freight", "0.00");
            if (addrType == 1) {
                int userId = userInfoVo.getUserId();
                JSONObject obj = new JSONObject();
                obj.put("user_id", userId);
                ResultBean resultBean = CommonRequst.executeNew(obj, "query_user_addr_list");
                if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                    //获取默认收货地址
                    JSONArray arrayAddr = resultBean.getData().getJSONArray("list_user_addr");
                    if (arrayAddr.size() > 0) {
                        JSONObject addrObj = arrayAddr.getJSONObject(0);
                        int userAddrId = addrObj.getIntValue("id");
                        String userName = addrObj.getString("user_name");
                        String userPhone = addrObj.getString("user_phone");
                        String addr = addrObj.getString("addr_name");
                        String freight = addrObj.getString("freight");

                        request.setAttribute("userAddrId", userAddrId);
                        request.setAttribute("userName", userName);
                        request.setAttribute("userPhone", userPhone);
                        request.setAttribute("addr", addr);
                        request.setAttribute("freight", freight);
                        request.setAttribute("arrayAddr", arrayAddr);
                        request.setAttribute("showAddAddr", "display:flex ;");//展现地址
                        request.setAttribute("addAddr", "display: none;");//添加地址
                    }
                }
            } else if (addrType == 2) {
                //查询平台地址
                JSONObject obj = new JSONObject();
                obj.put("addr_type", getWay);//商品取货方式
                ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_sendaddr_list");
                if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                    JSONArray array = JSONArray.parseArray(resultBean.getData().getString("list_addr"));
                    request.setAttribute("addrList", array);
                }

                JSONArray getDateArray = resultBean.getData().getJSONArray("list_get_date");
                request.setAttribute("getDateArray", getDateArray);//
            }

            request.setAttribute("goodsPriceAll", goodsPriceAll);//商品总价
            request.setAttribute("advancePrice", advancePrice);//系统后台配置的订单预付款
            request.setAttribute("depositPriceAll", depositPriceAll.setScale(2));//押金总数
            request.setAttribute("goodsAdvancePriceAll", goodsAdvancePriceAll);//商品预付款总额
            request.setAttribute("goodsPayOnlinePriceAll", goodsPayOnlinePriceAll);//商品只能线上支付款总额
            request.setAttribute("goodsCounts", goodsCount);//

            request.setAttribute("listPartners", listPartners);
            request.setAttribute("timeGoodsId", timeGoodsId);
            request.setAttribute("timePrice", timePrice);
            request.setAttribute("orderDetailGoodsBeanList", orderDetailGoodsBeanList);
            request.setAttribute("phone", userInfoVo.getUserMobile());
            //支付方式（根据入口环境得到支付方式） 预付支付方式 支付方式 0现金付款1微信2支付宝3账户余额
            JSONArray arrayPay = new JSONArray();
//            arrayPay.add(3);
//            arrayPay.add(2);
//            arrayPay.add(1);
            arrayPay.add(0);
            request.setAttribute("payWaySize", arrayPay.size());
            request.setAttribute("payTypeArray", arrayPay);

            return "order-confirm";//全国地址
        } catch (Exception e) {
            LOG.info("---------->", e);
        }
        return "500";
    }


    /**
     * 检验订单(订单提交页面,创建订单前)
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("checkOrderData")
    public void checkOrder2(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter writer = null;
        JSONObject out = new JSONObject();
        out.put("flag", "false");
        out.put("msg", "网络异常,请稍后再试");
        try {
            writer = response.getWriter();
            Object orderConfirmMark = request.getSession().getAttribute("orderConfirmMark");
            if (null == orderConfirmMark) {
                out.put("msg", "不能重复提交订单");
                writer.print(out);
                writer.flush();
                writer.close();
                return;
            }
            //获取参数
            String advancePrice = request.getParameter("advancePrice");//预付款
            String discountsPrice = request.getParameter("discountsPrice");//优惠金额
            String discountsId = request.getParameter("discountsId");//优惠金额对应的卡券标识
            String goodsCounts = request.getParameter("goodsCounts");//商品总数
            String needpayPrice = request.getParameter("needpayPrice");//待付款
            String orderPrice = request.getParameter("orderPrice");//订单付款价格
            String postPrice = request.getParameter("postPrice");//邮费
            String realPrice = request.getParameter("realPrice");//订单实际价格
            String advancePayWay = request.getParameter("advancePayWay");//预付支付方式
            String userRemark = request.getParameter("userRemark");//用户留言
            String timeGoodsId = request.getParameter("timeGoodsId");
            String depositPriceAll = request.getParameter("depositPriceAll");
            String userAddrId = request.getParameter("userAddrId");

            String userName = request.getParameter("userName");
            String userPhone = request.getParameter("userPhone");

            String getDate = request.getParameter("getDate");//取货日期
            if (StringUtils.isNotEmpty(getDate)) {
                String nowDate = DatetimeUtil.getNow("yyyy-MM-dd");
                if (DatetimeUtil.compareDate(getDate, nowDate, "yyyy-MM-dd") < 1) {
                    LOG.info("--->日期超时");
                    out.put("msg", "不能选择当天日期");
                    writer.print(out);
                    writer.flush();
                    writer.close();
                    return;
                }
            }

            Object user = request.getSession().getAttribute("userInfoVo");
            if (null == user) {
                LOG.info("--->未登录");
                writer.print(out);
                writer.flush();
                writer.close();
                return;
            }
            if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(userPhone)) {
                LOG.info("--->订单信息有误");
                writer.print(out);
                writer.flush();
                writer.close();
                return;
            }

            UserInfoVo userInfoVo = (UserInfoVo) user;
            int userId = userInfoVo.getUserId();

            //处理商品数据
            List<Map<String, Object>> orderDetaiList = new ArrayList<Map<String, Object>>();
            String goodsIdParam = request.getParameter("goodsId");
            String[] goodsId = goodsIdParam.split(",");

            String cartIdParam = request.getParameter("cartId");
            String[] cartId = cartIdParam.split(",");

            String goodsCountParam = request.getParameter("goodsCount");
            String[] goodsCount = goodsCountParam.split(",");

            String goodsPpecParam = request.getParameter("goodsPpec");
            String[] goodsPpec = goodsPpecParam.split(",");

            String goodsSpecNameParam = request.getParameter("goodsSpecName");
            String[] goodsSpecName = goodsSpecNameParam.split(",");

            String goodsSpecNameStrParam = request.getParameter("goodsSpecNameStr");
            String[] goodsSpecNameStr = goodsSpecNameStrParam.split(",");

            String isSingleParam = request.getParameter("isSingle");
            String[] isSingle = isSingleParam.split(",");

            for (int i = 0; i < goodsId.length; i++) {
                if (StringUtils.isEmpty(goodsCount[i])) {
                    continue;
                }
                Map<String, Object> goodsInfo = new HashMap<String, Object>();
                goodsInfo.put("goods_count", goodsCount[i]);//购买数量
                goodsInfo.put("goods_id", goodsId[i]);
                goodsInfo.put("cart_id", cartId[i]);
                goodsInfo.put("time_goods_id", timeGoodsId);//抢购商品时必须
                goodsInfo.put("deposit_price", depositPriceAll);//总押金必须
                if (Integer.parseInt(isSingle[i]) == 0) {
                    goodsInfo.put("goods_spec", goodsPpec[i]);//规格编码
                    goodsInfo.put("goods_spec_name", goodsSpecName[i]);//规格名称
                    goodsInfo.put("goods_spec_name_str", goodsSpecNameStr[i]);//规格名称
                }
                //处理详情属性
                orderDetaiList.add(goodsInfo);
            }

            JSONObject obj = new JSONObject();
            //调用接口调用接口创建订单
            obj.put("advance_price", advancePrice);//预付款(必须)
            obj.put("discounts_price", discountsPrice);//优惠金额(必须)
            obj.put("discounts_id", discountsId);//优惠金额标识(必须)
            obj.put("goods_count", goodsCounts);//商品数量(必须)
            obj.put("needpay_price", needpayPrice);//待付款
            obj.put("order_price", orderPrice);//订单总价
            obj.put("post_price", postPrice);//邮费
            obj.put("real_price", realPrice);//订单实付款
            obj.put("user_id", userId);
            obj.put("user_remark", userRemark);//用户备注
            obj.put("advance_pay_way", advancePayWay);//用户备注
            obj.put("deposit_price_all", depositPriceAll);//总押金必须
            obj.put("order_detail_list", orderDetaiList);
            obj.put("user_addr_id", userAddrId);//收货地址
            obj.put("user_name", userName);//
            obj.put("user_phone", userPhone);//

            String base64OrderDataStr = Base64Coder.encodeString(obj.toJSONString());
            JSONObject baseData = new JSONObject();
            baseData.put("base64_order_data", base64OrderDataStr);


            ResultBean resultBean = CommonRequst.executeNew(baseData, "check_order_v2");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", "ok");
                out.put("msg", "");
            } else {
                out.put("msg", resultBean.getRespDesc());
            }
            writer.print(out);
            writer.flush();
            writer.close();
        } catch (Exception e) {
            LOG.info("-------> 检验订单异常", e);
            writer.print(out);
            writer.flush();
            writer.close();
        }
    }


    /**
     * 创建订单
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("createOrder")
    public String createOrder(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getSession().removeAttribute("orderConfirmMark");
            //获取参数
            String advancePrice = request.getParameter("advancePrice");//预付款
            String discountsPrice = request.getParameter("discountsPrice");//优惠金额
            String discountsId = request.getParameter("discountsId");//优惠金额对应的卡券
            String goodsCounts = request.getParameter("goodsCounts");//商品总数
            String needpayPrice = request.getParameter("needpayPrice");//待付款
            String orderPrice = request.getParameter("orderPrice");//订单付款价格
            String postPrice = request.getParameter("postPrice");//邮费
            String realPrice = request.getParameter("realPrice");//订单实际价格
            String userAddrId = request.getParameter("userAddrId");
            String advancePayWay = request.getParameter("advancePayWay");//预付支付方式 0现金付款1微信2支付宝3其他4无付款
            if (!("0".equals(advancePayWay) || "1".equals(advancePayWay) || "2".equals(advancePayWay) || "3".equals(advancePayWay))) {
                advancePayWay = "4";
            }

            String userRemark = request.getParameter("userRemark");//用户留言
            String timeGoodsId = request.getParameter("timeGoodsId");
            String depositPriceAll = request.getParameter("depositPriceAll");

            String userName = request.getParameter("userName");
            String userPhone = request.getParameter("userPhone");

            String getDate = request.getParameter("getDate");

            if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(userPhone)) {
                LOG.info("--->订单信息有误userName或userPhone为空");
                return "500";
            }

            Object user = request.getSession().getAttribute("userInfoVo");
            if (null == user) {
                return "500";
            }
            UserInfoVo userInfoVo = (UserInfoVo) user;
            int userId = userInfoVo.getUserId();

            //处理商品数据
            List<Map<String, Object>> orderDetaiList = new ArrayList<Map<String, Object>>();
            String[] goodsId = request.getParameterValues("goodsId");
            String[] cartId = request.getParameterValues("cartId");
            String[] goodsCount = request.getParameterValues("goodsCount");
            String[] goodsPpec = request.getParameterValues("goodsPpec");
            String[] goodsSpecName = request.getParameterValues("goodsSpecName");
            String[] goodsSpecNameStr = request.getParameterValues("goodsSpecNameStr");

            for (int i = 0; i < goodsId.length; i++) {
                Map<String, Object> goodsInfo = new HashMap<String, Object>();
                goodsInfo.put("goods_count", goodsCount[i]);//购买数量
                goodsInfo.put("goods_id", goodsId[i]);
                goodsInfo.put("cart_id", cartId[i]);
                goodsInfo.put("time_goods_id", timeGoodsId);//抢购商品时必须
                goodsInfo.put("goods_spec", goodsPpec[i]);//规格编码
                goodsInfo.put("goods_spec_name", goodsSpecName[i]);//规格名称
                goodsInfo.put("goods_spec_name_str", goodsSpecNameStr[i]);//规格名称
                goodsInfo.put("get_time", getDate);
                //处理详情属性
                orderDetaiList.add(goodsInfo);
            }

            JSONObject obj = new JSONObject();
            //调用接口调用接口创建订单
            obj.put("advance_price", advancePrice);//预付款(必须)
            obj.put("discounts_price", discountsPrice);//优惠金额(必须)
            obj.put("discounts_id", discountsId);//优惠金额标识(必须)
            obj.put("goods_count", goodsCounts);//商品数量(必须)
            obj.put("needpay_price", needpayPrice);//待付款
            obj.put("order_price", orderPrice);//订单总价
            obj.put("post_price", postPrice);//邮费
            obj.put("real_price", realPrice);//订单实付款
            obj.put("user_addr_id", userAddrId);//收货地址
            obj.put("user_id", userId);
            obj.put("user_remark", userRemark);//用户备注
            obj.put("advance_pay_way", advancePayWay);//预付款方式
            obj.put("deposit_price_all", depositPriceAll);//总押金必须

            obj.put("user_name", userName);//
            obj.put("user_phone", userPhone);//

            obj.put("order_detail_list", orderDetaiList);

            String base64OrderDataStr = Base64Coder.encodeString(obj.toJSONString());
            JSONObject baseData = new JSONObject();
            baseData.put("base64_order_data", base64OrderDataStr);

            ResultBean resultBean = CommonRequst.executeNew(baseData, "create_order_v2");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                String orderNum = resultBean.getData().getString("order_no");
                request.setAttribute("orderNum", orderNum);
            }
            //跳转到付款页面
            //跳转到成功页面
            return "order-result";
        } catch (Exception e) {
            LOG.info("------->异常", e);
        }
        return "500";
    }

    //============================================订单操作====================================================================

    /**
     * 查询订单列表
     */
    @RequestMapping("query/orderList")
    public void queryOrderList(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "网络异常,稍后重试");
            request.setCharacterEncoding("utf-8");
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            response.setCharacterEncoding("utf-8");
            printWriter = response.getWriter();

            int current = 1;
            if (StringUtils.isNotEmpty(request.getParameter("current"))) {
                current = Integer.parseInt(request.getParameter("current"));
            }
            int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));//

            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = null;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
            }

            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            obj.put("current", current);//
            obj.put("status", orderStatus);//
            ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_order_list");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "查询成功");
                JSONObject data = resultBean.getData();
                out.put("orderList", data.getJSONArray("order_list"));
                out.put("hasNext", data.getBooleanValue("has_next"));
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        } catch (Exception e) {
            LOG.info("----->查询订单列表异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

    /**
     * 查询订单详情
     *
     * @return
     */
    @RequestMapping("query/orderDetail")
    public String toOrderDetailPage(HttpServletRequest request, HttpServletResponse response) {
        try {
            Object user = request.getSession().getAttribute("userInfoVo");
            UserInfoVo userInfoVo = (UserInfoVo) user;
            int userId = userInfoVo.getUserId();
            String orderNo = request.getParameter("orderNo");
            String failMark = request.getParameter("failMark");
            request.setAttribute("failMark", failMark);
            //调用接口调用接口
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            obj.put("order_no", orderNo);//
            ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_order_detail");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                request.setAttribute("data", resultBean.getData());
                JSONArray array = JSONArray.parseArray(resultBean.getData().getString("list_addr"));
                request.setAttribute("addrList", array);
                return "order-detail";
            }

        } catch (Exception e) {
            LOG.info("------------>", e);
        }
        return "500";
    }

    /**
     * 其它订单列表
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("query/otherOrderList")
    public String toFailOrderListPage(HttpServletRequest request, HttpServletResponse response) {
        try {
            //String 0待付款1已付款2确认中3已失败4待发货5待收货6已完成7已取消8已删除9退款中10已退款
            Map<Integer, String> statusName = new HashMap<Integer, String>();
            statusName.put(-1, "全部");
            statusName.put(0, "待付款");
            statusName.put(1, "已付款");
            statusName.put(2, "确认中");
            statusName.put(3, "已失败");
            statusName.put(4, "待发货");
            statusName.put(5, "待收货");
            statusName.put(6, "已完成");
            statusName.put(7, "已取消");
            statusName.put(8, "已删除");
            statusName.put(9, "退款中");
            statusName.put(10, "已退款");
            statusName.put(11, "处理中");
            int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));//

            Object user = request.getSession().getAttribute("userInfoVo");
            if (null == user) {
                return "500";
            }
            UserInfoVo userInfoVo = (UserInfoVo) user;
            int userId = userInfoVo.getUserId();

            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            obj.put("current", 1);//
            obj.put("status", orderStatus);//
            int orderCount = 0;
            ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_order_list");
            request.setAttribute("hasNextValue", 0);
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                JSONObject data = resultBean.getData();
                request.setAttribute("data", data);
                boolean hasNext = data.getBooleanValue("has_next");
                orderCount = data.getJSONArray("order_list").size();
                request.setAttribute("hasNext", hasNext);
                if (hasNext) {
                    request.setAttribute("hasNextValue", 1);
                }
            }
            request.setAttribute("orderStatus", orderStatus);
            request.setAttribute("statusName", statusName.get(orderStatus));
            request.setAttribute("orderCount", orderCount);


            return "other-order-list";
        } catch (Exception e) {
            LOG.info("-------->", e);
        }
        return "500";
    }

    /**
     * 取消订单
     */
    @RequestMapping("update/orderStatus")
    public void cancelOrder(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "网络异常,稍后重试");
            request.setCharacterEncoding("utf-8");
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            response.setCharacterEncoding("utf-8");
            printWriter = response.getWriter();

            String orderNo = request.getParameter("orderNo");
            String userRemark = request.getParameter("userRemark");

            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = null;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
            } else {
                out.put("flag", 2);
                out.put("msg", "请先登录");
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                return;
            }
            int status = Integer.parseInt(request.getParameter("status"));

            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            obj.put("order_num", orderNo);//
            obj.put("user_remark", userRemark);
            obj.put("order_status", status);//0待付款1已付款2确认中3已失败4待发货5待收货6已完成7已取消8已删除9退款中10已退款
            ResultBean resultBean = CommonRequst.executeNew(obj, "update_order_status");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "操作成功");
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        } catch (Exception e) {
            LOG.info("----->取消订单异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }
}
