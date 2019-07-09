package com.yufan.vo.req;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 创建人: lirf
 * 创建时间:  2017-12-28 15:27
 * 功能介绍: 用户信息表
 */
public class UserInfoVo {

    @JSONField(name = "nick_name")
    private String nickName;

    @JSONField(name = "login_name")
    private String loginName;

    @JSONField(name = "user_mobile")
    private String userMobile;

    @JSONField(name = "user_id")
    private Integer userId;

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getUserMobile() {
        return userMobile;
    }

    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
