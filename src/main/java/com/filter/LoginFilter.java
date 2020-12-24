package com.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 作者：ysq
 * 日期: 2020/12/22 15:40
 * 描述:
 */

public class LoginFilter implements javax.servlet.Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        // TODO Auto-generated method stub
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession();
        // 如果session不为空，则可以浏览其他页面
        String url = request.getServletPath();
        System.out.println(url);
        //这里判断目录，后缀名，当然也可以写在web.xml中，用url-pattern进行拦截映射
        if ((!request.getServletPath().equals("/index.jsp"))
        &&(!request.getServletPath().equals("/error.jsp"))&&
                (!request.getServletPath().equals("/download.do"))) {
            if (session.getAttribute("user") == null) {
                session.invalidate();
                response.sendRedirect("../../../error.jsp");
            } else {
                chain.doFilter(request, response);
            }
        } else {
            chain.doFilter(request, response);
        }

    }

    public void destroy() {
        // TODO Auto-generated method stub

    }


}
