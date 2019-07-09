package com.yufan.controller;

import com.alibaba.fastjson.JSONObject;
import com.yufan.util.CommonRequst;
import com.yufan.util.ResultBean;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 创建人: lirf
 * 创建时间:  2018/11/15 15:51
 * 功能介绍: main页
 */
@Controller
@RequestMapping("/index/")
public class MainController {

    private Logger LOG = Logger.getLogger(MainController.class);


    /**
     * 跳转到mian页
     *
     * @return
     */
    @RequestMapping("main")
    public String toMainPage(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("--->跳转到mian页");
        //跳转到mian页
        JSONObject obj = new JSONObject();
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_main");
        if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
            request.setAttribute("resultDate", resultBean.getData());
        }
        //查询菜单
        ResultBean resultBeanMenu = CommonRequst.executeNew(obj, "qurey_main_menu");
        if (null != resultBeanMenu && resultBeanMenu.getRespCode().intValue() == 1) {
            request.setAttribute("resultDateMenu", resultBeanMenu.getData());
        }
        return "main";
    }

}
