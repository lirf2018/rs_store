package com.yufan.util;


/**
 * 创建人: lirf
 * 创建时间:  2017-11-15 10:53
 * 功能介绍: 常量
 */
public class RsConstants {

    /**
     * 系统拦截跳转地址,登录页面
     * loginWXMsg: 失败描述
     * msgType: 1:微信登录失败/微信授权失败
     */
    public static String INTERCEPT_URL = "/user/loginPage";

    /**
     * 用户中心
     */
    public static String USER_CENTER_URL = "/center/userCenter";


    /**
     * 用户main
     */
    public static String RS_MAIN_URL = "/index/main";

    /**
     * 用户main
     * boundWXMsg:结果描述
     * msgType:1 微信绑定成功(boundWXMsg)/微信绑定失败(boundWXMsg)/微信授权失败(boundWXMsg)
     */
    public static String RS_SETTING_URL = "/center/settingPage";


    public static String WX_APPID = "wx0bdabad84b781956";
    public static String WX_SECRET = "fc25df579812bbc6d80ac74d1198cb6f";


//    /**
//     *
//     */
//    public static String BOUND_WX_SUCCESS = "微信绑定成功";
//    public static String BOUND_WX_FAIL = "微信绑定失败";

}
