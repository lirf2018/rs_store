package com.yufan.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yufan.common.ResultCode;
import com.yufan.util.CommonRequst;
import com.yufan.util.ResultBean;
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
 * 创建时间:  2018/11/15 15:48
 * 功能介绍: 商品
 */
@Controller
@RequestMapping("/goods/")
public class GoodsController {

    private Logger LOG = Logger.getLogger(GoodsController.class);

    /**
     * 商品列表
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("goodsListPage")
    public String toGoodsListPage(HttpServletRequest request, HttpServletResponse response) {
        try {
            int current = 1;
            if (StringUtils.isNotEmpty(request.getParameter("current"))) {
                current = Integer.parseInt(request.getParameter("current"));
            }
            String categoryIds = request.getParameter("categoryIds");
            String leve1Ids = request.getParameter("leve1Ids");
            String goodsName = request.getParameter("goodsName");
            String searchType = "sort";
            if (StringUtils.isNotEmpty(request.getParameter("searchType"))) {
                searchType = request.getParameter("searchType");
            }
//
            request.setAttribute("searchType", searchType);
            request.setAttribute("current", current);
            request.setAttribute("goodsName", goodsName);
            request.setAttribute("categoryIds", categoryIds);
            request.setAttribute("leve1Ids", leve1Ids);
            return "goods-list";
        } catch (Exception e) {
            LOG.info("----->", e);
        }
        return "500";
    }

    /**
     * 商品搜索
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("search/goodsList")
    public String toSearchPage(HttpServletRequest request, HttpServletResponse response) {
        try {
            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = null;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
            }
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            String searchType = "sort";
            if (StringUtils.isNotEmpty(request.getParameter("searchType"))) {
                searchType = request.getParameter("searchType");
            }
            ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_search_history");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                request.setAttribute("data", resultBean.getData());
            }
            return "search";
        } catch (Exception e) {
            LOG.info("----->", e);
        }
        return "500";
    }


    /**
     * 跳转到商品详情页面
     *
     * @return
     */
    @RequestMapping("query/goodsInfo")
    public String toGoodsInfoPage(HttpServletRequest request, HttpServletResponse response) {
        String goodsId = request.getParameter("goodsId");
        String timeGoodsId = request.getParameter("timeGoodsId") == null || "".equals(request.getParameter("timeGoodsId")) ? "0" : request.getParameter("timeGoodsId");
        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }
        request.setAttribute("timeGoodsId", timeGoodsId);
        request.setAttribute("isAddtoCard", "1");//1 允许加入购物车
        //调用接口查询查询商品信息
        JSONObject obj = new JSONObject();
        obj.put("goods_id", goodsId);
        obj.put("time_goods_id", timeGoodsId);
        obj.put("user_id", userId);
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_goods_info");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            request.setAttribute("resultDate", resultBean.getData());
            Integer isSingle = resultBean.getData().getIntValue("is_single");
            Integer isAddtoCard = resultBean.getData().getIntValue("add_to_shopcard");
            request.setAttribute("isAddtoCard", isAddtoCard);//0不允许加入购物车
            //下列商品不允许加入购物车
            /**
             * 1.虚拟商品,独立一个订单
             * 2.商品券(单个生成订单)
             * 3.带押金的商品独立为一个订单
             * 4.如果是抢购商品,独立一个订单(is_time_goods)
             * 5.限购商品独立一个订单
             * 6.话费商品,租赁商品
             */
            JSONObject objJson = resultBean.getData();
            String salePricePage = objJson.getString("now_money");//商品详情页面显示的销售价格
            String truePricePage = objJson.getString("true_money");//商品详情页面显示的原价
            int storePage = objJson.getIntValue("goods_num");//商品详情页面显示的库存
            if (isSingle.intValue() == 0) {
                //sku商品
                JSONArray skuArray = JSONArray.parseArray(resultBean.getData().getString("goods_sku"));
                List<Map<String, String>> listSkuStore = new ArrayList<Map<String, String>>();
                List<Map<String, String>> listSkuPrice = new ArrayList<Map<String, String>>();
                List<Map<String, String>> listSkuImg = new ArrayList<Map<String, String>>();
                String goodsImg = resultBean.getData().getString("goods_img");
                for (int i = 0; i < skuArray.size(); i++) {
                    Map<String, String> mapSkuStore = new HashMap<String, String>();
                    Map<String, String> mapSkuPrice = new HashMap<String, String>();
                    Map<String, String> mapSkuImg = new HashMap<String, String>();
                    JSONObject goodSkuObj = skuArray.getJSONObject(i);
                    String propCode = goodSkuObj.getString("prop_code");

                    String skuStore = goodSkuObj.getString("sku_num");
                    mapSkuStore.put(propCode, skuStore);

                    String nowMoney = goodSkuObj.getString("now_money_");
                    mapSkuPrice.put(propCode, nowMoney);

                    String skuImg = goodSkuObj.getString("sku_img");
                    if (null == skuImg || skuImg.indexOf("null") >= 0) {
                        mapSkuImg.put(propCode, goodsImg);
                    } else {
                        mapSkuImg.put(propCode, skuImg);
                    }
                    listSkuStore.add(mapSkuStore);
                    listSkuPrice.add(mapSkuPrice);
                    listSkuImg.add(mapSkuImg);
                }
                storePage = objJson.getIntValue("goods_sku_num");//sku总库存
                salePricePage = objJson.getString("sku_price_interval");//sku价格区间
                //价格区间处理
                String[] skuPriceArray = salePricePage.split("-");
                request.setAttribute("skuMinPrice", skuPriceArray[0]);
                request.setAttribute("skuMaxPrice", skuPriceArray[0]);
                if (skuPriceArray.length > 1) {
                    request.setAttribute("skuMaxPrice", skuPriceArray[1]);
                }
                //sku库存列表
                request.setAttribute("listSkuStore", JSONObject.toJSONString(listSkuStore));
                //sku价格列表
                request.setAttribute("listSkuPrice", JSONObject.toJSONString(listSkuPrice));
                //sku图片列表
                request.setAttribute("listSkuImg", JSONObject.toJSONString(listSkuImg));
                request.setAttribute("salePricePage", salePricePage);
                request.setAttribute("truePricePage", truePricePage);
                request.setAttribute("storePage", storePage);
                return "goods-detail-sku";
            } else {
                //单品
                if (null != timeGoodsId && !"".equals(timeGoodsId) && !"0".equals(timeGoodsId)) {
                    int timeGoodsStore = objJson.getIntValue("time_goods_num");
                    if (timeGoodsStore < storePage) {
                        storePage = timeGoodsStore;
                    }
                    truePricePage = salePricePage;
                    salePricePage = objJson.getString("time_price");
                }
                salePricePage = new BigDecimal(salePricePage).setScale(2, BigDecimal.ROUND_HALF_UP).toString();
                truePricePage = new BigDecimal(truePricePage).setScale(2, BigDecimal.ROUND_HALF_UP).toString();
                request.setAttribute("salePricePage", salePricePage);
                request.setAttribute("truePricePage", truePricePage);
                request.setAttribute("storePage", storePage);
                return "goods-detail";
            }
        }
        request.setAttribute("errorMsg", "商品已下架");
        return "404";
    }


    /**
     * 查询商品列表
     */
    @RequestMapping("query/goodsList")
    public void queryGoodsList(HttpServletRequest request, HttpServletResponse response) {
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
            String categoryIds = request.getParameter("categoryIds");
            String leve1Ids = request.getParameter("leve1Ids");
            String goodsName = request.getParameter("goodsName");
            String searchType = "sort";
            if (StringUtils.isNotEmpty(request.getParameter("searchType"))) {
                searchType = request.getParameter("searchType");
            }

            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = null;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
            }

            JSONObject obj = new JSONObject();
            obj.put("current", current);
            obj.put("category_ids", categoryIds);
            obj.put("leve1_ids", leve1Ids);
            obj.put("goods_name", goodsName);
            obj.put("user_id", userId);

            ResultBean resultBean = null;
            if ("new".equals(searchType)) {
                resultBean = CommonRequst.executeNew(obj, "qurey_newgoods_list");
            } else if ("hot".equals(searchType)) {
                resultBean = CommonRequst.executeNew(obj, "qurey_hotgoods_list");
            } else if ("time".equals(searchType)) {
                resultBean = CommonRequst.executeNew(obj, "qurey_timegoods_list");
            } else {
                resultBean = CommonRequst.executeNew(obj, "qurey_sortgoods_list");
            }
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "查询成功");
                JSONObject data = resultBean.getData();
                JSONArray goodsList = null;
                if ("new".equals(searchType)) {
                    goodsList = data.getJSONArray("new_goods_list");
                } else if ("hot".equals(searchType)) {
                    goodsList = data.getJSONArray("hot_goods_list");
                } else if ("time".equals(searchType)) {
                    goodsList = data.getJSONArray("time_goods_list");
                } else {
                    goodsList = data.getJSONArray("sort_goods_list");
                }
                out.put("goodsList", goodsList);
                out.put("hasNext", data.getBooleanValue("has_next"));
            }
            out.put("searchType", searchType);
            out.put("current", current);
            out.put("goodsName", goodsName);

            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        } catch (Exception e) {
            LOG.info("----->查询商品列表异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

    /**
     * 单个商品下单前校验(跳转到订单提交页面前)
     */
    @RequestMapping("checkGoodsOrder")
    public void checkGoodsOrderParam(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "操作失败");
            printWriter = response.getWriter();
            int goodsId = Integer.parseInt(request.getParameter("goodsId"));
            int timeGoodsId = Integer.parseInt(request.getParameter("timeGoodsId"));
            int orderCount = Integer.parseInt(request.getParameter("orderCount"));
            String goodsSpace = request.getParameter("goodsSpace");
            BigDecimal salePrice = new BigDecimal(request.getParameter("salePrice"));

            Object user = request.getSession().getAttribute("userInfoVo");
            if (null == user) {
                out.put("flag", 2);
                out.put("msg", "请先登录");
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                return;
            }
            UserInfoVo userInfoVo = (UserInfoVo) user;
            int userId = userInfoVo.getUserId();
            //调用接口
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            obj.put("goods_id", goodsId);
            obj.put("goods_space", goodsSpace);
            obj.put("order_count", orderCount);
            obj.put("sale_price", salePrice);
            obj.put("time_goods_id", timeGoodsId);
            ResultBean resultBean = CommonRequst.executeNew(obj, "check_goods_order");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "成功");
            } else {
                if (null == resultBean) {
                    out.put("flag", 4);
                    out.put("msg", ResultCode.NET_ERROR);
                } else {
                    out.put("flag", resultBean.getRespCode().intValue());
                    out.put("msg", resultBean.getRespDesc());
                }
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        } catch (Exception e) {
            LOG.info("----->单个商品下单前校验异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

}
