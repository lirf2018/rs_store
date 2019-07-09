package com.yufan.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yufan.common.ResultCode;
import com.yufan.util.CodeUtil;
import com.yufan.util.CommonRequst;
import com.yufan.util.ResultBean;
import com.yufan.util.RsConstants;
import com.yufan.vo.req.UserInfoVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;

/**
 * 创建人: lirf
 * 创建时间:  2018/11/15 16:16
 * 功能介绍:
 */
@Controller
@RequestMapping("/ajax/")
public class AjaxController {

    private Logger LOG = Logger.getLogger(AjaxController.class);

    /**
     * 发送手机验证码
     */
    @RequestMapping("phone/generatePhoneCode")
    public void generatePhoneCode(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "发送失败");
            printWriter = response.getWriter();
            LOG.info("--发送手机验证码->");
            String phone = request.getParameter("phone");
            String codeDesc = request.getParameter("codeDesc");
            int validType = Integer.parseInt(request.getParameter("validType"));//验证码类型:1手机绑定2修改密码3重置密码4手机解绑5手机注册

            //调用接口
            JSONObject obj = new JSONObject();
            obj.put("valid_type", validType);//类型(必须)
            obj.put("valid_param", phone.trim());//手机号码(必须)
            obj.put("valid_desc", codeDesc);//描述(必须)如：账号绑定手机号码

            ResultBean resultBean = CommonRequst.executeNew(obj, "create_verification");
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
            LOG.info("--发送手机验证码异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }


    /**
     * 检验图形码和手机验证机码
     */
    @RequestMapping("check/allCode")
    public void checkPhoneCode(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter printWriter = null;
        JSONObject out = new JSONObject();
        try {
            out.put("flag", 0);
            out.put("msg", "检验失败");
            printWriter = response.getWriter();
            LOG.info("--检验图形码和手机验证机码->");
            String imgCode = request.getParameter("imgCode");
            String phoneCode = request.getParameter("phoneCode");

            String validType = request.getParameter("validType");//验证码类型:1手机绑定2修改密码3重置密码4手机解绑5手机注册
            String phone = request.getParameter("phone");

            if (StringUtils.isEmpty(imgCode) || StringUtils.isEmpty(phoneCode) || StringUtils.isEmpty(validType) || StringUtils.isEmpty(phone)) {
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                request.getSession().removeAttribute("imgCode");
                return;
            }
            String imgCodeSys = String.valueOf(request.getSession().getAttribute("imgCode"));//系统中保存有的
            //比较图形码(不区分大小写)
            if (!imgCode.equalsIgnoreCase(imgCodeSys)) {
                out.put("msg", "图形码不正确");
                printWriter.print(out);
                printWriter.flush();
                printWriter.close();
                request.getSession().removeAttribute("imgCode");
                return;
            }
            out.put("msg", "验证码不正确");
            //调用接口
            JSONObject obj = new JSONObject();
            obj.put("valid_type", validType);//验证码类型:1手机绑定2修改密码3重置密码4手机解绑5手机注册
            obj.put("phone", phone);//手机号码(必须)
            obj.put("phone_code", phoneCode);//
            ResultBean resultBean = CommonRequst.executeNew(obj, "check_phone_code");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                out.put("flag", 1);
                out.put("msg", "校验成功");
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
            request.getSession().removeAttribute("imgCode");
        } catch (Exception e) {
            LOG.info("--检验图形码和手机验证机码异常", e);
            printWriter.print(out);
            printWriter.flush();
            printWriter.close();
        }
    }

//    /**
//     * 查询用户绑定信息
//     */
//    @RequestMapping("query/bound")
//    public void queryBound(HttpServletRequest request, HttpServletResponse response) {
//        PrintWriter printWriter = null;
//        JSONObject out = new JSONObject();
//        try {
//            out.put("flag", 0);
//            out.put("msg", "网络异常,请稍后重试");
//            printWriter = response.getWriter();
//
//            Object user = request.getSession().getAttribute("userInfoVo");
//            Integer userId = 0;
//            if (null != user) {
//                UserInfoVo userInfoVo = (UserInfoVo) user;
//                userId = userInfoVo.getUserId();
//            }
//            JSONObject obj = new JSONObject();
//            obj.put("user_id", userId);
//            ResultBean resultBean = CommonRequst.executeNew(obj, "user_bind_list");
//            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
//                JSONObject result = resultBean.getData();
//                out.put("userMobile", result.getString("phone"));
//                JSONArray boundArray = result.getJSONArray("list_bind");
//                out.put("boundArray", boundArray);
//            }
//
//            printWriter.print(out);
//            printWriter.flush();
//            printWriter.close();
//        } catch (Exception e) {
//            printWriter.flush();
//            printWriter.close();
//        }
//    }


}
