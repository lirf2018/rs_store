package com.yufan.controller;

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
 * 创建时间:  2018/11/15 15:53
 * 功能介绍: 地址管理
 */
@Controller
@RequestMapping("/address/")
public class AddrController {
    private Logger LOG = Logger.getLogger(AddrController.class);

    /**
     * 查询用户收货地址(用户中心跳转到)
     */
    @RequestMapping("query/userAddress")
    public void queryUserAddrList(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        out.put("msg", "网络异常");
        out.put("flag", 4);
        try {
            printWriter = response.getWriter();
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

            //调用接口
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            ResultBean resultBean = CommonRequst.executeNew(obj, "query_user_addr_list");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                JSONObject data = resultBean.getData();
                out.put("flag", 1);
                out.put("msg", data.getJSONArray("list_user_addr"));
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加全国收货地址
     */
    @RequestMapping("add/userAddress")
    public void addUserAddr(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "网络异常,稍后重试");
            request.setCharacterEncoding("utf-8");
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            response.setCharacterEncoding("utf-8");
            printWriter = response.getWriter();

            String addrUserName = request.getParameter("addrUserName");
            String addrUserPhone = request.getParameter("addrUserPhone");
            String inChoseAddrCode = request.getParameter("inChoseAddrCode");
            String inChoseAddr = request.getParameter("inChoseAddr");
            String inChoseAddrDetail = request.getParameter("inChoseAddrDetail");
            String isDefaul = request.getParameter("isDefaul");

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

            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            obj.put("area_ids", inChoseAddrCode);//
            obj.put("area_name", inChoseAddr);//
            obj.put("user_phone", addrUserPhone);//
            obj.put("user_name", addrUserName);//
            obj.put("addr_detail", inChoseAddrDetail);//
            obj.put("is_default", isDefaul);//
            obj.put("addr_type", 1);//地址类型1全国地址2平台配送或者自己取地址
            obj.put("addr_id", 0);//
            obj.put("addr_name", "");//
            ResultBean resultBean = CommonRequst.executeNew(obj, "create_user_addr");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "操作成功");
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
            return;

        } catch (Exception e) {
            LOG.info("----->", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

    /**
     * 删除收货地址
     */
    @RequestMapping("delete/userAddress")
    public void deleteUserAddr(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "网络异常,稍后重试");
            request.setCharacterEncoding("utf-8");
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            response.setCharacterEncoding("utf-8");
            printWriter = response.getWriter();

            String id = request.getParameter("id");
            if (StringUtils.isEmpty(id)) {
                LOG.info("--->id为空");
                out.put("flag", 0);
                out.put("msg", "操作失败");
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                return;
            }

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

            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            obj.put("user_addr_id", id);//
            ResultBean resultBean = CommonRequst.executeNew(obj, "delete_user_addr");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "操作成功");
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
            return;

        } catch (Exception e) {
            LOG.info("----->", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

    /**
     * 设置默认收货地址
     */
    @RequestMapping("update/userAddressDefault")
    public void updateSetUserAddrDefault(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "网络异常,稍后重试");
            request.setCharacterEncoding("utf-8");
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            response.setCharacterEncoding("utf-8");
            printWriter = response.getWriter();

            String id = request.getParameter("id");
            if (StringUtils.isEmpty(id)) {
                LOG.info("--->id为空");
                out.put("flag", 0);
                out.put("msg", "操作失败");
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                return;
            }

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
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);//
            obj.put("user_addr_id", id);//
            ResultBean resultBean = CommonRequst.executeNew(obj, "update_user_addr_default");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "操作成功");
            }
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
            return;

        } catch (Exception e) {
            LOG.info("----->", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

}
