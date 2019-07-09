package com.yufan.controller;

import com.alibaba.fastjson.JSONObject;
import com.yufan.common.ResultCode;
import com.yufan.util.CommonRequst;
import com.yufan.util.MD5;
import com.yufan.util.ResultBean;
import com.yufan.util.RsConstants;
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
 * 创建时间:  2018/11/15 15:39
 * 功能介绍: 登录页面
 */
@Controller
@RequestMapping("/user/")
public class LoginController {
    private Logger LOG = Logger.getLogger(LoginController.class);

    //=============================================================用户登录===========================================================================

    /**
     * 跳转到登录页
     * request.getSession().setAttribute("openId","o0h3Ps_RnNdnZxMrgM906qRfpvLI");
     * redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx0bdabad84b781956&redirect_uri=http%3A%2F%2Flrf-13418915218.6655.la%3A26761%2Fweixin%2Fweixin-login&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect
     *
     * @return
     */
    @RequestMapping("loginPage")
    public String toLoginPage(HttpServletRequest request, HttpServletResponse response) {

        //微信结果
        String msgType = request.getParameter("msgType");
        String loginWXMsg = String.valueOf(request.getSession().getAttribute("loginWXMsg"));
        if ("1".equals(msgType) && StringUtils.isNotEmpty(loginWXMsg) && !"null".equals(loginWXMsg)) {
            request.setAttribute("msg", loginWXMsg);
            request.getSession().removeAttribute("loginWXMsg");
        }

        return "login";
    }

    @RequestMapping("login")
    public void login(HttpServletRequest request, HttpServletResponse response) {
        JSONObject out = new JSONObject();
        try {
            PrintWriter writer = response.getWriter();
            String retUrl = (String) request.getSession().getAttribute("beforeUrl");
            request.getSession().removeAttribute("beforeUrl");

            out.put("toUrl", "");
            out.put("flag", "0");
            out.put("msg", ResultCode.getRespDesc(1001));

            String loginName = request.getParameter("loginName");
            String loginPwsswd = request.getParameter("loginPasswd");
            String loginPage = "";
            if (StringUtils.isEmpty(loginName) || StringUtils.isEmpty(loginPwsswd)) {
                out.put("toUrl", "");
                out.put("flag", "0");
                out.put("msg", ResultCode.getRespDesc(1002));
                return;
            }
            //调用接口查询用户登录信息
            JSONObject obj = new JSONObject();
            obj.put("login_name", loginName.trim());
            obj.put("login_passwd", MD5.enCodeStandard(loginPwsswd.trim()));
            ResultBean resultBean = CommonRequst.executeNew(obj, "user_login");
            if (null == resultBean) {
                out.put("flag", "0");
                out.put("msg", ResultCode.getRespDesc(1000));
                writer.print(out);
                writer.flush();
                writer.close();
                return;
            }
            int respCode = resultBean.getRespCode();
            if (respCode != 1) {
                out.put("flag", "0");
                out.put("msg", resultBean.getRespDesc());
                writer.print(out);
                writer.flush();
                writer.close();
                return;
            }

            UserInfoVo userInfoVo = JSONObject.toJavaObject(resultBean.getData(), UserInfoVo.class);
            if (null == userInfoVo) {
                LOG.info("------->userInfoVo为空,请求接口异常或者userInfoVo赋值异常");
                out.put("flag", "0");
                out.put("msg", ResultCode.getRespDesc(1000));
                writer.print(out);
                writer.flush();
                writer.close();
                return;
            }

            String goodsInfoPageUrl = String.valueOf(request.getSession().getAttribute("goodsInfoPageUrl"));//跳转到商品详情页面
            if (StringUtils.isNotEmpty(goodsInfoPageUrl) && !"null".equals(goodsInfoPageUrl)) {
                LOG.info("---------->跳转到商品详情页面");
                loginPage = request.getContextPath() + goodsInfoPageUrl;
                out.put("toUrl", loginPage);
                request.getSession().removeAttribute("goodsInfoPageUrl");
            } else if (StringUtils.isEmpty(retUrl)) {
                loginPage = request.getContextPath() + RsConstants.USER_CENTER_URL;
                out.put("toUrl", loginPage);
            } else {
//                retUrl=/rs_store/weixin/login?beforeUrl=/rs_store/user/user-center
                String[] arrayUrl = retUrl.split("beforeUrl=");
                if (arrayUrl.length == 2) {
                    loginPage = arrayUrl[1];
                    out.put("toUrl", loginPage);
                }
            }


            request.getSession().setAttribute("userInfoVo", userInfoVo);
            out.put("flag", "1");
            out.put("msg", ResultCode.getRespDesc(1));
            writer.print(out);
            writer.flush();
            writer.close();
            return;

        } catch (Exception e) {
            LOG.info("--------异常------>" + e);
        }
    }

    /**
     * 退出登录
     *
     * @return
     */
    @RequestMapping("login/out")
    public void outLogin(HttpServletRequest request, HttpServletResponse response) {
        try {
            String loginPage = request.getContextPath() + RsConstants.INTERCEPT_URL;
            //请空数据
            request.getSession().invalidate();
            response.sendRedirect(loginPage);
        } catch (Exception e) {
            LOG.info("---->退出异常");
        }
    }


    //=============================================================手机注册和重置密码===========================================================================

    /**
     * 跳转到手机注册页(手机)
     *
     * @return
     */
    @RequestMapping("login/phoneRegister")
    public String toSettingPage(HttpServletRequest request, HttpServletResponse response) {
        return "phone-register";
    }

    /**
     * 跳转到密码重置页(手机)
     *
     * @return
     */
    @RequestMapping("login/phoneResetPassWd")
    public String toPhoneRegisterPage(HttpServletRequest request, HttpServletResponse response) {
        Object user = request.getSession().getAttribute("userInfoVo");
        if (null != user) {
            request.setAttribute("phone", ((UserInfoVo) user).getUserMobile());
        }
        return "phone-reset-passwd";
    }

    /**
     * 手机注册并跳转到手机注册结果(手机)
     *
     * @return
     */
    @RequestMapping("login/phoneRegisterResult")
    public String toPhoneRegisterResultPage(HttpServletRequest request, HttpServletResponse response) {
        //调用接口
        JSONObject obj = new JSONObject();
        String mobile = request.getParameter("phone");
        String loginPass = request.getParameter("newPasswd");
        String code = request.getParameter("phoneCode");
        obj.put("mobile", mobile);//
        obj.put("valid_code", code);//
        obj.put("passwd", MD5.enCodeStandard(loginPass));//
        request.setAttribute("errorLinkValue", 555);
        request.setAttribute("msg", "注册失败,稍后重试");
        request.setAttribute("code", -1);
        if (StringUtils.isEmpty(mobile) || StringUtils.isEmpty(code) || StringUtils.isEmpty(loginPass)) {
            request.setAttribute("msg", "缺少注册参数");
        } else {
            ResultBean resultBean = CommonRequst.executeNew(obj, "create_phone_register");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                request.setAttribute("code", 1);
                request.setAttribute("errorLinkValue", 666);
            } else {
                if (null != resultBean) {
                    request.setAttribute("msg", resultBean.getRespDesc());
                }
            }
        }
        return "phone-register-result";
    }

    /**
     * 手机密码重置并跳转到手机重置密码结果(手机)
     *
     * @return
     */
    @RequestMapping("login/phoneResetPdResult")
    public String toPasswdResetResultPage(HttpServletRequest request, HttpServletResponse response) {
        //调用接口
        JSONObject obj = new JSONObject();
        String mobile = request.getParameter("phone");
        String loginPass = request.getParameter("newPasswd");
        String code = request.getParameter("phoneCode");
        obj.put("phone", mobile);//
        obj.put("passwd", MD5.enCodeStandard(loginPass.trim()));//
        obj.put("valid_code", code);//

        request.setAttribute("errorLinkValue", 555);
        request.setAttribute("msg", "重置失败,稍后重试");
        request.setAttribute("code", -1);
        if (StringUtils.isEmpty(mobile) || StringUtils.isEmpty(loginPass)) {
            request.setAttribute("msg", "缺少重置参数");
        } else {
            ResultBean resultBean = CommonRequst.executeNew(obj, "reset_phone_passwd");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                request.setAttribute("code", 1);
                request.setAttribute("errorLinkValue", 666);
            } else {
                if (null != resultBean) {
                    request.setAttribute("msg", resultBean.getRespDesc());
                }
            }
        }
        return "phone-reset-result";
    }
}
