package com.yufan.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yufan.common.ResultCode;
import com.yufan.util.CommonRequst;
import com.yufan.util.ResultBean;
import com.yufan.vo.req.UserInfoVo;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * 创建人: lirf
 * 创建时间:  2018/11/15 15:49
 * 功能介绍: 类别
 */
@Controller
@RequestMapping("/category/")
public class CategroyController {

    private Logger LOG = Logger.getLogger(CategroyController.class);

    /**
     * 跳转到分类页
     *
     * @return
     */
    @RequestMapping("listCategoryPage")
    public String toCategoryPage(HttpServletRequest request, HttpServletResponse response) {
        //调用接口查询分类
        JSONObject obj = new JSONObject();
        ResultBean resultBean = CommonRequst.executeNew(obj, "qurey_classify_category");
        JSONArray categoryLeve1RespBeanList = resultBean.getData().getJSONArray("list_leve1");
        request.setAttribute("categoryLeve1RespBeanList", categoryLeve1RespBeanList);
        return "category";
    }

    /**
     * 清空搜索历史(用户登录)
     */
    @RequestMapping("cleanSearchHistory")
    public void deleteSearchHistory(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "删除失败");
            printWriter = response.getWriter();
            LOG.info("--删除清空搜索历史->");
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
            ResultBean resultBean = CommonRequst.executeNew(obj, "clean_search_history");
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
            LOG.info("--清空搜索历史(用户登录)->异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }


}
