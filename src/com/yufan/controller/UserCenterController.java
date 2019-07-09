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

/**
 * 创建人: lirf
 * 创建时间:  2018/11/15 15:56
 * 功能介绍:
 */
@Controller
@RequestMapping("/center/")
public class UserCenterController {
    private Logger LOG = Logger.getLogger(UserCenterController.class);

    /**
     * 用户中心
     *
     * @return
     */
    @RequestMapping("userCenter")
    public String toUserCenterPage(HttpServletRequest request, HttpServletResponse response) {
        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }
        JSONObject obj = new JSONObject();
        obj.put("user_id", userId);
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_user_center");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            JSONObject objData = resultBean.getData();

            request.setAttribute("resultDate", resultBean.getData());
            request.setAttribute("user_mobile", objData.getString("user_mobile"));  //用户手机
            request.setAttribute("nick_name", objData.getString("nick_name"));//昵称
            request.setAttribute("user_jifen", objData.getString("user_jifen")); //用户积分
            request.setAttribute("user_img", objData.getString("user_img"));
            request.setAttribute("ticket_counts", objData.getString("ticket_counts")); //卡券数
            request.setAttribute("card_count", objData.getString("card_count")); //购物车数量

            int failOrder = objData.getInteger("fail_order");
            request.setAttribute("fail_order", failOrder);//失败订单数
            if (failOrder > 99) {
                request.setAttribute("fail_order", "99+");//失败订单数
            }

            int waitPayorder = objData.getInteger("wait_payorder");
            request.setAttribute("wait_payorder", waitPayorder);//待付款
            if (waitPayorder > 99) {
                request.setAttribute("wait_payorder", "99+");//待付款
            }

            int waitGetorder = objData.getInteger("wait_getorder");
            request.setAttribute("wait_getorder", waitGetorder);  //待收货
            if (waitGetorder > 99) {
                request.setAttribute("wait_getorder", "99+");  //待收货
            }

            int sureOrder = objData.getInteger("sure_order");
            request.setAttribute("sure_order", sureOrder);  //确认中
            if (sureOrder > 99) {
                request.setAttribute("sure_order", "99+");  //确认中
            }

            int ispayOrder = objData.getInteger("ispay_order");
            request.setAttribute("ispay_order", ispayOrder);  //已付款
            if (ispayOrder > 99) {
                request.setAttribute("send_order", "99+");
            }

            int isFinish = objData.getInteger("is_finish");
            request.setAttribute("is_finish", isFinish);  //已完成
            if (ispayOrder > 99) {
                request.setAttribute("send_order", "99+");
            }

            int isTuikuang = objData.getInteger("is_tuikuang");
            request.setAttribute("is_tuikuang", isTuikuang);  //已退款
            if (ispayOrder > 99) {
                request.setAttribute("send_order", "99+");
            }
            int isDoing = objData.getInteger("is_doing");
            request.setAttribute("is_doing", isDoing);  //已取消
            if (ispayOrder > 99) {
                request.setAttribute("is_doing", "99+");
            }

            int wattingTuikuang = objData.getInteger("watting_tuikuang");
            request.setAttribute("watting_tuikuang", wattingTuikuang);  //退款中
            if (ispayOrder > 99) {
                request.setAttribute("send_order", "99+");
            }

            return "user-center";
        }
        return "500";
    }


    /**
     * 跳转到设置页
     *
     * @return
     */
    @RequestMapping("settingPage")
    public String toSettingPage(HttpServletRequest request, HttpServletResponse response) {

        //微信结果
        String msgType = request.getParameter("msgType");
        String boundWXMsg = String.valueOf(request.getSession().getAttribute("boundWXMsg"));
        LOG.info("---->boundWXMsg--->" + boundWXMsg);
        if ("1".equals(msgType) && StringUtils.isNotEmpty(boundWXMsg) && !"null".equals(boundWXMsg)) {
            request.setAttribute("msg", boundWXMsg);
            request.getSession().removeAttribute("boundWXMsg");
        }

        //查询绑定列表 调用接口
        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }
        JSONObject obj = new JSONObject();
        obj.put("user_id", userId);
        ResultBean resultBean = CommonRequst.executeNew(obj, "user_bind_list");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            JSONObject result = resultBean.getData();
            request.setAttribute("userMobile", result.getString("phone"));
            JSONArray jsonArray = result.getJSONArray("list_bind");
            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject objData = jsonArray.getJSONObject(i);
                //sns_type":4//1、腾讯微博；2、新浪微博；3、人人网；4、微信；5、服务窗；6、一起沃；7、QQ;'
                int snsType = objData.getInteger("sns_type");
                request.setAttribute("snsType" + snsType, snsType);
            }
        }
        return "serzhi";
    }

    /**
     * 跳转到增加用户全国收货地址
     *
     * @return
     */
    @RequestMapping("toUserAddressPage")
    public String toUserAddrAdd(HttpServletRequest request, HttpServletResponse response) {

        return "user-addr";
    }

    /**
     * 跳转到投诉建议列表页
     *
     * @return
     */
    @RequestMapping("suggestPageList")
    public String toSuggestPage(HttpServletRequest request, HttpServletResponse response) {
        int current = 1;
        if (null != request.getParameter("current")) {
            current = Integer.parseInt(request.getParameter("current"));
        }

        //调用接口
        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }

        JSONObject obj = new JSONObject();
        obj.put("user_id", userId);
        obj.put("current", current);
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_user_complain_list");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            request.setAttribute("data", resultBean.getData());
        }
        return "suggest-list";
    }


    /**
     * 跳转到增加建议页面
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("toAddsuggestPage")
    public String toAddSuggestPage(HttpServletRequest request, HttpServletResponse response) {

        return "suggest-add";
    }

    /**
     * 跳转到建议详情页
     *
     * @return
     */
    @RequestMapping("suggestInfo")
    public String toSuggestInfoPage(HttpServletRequest request, HttpServletResponse response) {

        //调用接口
        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }
        int complainId = Integer.parseInt(request.getParameter("complainId"));

        JSONObject obj = new JSONObject();
        obj.put("user_id", userId);
        obj.put("complain_id", complainId);
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_user_complain_info");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            request.setAttribute("data", resultBean.getData());
        }
        return "suggest-info";
    }


    /**
     * 跳转到售后服务页面
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("toServicePage")
    public String toServicePage(HttpServletRequest request, HttpServletResponse response) {
        return "service";
    }

    /**
     * 增加建议
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("add/suggest")
    public void addSuggest(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "提交失败");
            printWriter = response.getWriter();

            String information = request.getParameter("information");
            String contents = request.getParameter("contents");
            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = 0;
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

            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            obj.put("information", information);
            obj.put("contents", contents);
            ResultBean resultBean = CommonRequst.executeNew(obj, "create_complain");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                request.setAttribute("data", resultBean.getData());
                out.put("flag", 1);
                out.put("msg", "提交成功");
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
            LOG.info("异常");
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

    /**
     * 跳转到消息列表页
     *
     * @return
     */
    @RequestMapping("query/messageListPage")
    public String toMessagePage(HttpServletRequest request, HttpServletResponse response) {
        int current = 1;
        if (null != request.getParameter("current")) {
            current = Integer.parseInt(request.getParameter("current"));
        }

        //调用接口
        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }

        JSONObject obj = new JSONObject();
        obj.put("user_id", userId);
        obj.put("current", current);
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_user_news_list");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            request.setAttribute("data", resultBean.getData());
        }
        return "message-list";
    }

    /**
     * 跳转到消息详情页
     *
     * @return
     */
    @RequestMapping("query/messageInfo")
    public String toMessageInfoPage(HttpServletRequest request, HttpServletResponse response) {

        //调用接口
        Object user = request.getSession().getAttribute("userInfoVo");
        Integer userId = 0;
        if (null != user) {
            UserInfoVo userInfoVo = (UserInfoVo) user;
            userId = userInfoVo.getUserId();
        }
        int newsId = Integer.parseInt(request.getParameter("newsId"));

        JSONObject obj = new JSONObject();
        obj.put("user_id", userId);
        obj.put("news_id", newsId);
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_user_news_info");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            request.setAttribute("data", resultBean.getData());
        }
        return "message-info";
    }

}
