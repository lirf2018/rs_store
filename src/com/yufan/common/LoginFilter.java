package com.yufan.common;

import com.yufan.util.RsConstants;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * 创建人: lirf
 * 创建时间:  2017-12-28 10:52
 * 功能介绍:
 */
public class LoginFilter extends OncePerRequestFilter {
    private final Logger LOG = Logger.getLogger(OncePerRequestFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // 请求的uri
        String uri = request.getRequestURI();
//        System.out.println("LoginFilter----->"+uri);
        // 不过滤的uri static
        String[] notFilterStatic = new String[]{"/css/", "/js/", "/img/", "/iconfont/", "/slick/", "/fonts/", "image.image", "/weixin"};
        for (int i = 0; i < notFilterStatic.length; i++) {
            String notFilterPage = notFilterStatic[i];
            if (uri.indexOf(notFilterPage) >= 0) {
                filterChain.doFilter(request, response);
                return;
            }
        }
        // 不过滤的uri Action
        String[] notFilter = new String[]{"favicon.ico", "user/loginPage", "user/login", "user/login/phoneRegister", "user/login/phoneResetPassWd", "ajax/phone/generatePhoneCode", "ajax/check/allCode", "user/login/phoneRegisterResult", "user/login/phoneResetPdResult"};
        for (int i = 0; i < notFilter.length; i++) {
            String notFilterPage = notFilter[i];
            if (uri.endsWith(notFilterPage)) {
                filterChain.doFilter(request, response);
                return;
            }
        }

        //登录请求页面
        Object userInfoVo = request.getSession().getAttribute("userInfoVo");
        if (null == userInfoVo) {
            String loginPage = request.getContextPath() + RsConstants.INTERCEPT_URL;
            //保存请求前两次的地址
            request.getSession().setAttribute("beforeUrl", loginPage + "?beforeUrl=" + uri);
            response.sendRedirect(loginPage);
            return;
        } else {
            request.getSession().removeAttribute("goodsInfoPageUrl");
        }
        if (uri.endsWith(".jsp") || uri.indexOf("/jsp/") >= 0 && StringUtils.equals(request.getMethod(), "GET")) {
            LOG.info("---------->过滤非法请求");
            // 如果session中不存在登录者实体，则弹出框提示重新登录
            // 设置request和response的字符集，防止乱码
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            String loginPage = request.getContextPath() + RsConstants.INTERCEPT_URL;
            StringBuilder builder = new StringBuilder();
            builder.append("<script type=\"text/javascript\">");
            builder.append("alert('登录过期，请重新登录！');");
            builder.append("window.top.location.href='");
            builder.append(loginPage);
            builder.append("';");
            builder.append("</script>");
            out.print(builder.toString());
            return;
        }

        if (uri.endsWith("/")) {
            String mainPage = request.getContextPath() + RsConstants.RS_MAIN_URL;
            response.sendRedirect(mainPage);
            return;
        }
        // 如果uri中不包含background，则继续
        filterChain.doFilter(request, response);
    }
}
