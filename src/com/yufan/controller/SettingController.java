package com.yufan.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
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
 * 创建时间:  2018/11/15 16:39
 * 功能介绍:
 */
@Controller
@RequestMapping("/setting/")
public class SettingController {
    private Logger LOG = Logger.getLogger(SettingController.class);

    /**
     * 跳转到投诉建议列表页
     *
     * @return
     */
    @RequestMapping("query/suggestList")
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
     * 跳转到建议详情页
     *
     * @return
     */
    @RequestMapping("query/suggestInfo")
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
     * 跳转到绑定/解绑手机号页面
     *
     * @return
     */
    @RequestMapping("user/phoneBoundPage")
    public String toBoundPage(HttpServletRequest request, HttpServletResponse response) {
        String op = request.getParameter("op");
        String phone = request.getParameter("phone");
        request.setAttribute("op", op);
        request.setAttribute("phone", phone);
        //验证码类型:1手机绑定2修改密码3重置密码4手机解绑5手机注册
        if ("add".equals(op)) {
            request.setAttribute("validType", 1);
        } else {
            request.setAttribute("validType", 4);
        }

        return "phone-bang";
    }


    /**
     * 手机号码解绑/绑定
     *
     * @param request
     * @param response
     */
    @RequestMapping("user/phoneBound")
    public void phoneBound(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "网络异常,请稍后重试");
            printWriter = response.getWriter();

            String op = request.getParameter("op");
            String phone = request.getParameter("phone");
            String validCode = request.getParameter("validCode");

            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = 0;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
            }
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            obj.put("user_mobile", phone);
            obj.put("valid_code", validCode);
            if (StringUtils.isEmpty(phone) || StringUtils.isEmpty(validCode) || userId == 0) {
                out.put("msg", "缺少必要参数");
            } else {
                ResultBean resultBean = null;
                if ("add".equals(op)) {
                    resultBean = CommonRequst.executeNew(obj, "bound_user_mobile");
                } else {
                    resultBean = CommonRequst.executeNew(obj, "delete_user_phone");
                }
                if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                    out.put("flag", 1);
                } else {
                    if (null != resultBean) {
                        out.put("msg", resultBean.getRespDesc());
                    }
                }
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        } catch (Exception e) {
            printWriter.flush();
            printWriter.close();
        }
    }

}
