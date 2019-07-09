package com.yufan.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 创建人: lirf
 * 创建时间:  2018/8/1 10:16
 * 功能介绍:
 */
public class ComonMethod {

    private volatile static ComonMethod comonMethod;

    public static ComonMethod getInstence() {

        if (null == comonMethod) {
            synchronized (ComonMethod.class) {
                if (null == comonMethod) {
                    comonMethod = new ComonMethod();
                }
            }
        }

        return comonMethod;
    }

    public boolean isMobileNO(String mobiles) {
        Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
        Matcher m = p.matcher(mobiles);
        return m.matches();

    }
}
