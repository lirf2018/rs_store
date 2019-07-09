package com.yufan.controller;

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

/**
 * 创建人: lirf
 * 创建时间:  2018/11/15 15:59
 * 功能介绍: 购物车
 */
@Controller
@RequestMapping("/car/")
public class ShopCarController {

    private Logger LOG = Logger.getLogger(ShopCarController.class);

    /**
     * 跳转到购物车
     *
     * @return
     */
    @RequestMapping("shopCar")
    public String toShopCardPage(HttpServletRequest request, HttpServletResponse response) {

        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }
        Integer userChoseAddrType = Integer.parseInt(request.getParameter("userChoseAddrType") == null ? "-1" : request.getParameter("userChoseAddrType"));
        request.setAttribute("userChoseAddrType", userChoseAddrType);

        request.setAttribute("getWay_1", "style=\"display: none\"");
        request.setAttribute("getWay1", "style=\"display: none\"");
        request.setAttribute("getWay4", "style=\"display: none\"");
        request.setAttribute("getWay5", "style=\"display: none\"");

        if (userChoseAddrType != -1) {
            request.removeAttribute("getWay" + userChoseAddrType);
        } else {
            request.removeAttribute("getWay_1");
        }
        //调用接口查询查询商品信息
        JSONObject obj = new JSONObject();
        obj.put("user_id", userId);
        obj.put("get_way", userChoseAddrType == -1 ? null : userChoseAddrType);
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_order_cart_list_v2");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            request.setAttribute("resultDate", resultBean.getData());
            return "shop-car";
        }
        return "500";
    }


    /**
     * 更新商品购物车
     *
     * @param request
     * @param response
     */
    @RequestMapping("update/shopCar")
    public void updateShopCard(HttpServletRequest request, HttpServletResponse response) {
        JSONObject out = new JSONObject();
        PrintWriter writer = null;
        try {
            out.put("flag", -1);
            out.put("msg", "操作失败");
            writer = response.getWriter();
            String cardId = request.getParameter("cardId");
            String count = request.getParameter("count");
            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = 0;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
                //调用接口查询查询商品信息
                JSONObject obj = new JSONObject();
                obj.put("user_id", userId);
                obj.put("card_id", cardId);
                obj.put("goods_count", count);
                ResultBean resultBean = CommonRequst.executeNew(obj, "update_ordercard_num");
                if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                    out.put("flag", 1);
                    out.put("msg", "操作成功");
                }
            } else {
                out.put("flag", 2);
                out.put("msg", "用户未登录");
                return;
            }
            writer.print(out);
        } catch (Exception e) {
            out.put("flag", "false");
            out.put("msg", "网络连接异常");
            writer.print(out);
            LOG.info("-------------->更新商品购物车异常", e);
        }
    }

    /**
     * 增加商品到购物车(用户登录)
     *
     * @return
     */
    @RequestMapping("add/shopCar")
    public void addShopCard(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "增加失败");
            printWriter = response.getWriter();
            LOG.info("--增加到购物车->");
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
            int isSingle = Integer.parseInt(request.getParameter("isSingle"));
            int goodsId = Integer.parseInt(request.getParameter("goodsId"));
            String goodsSpec = request.getParameter("goodsSpec");//sku商品必须
            if (isSingle == 0) {
                //sku商品
                if (StringUtils.isEmpty(goodsSpec)) {
                    out.put("flag", 3);
                    out.put("msg", "请选择商品规格");
                    printWriter.print(out);
                    printWriter.flush();
                    printWriter.close();
                    return;
                }
            }
            int goodsCount = Integer.parseInt(request.getParameter("goodsCount"));

            //调用接口
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            obj.put("goods_id", goodsId);
            obj.put("goods_spec", goodsSpec);
            obj.put("buy_count", goodsCount);
            ResultBean resultBean = CommonRequst.executeNew(obj, "create_ordercard");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "增加成功");
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
            LOG.info("增加商品到购物车(用户登录)->异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }


    /**
     * 购物车去结算商品校验(跳转到订单提交页面前)
     */
    @RequestMapping("check/shopCarOrder")
    public void checkCarOrderParam(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "操作失败");
            printWriter = response.getWriter();
            String cardIds = request.getParameter("cardIds");
            Object user = request.getSession().getAttribute("userInfoVo");
            if (null == user) {
                out.put("flag", 2);
                out.put("msg", "请先登录");
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                return;
            }
            cardIds = cardIds.substring(0, cardIds.length() - 1);
            UserInfoVo userInfoVo = (UserInfoVo) user;
            int userId = userInfoVo.getUserId();
            //调用接口
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            obj.put("cart_ids", cardIds);
            ResultBean resultBean = CommonRequst.executeNew(obj, "check_cart_order_v2");
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
            LOG.info("----->购物车去结算商品校验异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

    /**
     * 删除购物车(用户登录)
     */
    @RequestMapping("delete/shopCar")
    public void deleteOrderCard(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "删除失败");
            printWriter = response.getWriter();
            LOG.info("--删除购物车->");
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
            String cardIds = request.getParameter("cardIds");//购物车标识字符串(必须)
            if (StringUtils.isEmpty(cardIds)) {
                out.put("flag", 0);
                out.put("msg", "删除失败:cardIds不能为空");
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                return;
            }
            cardIds = cardIds.substring(0, cardIds.length() - 1);
            //调用接口
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            obj.put("card_ids", cardIds);
            ResultBean resultBean = CommonRequst.executeNew(obj, "delete_ordercard");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "删除成功");
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
            LOG.info("--删除购物车(用户登录)->异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

}
