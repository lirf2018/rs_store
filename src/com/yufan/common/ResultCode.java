package com.yufan.common;

/**
 * 创建人: lirf
 * 创建时间:  2017-12-29 13:34
 * 功能介绍:
 */
public enum ResultCode {
    OK(1, "成功"),
    NET_ERROR(1000, "网络请求失败,请稍后重试"),
    FAIL_LOGIN_ERROR(1001, "登录失败,请稍后重试"),
    LOGIN_DATA_NOT_NULL(1002, "手机号和密码不能为空");

    private int respCode;
    private String respDesc;

    private ResultCode(int respCode, String respDesc) {
        this.respCode = respCode;
        this.respDesc = respDesc;
    }

    /**
     * 获取编码
     *
     * @return
     */
    public int getRespCode() {
        return respCode;
    }

    /**
     * 获取描述值
     *
     * @return
     */
    public String getRespDesc() {
        return respDesc;
    }

    public static String getRespDesc(int respCode) {
        String dt = "";
        for (ResultCode ac : ResultCode.values()) {
            if (ac.respCode == respCode) {
                dt = ac.getRespDesc();
                break;
            }
        }
        return dt;
    }

}
