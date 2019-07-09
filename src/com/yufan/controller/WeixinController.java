package com.yufan.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yufan.util.CommonRequst;
import com.yufan.util.ConfigProperty;
import com.yufan.util.ResultBean;
import com.yufan.util.RsConstants;
import com.yufan.vo.req.UserInfoVo;
import com.yufan.weixin.weixin.WeixinDevUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URLEncoder;

/**
 * 创建人: lirf
 * 创建时间:  2018/11/17 15:34
 * 功能介绍:
 */
@Controller
@RequestMapping("/other/")
public class WeixinController {

    private Logger LOG = Logger.getLogger(WeixinController.class);

    /**
     * 微信登录
     *
     * @return
     */
    @RequestMapping("weixin/loginPage")
    public String toWXLoginPage(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("---->第三方(微信)登录");
        try {
            String rsUrl = ConfigProperty.getConfigValue("rs_url");
            String redirect_uri = rsUrl + "/other/weixin/Login";//成功授权后的访问地址地址

            LOG.info("----redirect_uri=" + redirect_uri);
            String redirect_uri_u = URLEncoder.encode(redirect_uri, "utf-8");
            //获取普通token
            String appId = RsConstants.WX_APPID;
            String scope = "snsapi_base";//静默获取
            String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=" + redirect_uri_u + "&response_type=code&scope=" + scope + "&state=STATE#wechat_redirect";
            return "redirect:" + url;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "400";
    }


    /**
     * 微信登录授权成功后回调地址（获取openId）
     *
     * @return
     */
    @RequestMapping("weixin/Login")
    public String weixinLoginResult(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("------------------------授权成功,开始获取openId------------------------");
        int msgType = 1;
        try {
            String message = null;
            message = request.getParameter("message");
            if (null == message || "".equals(message)) {
                message = readStreamParameter(request.getInputStream());
            }
            String code = message;
            LOG.info("-------------message--->" + message);
            if (StringUtils.isEmpty(code)) {
                code = request.getParameter("code");
                LOG.info("-----可经得到---getParameter----code------->" + code);
            }
            if (StringUtils.isEmpty(code)) {
                code = String.valueOf(request.getAttribute("code"));
                LOG.info("-----getAttribute----code------->" + request.getAttribute("code"));
            }
            String openId = request.getSession().getAttribute("openId") == null ? "" : request.getSession().getAttribute("openId").toString();
            //2 第二步：通过code换取网页授权access_token(与基础的access_token不同)
            if (StringUtils.isNotEmpty(code)) {
                JSONObject openidJson = WeixinDevUtils.getInstence().getOpenId2Json(code);
                LOG.info("-----可经得到---access_token--openidJson----->" + openidJson);
                if (null != openidJson && StringUtils.isNotEmpty(openidJson.getString("openid"))) {
                    openId = openidJson.getString("openid");
                }
            }
            if (StringUtils.isEmpty(openId)) {
                LOG.info("获取openId失败");
                request.getSession().setAttribute("loginWXMsg", "授权失败");
                return "redirect:" + request.getContextPath() + RsConstants.INTERCEPT_URL + "?msgType=" + msgType;
            }
            //获取openId成功,调用接口通过微信登录
            JSONObject obj = new JSONObject();
            obj.put("uid", openId);
            obj.put("sns_type", 4);
            obj.put("nick_name", "");
            obj.put("img", "");
            obj.put("phone", "");
            //调用接口登录
            LOG.info("----->调用接口登录");
            ResultBean resultBean = CommonRequst.executeNew(obj, "weixin_login");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                UserInfoVo userInfoVo = JSONObject.toJavaObject(resultBean.getData(), UserInfoVo.class);
                request.getSession().setAttribute("userInfoVo", userInfoVo);
                request.getSession().setAttribute("openId", openId);
                LOG.info("----微信登录成功");

//                String retUrl = (String) request.getSession().getAttribute("beforeUrl");
//                String toUrl = request.getContextPath()+RsConstants.USER_CENTER_URL;
//                String goodsInfoPageUrl = String.valueOf(request.getSession().getAttribute("goodsInfoPageUrl"));//跳转到商品详情页面
//                if (StringUtils.isNotEmpty(goodsInfoPageUrl) && !"null".equals(goodsInfoPageUrl)) {
//                    LOG.info("---------->跳转到商品详情页面");
//                    toUrl = request.getContextPath() + goodsInfoPageUrl;
//                    request.getSession().removeAttribute("goodsInfoPageUrl");
//                } else if (StringUtils.isEmpty(retUrl)) {
//                    toUrl = request.getContextPath() + RsConstants.USER_CENTER_URL;
//                } else {
//                    String[] arrayUrl = retUrl.split("beforeUrl=");
//                    if (arrayUrl.length == 2) {
//                        toUrl = arrayUrl[1];
//                    }
//                }
//                LOG.info("----toUrl--->"+toUrl);
                return "redirect:" + request.getContextPath() + RsConstants.RS_MAIN_URL;
            } else {
                if (null != resultBean) {
                    request.getSession().setAttribute("loginWXMsg", resultBean.getRespDesc());
                } else {
                    request.getSession().setAttribute("loginWXMsg", "微信登录接口请求超时");
                }
                return "redirect:" + request.getContextPath() + RsConstants.INTERCEPT_URL + "?msgType=" + msgType;
            }
        } catch (Exception e) {
            LOG.info("--->", e);
        }
        return "weixin-fail";
    }

    /**
     * 绑定微信授权
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("weixin/toBoundWX")
    public String toBoundWX(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("---->绑定微信授权");
        try {
            String rsUrl = ConfigProperty.getConfigValue("rs_url");
            String redirect_uri = rsUrl + "/other/weixin/bound";//成功授权后的访问地址地址

            LOG.info("----redirect_uri=" + redirect_uri);
            String redirect_uri_u = URLEncoder.encode(redirect_uri, "utf-8");
            //获取普通token
            String appId = RsConstants.WX_APPID;
            String scope = "snsapi_base";//静默获取
            String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=" + redirect_uri_u + "&response_type=code&scope=" + scope + "&state=STATE#wechat_redirect";
            return "redirect:" + url;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "400";
    }

    /**
     * 绑定微信
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("weixin/bound")
    public String boundWeixin(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("------------------------授权成功,开始获取openId------------------------");
        int msgType = 1;
        try {
            String message = null;
            message = request.getParameter("message");
            if (null == message || "".equals(message)) {
                message = readStreamParameter(request.getInputStream());
            }
            String code = message;
            LOG.info("-------------message--->" + message);
            if (StringUtils.isEmpty(code)) {
                code = request.getParameter("code");
                LOG.info("-----可经得到---getParameter----code------->" + code);
            }
            if (StringUtils.isEmpty(code)) {
                code = String.valueOf(request.getAttribute("code"));
                LOG.info("-----getAttribute----code------->" + request.getAttribute("code"));
            }
            String openId = request.getSession().getAttribute("openId") == null ? "" : request.getSession().getAttribute("openId").toString();
            //2 第二步：通过code换取网页授权access_token(与基础的access_token不同)
            if (StringUtils.isNotEmpty(code)) {
                JSONObject openidJson = WeixinDevUtils.getInstence().getOpenId2Json(code);
                LOG.info("-----可经得到---access_token--openidJson----->" + openidJson);
                if (null != openidJson && StringUtils.isNotEmpty(openidJson.getString("openid"))) {
                    openId = openidJson.getString("openid");
                }
            }
            if (StringUtils.isEmpty(openId)) {
                LOG.info("获取openId失败");
                request.getSession().setAttribute("boundWXMsg", "授权失败");
                return "redirect:" + request.getContextPath() + RsConstants.RS_SETTING_URL + "?msgType=" + msgType;
            }

            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = 0;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
            }
            //获取openId成功,调用接口通过微信登录
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            obj.put("sns_type", 4);
            obj.put("uid", openId);
            obj.put("openkey", "");
            obj.put("sns_name", "");
            obj.put("sns_account", "");
            obj.put("sns_img", "");
            ResultBean resultBean = CommonRequst.executeNew(obj, "create_user_sns");
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                LOG.info("----微信绑定成功");
                request.getSession().setAttribute("boundWXMsg", "微信绑定成功");
            } else {
                LOG.info("----微信绑定失败");
                if (null != resultBean) {
                    LOG.info("-->微信绑定失败:" + resultBean.getRespDesc());
                    request.getSession().setAttribute("boundWXMsg", "绑定失败:" + resultBean.getRespDesc());
                } else {
                    request.getSession().setAttribute("boundWXMsg", "绑定失败:绑定接口请求超时");
                }
            }
            return "redirect:" + request.getContextPath() + RsConstants.RS_SETTING_URL + "?msgType=" + msgType;
        } catch (Exception e) {
            LOG.info("--->", e);
        }
        return "404";
    }


    /**
     * 微信解绑授权
     *
     * @param request
     * @param response
     */
    @RequestMapping("weixin/unBoundWXPage")
    public String deleteWXPage(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("---->解绑微信授权");
        try {
            String rsUrl = ConfigProperty.getConfigValue("rs_url");
            String redirect_uri = rsUrl + "/other/weixin/unBound";//成功授权后的访问地址地址

            LOG.info("----redirect_uri=" + redirect_uri);
            String redirect_uri_u = URLEncoder.encode(redirect_uri, "utf-8");
            //获取普通token
            String appId = RsConstants.WX_APPID;
            String scope = "snsapi_base";//静默获取
            String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=" + redirect_uri_u + "&response_type=code&scope=" + scope + "&state=STATE#wechat_redirect";
            return "redirect:" + url;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "400";
    }


    /**
     * 微信解绑回调
     *
     * @param request
     * @param response
     */
    @RequestMapping("weixin/unBound")
    public String wxUnBound(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("------------------------授权成功,开始获取openId------------------------");
        int msgType = 1;
        try {
            String message = null;
            message = request.getParameter("message");
            if (null == message || "".equals(message)) {
                message = readStreamParameter(request.getInputStream());
            }
            String code = message;
            LOG.info("-------------message--->" + message);
            if (StringUtils.isEmpty(code)) {
                code = request.getParameter("code");
                LOG.info("-----可经得到---getParameter----code------->" + code);
            }
            if (StringUtils.isEmpty(code)) {
                code = String.valueOf(request.getAttribute("code"));
                LOG.info("-----getAttribute----code------->" + request.getAttribute("code"));
            }
            String openId = request.getSession().getAttribute("openId") == null ? "" : request.getSession().getAttribute("openId").toString();
            //2 第二步：通过code换取网页授权access_token(与基础的access_token不同)
            if (StringUtils.isNotEmpty(code)) {
                JSONObject openidJson = WeixinDevUtils.getInstence().getOpenId2Json(code);
                LOG.info("-----可经得到---access_token--openidJson----->" + openidJson);
                if (null != openidJson && StringUtils.isNotEmpty(openidJson.getString("openid"))) {
                    openId = openidJson.getString("openid");
                }
            }
            if (StringUtils.isEmpty(openId)) {
                LOG.info("获取openId失败");
                request.getSession().setAttribute("boundWXMsg", "授权失败");
                return "redirect:" + request.getContextPath() + RsConstants.RS_SETTING_URL + "?msgType=" + msgType;
            }

            Object user = request.getSession().getAttribute("userInfoVo");
            Integer userId = 0;
            if (null != user) {
                UserInfoVo userInfoVo = (UserInfoVo) user;
                userId = userInfoVo.getUserId();
            }
            //获取openId成功, 查询用户账号所绑定的微信
            JSONObject obj = new JSONObject();
            obj.put("user_id", userId);
            ResultBean resultBean = CommonRequst.executeNew(obj, "user_bind_list");
            String uid = "";
            if (null != resultBean && resultBean.getRespCode().intValue() == 1) {
                JSONObject result = resultBean.getData();
                request.setAttribute("userMobile", result.getString("phone"));
                JSONArray jsonArray = result.getJSONArray("list_bind");
                for (int i = 0; i < jsonArray.size(); i++) {
                    JSONObject objData = jsonArray.getJSONObject(i);
                    int snsType = objData.getInteger("sns_type");
                    if (snsType == 4) {
                        uid = objData.getString("uid");
                        break;
                    }
                }
                if (StringUtils.isEmpty(openId) || !openId.equals(uid)) {
                    request.getSession().setAttribute("boundWXMsg", "解绑失败:当前绑定与解绑不微信一致");
                } else {
                    //调用接口解绑
                    obj.put("sns_type", 4);
                    ResultBean resultDeletBound = CommonRequst.executeNew(obj, "delete_user_bind");
                    if (null != resultDeletBound && resultDeletBound.getRespCode().intValue() == 1) {
                        request.getSession().setAttribute("boundWXMsg", "解绑成功");
                    } else {
                        if (null != resultDeletBound) {
                            LOG.info("-->微信解绑失败:" + resultDeletBound.getRespDesc());
                            request.getSession().setAttribute("boundWXMsg", "解绑失败:" + resultDeletBound.getRespDesc());
                        } else {
                            request.getSession().setAttribute("boundWXMsg", "解绑失败:解绑请求超时");
                        }
                    }
                }
            } else {
                if (null != resultBean) {
                    LOG.info("-->微信解绑失败:" + resultBean.getRespDesc());
                    request.getSession().setAttribute("boundWXMsg", "解绑失败:" + resultBean.getRespDesc());
                } else {
                    request.getSession().setAttribute("boundWXMsg", "解绑失败:查询当前绑定超时");
                }
            }
            return "redirect:" + request.getContextPath() + RsConstants.RS_SETTING_URL + "?msgType=" + msgType;
        } catch (Exception e) {
            LOG.info("--->", e);
        }
        return "404";
    }

    //====================================================华丽分割线=========================================================================

    /**
     * 从流中读取数据
     *
     * @param in
     * @return
     */
    public String readStreamParameter(ServletInputStream in) {
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(in, "utf-8"));
            String line = null;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != reader) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return buffer.toString();
    }

}
