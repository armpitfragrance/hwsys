package com.servlet;

import com.dao.impl.AdminDaoImpl;
import com.entity.Admin;
import com.entity.UserStudent;
import com.entity.UserTeacher;
import com.google.gson.Gson;
import com.service.impl.TeacherServiceImpl;
import com.service.impl.UserAdminServiceImpl;
import com.service.impl.UserStudentServiceImpl;
import com.service.impl.UserTeacherServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.Year;
import java.util.HashMap;
import java.util.Map;

/**
 * 作者：ysq
 * 日期: 2020/12/17 16:33
 * 描述:
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String user_no = request.getParameter("user_no");
        String password = request.getParameter("password");
        String type = request.getParameter("type");
        String remember = request.getParameter("remember");
        System.out.println(user_no + password + type+remember);

        Gson gson = new Gson();
        if ("admin".equals(type)) {
            System.out.println("admin");
            UserAdminServiceImpl userAdminService = new UserAdminServiceImpl();
            Admin user = userAdminService.Login(user_no, password);
            if ("true".equals(remember)) {
                if (user != null) {
                    Cookie cookie_type = new Cookie("type", type);
                    cookie_type.setMaxAge(60*60);
                    response.addCookie(cookie_type);
                    Cookie cookie_remember = new Cookie("remember", remember);
                    cookie_remember.setMaxAge(60*60);
                    response.addCookie(cookie_remember);
                    Cookie cookie_user_no = new Cookie("user_no", user_no);
                    cookie_user_no.setMaxAge(60*60);
                    response.addCookie(cookie_user_no);
                    Cookie cookie_password = new Cookie("password", password);
                    cookie_password.setMaxAge(60*60);
                    response.addCookie(cookie_password);
                }
            }else{
                Cookie cookie1 = getCookieByName(request, "type");
                if (cookie1 != null) {
                    cookie1.setMaxAge(0);
                    response.addCookie(cookie1);
                }

                Cookie cookie2 = getCookieByName(request, "remember");
                if (cookie2 != null) {
                    cookie2.setMaxAge(0);
                    response.addCookie(cookie2);
                }
                Cookie cookie3 = getCookieByName(request, "user_no");
                if (cookie3 != null) {
                    cookie3.setMaxAge(0);
                    response.addCookie(cookie3);
                }
                Cookie cookie4 = getCookieByName(request, "password");
                if (cookie4 != null) {
                    cookie4.setMaxAge(0);
                    response.addCookie(cookie4);
                }
            }
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
//            System.out.println("1111"+session.getAttribute("user"));
//            response.sendRedirect("/adminView.jsp");
            String JsonStr = gson.toJson(user);
            response.getWriter().write(JsonStr);

        } else if ("t".equals(type)) {
            System.out.println("teacher");
            UserTeacherServiceImpl userTeacherService = new UserTeacherServiceImpl();
            UserTeacher user = userTeacherService.teacherLogin(user_no, password);
            if ("true".equals(remember)) {
                if (user != null) {
                    Cookie cookie_type = new Cookie("type", type);
                    cookie_type.setMaxAge(60*60);
                    response.addCookie(cookie_type);
                    Cookie cookie_remember = new Cookie("remember", remember);
                    cookie_remember.setMaxAge(60*60);
                    response.addCookie(cookie_remember);
                    Cookie cookie_user_no = new Cookie("user_no", user_no);
                    cookie_user_no.setMaxAge(60*60);
                    response.addCookie(cookie_user_no);
                    Cookie cookie_password = new Cookie("password", password);
                    cookie_password.setMaxAge(60*60);
                    response.addCookie(cookie_password);
                }
            }else{
                Cookie cookie1 = getCookieByName(request, "type");
                if (cookie1 != null) {
                    cookie1.setMaxAge(0);
                    response.addCookie(cookie1);
                }

                Cookie cookie2 = getCookieByName(request, "remember");
                if (cookie2 != null) {
                    cookie2.setMaxAge(0);
                    response.addCookie(cookie2);
                }
                Cookie cookie3 = getCookieByName(request, "user_no");
                if (cookie3 != null) {
                    cookie3.setMaxAge(0);
                    response.addCookie(cookie3);
                }
                Cookie cookie4 = getCookieByName(request, "password");
                if (cookie4 != null) {
                    cookie4.setMaxAge(0);
                    response.addCookie(cookie4);
                }
            }
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
//            response.sendRedirect("/Tindex.jsp");
            session.setMaxInactiveInterval(10);
            String JsonStr = gson.toJson(user);
            response.getWriter().write(JsonStr);

        } else if ("stu".equals(type)) {
            System.out.println("stu");
            UserStudentServiceImpl userStudentService = new UserStudentServiceImpl();
            UserStudent user = userStudentService.Login(user_no, password);
            if ("true".equals(remember)) {
                if (user != null) {
                    Cookie cookie_type = new Cookie("type", type);
                    cookie_type.setMaxAge(60*60);
                    response.addCookie(cookie_type);
                    Cookie cookie_remember = new Cookie("remember", remember);
                    cookie_remember.setMaxAge(60*60);
                    response.addCookie(cookie_remember);
                    Cookie cookie_user_no = new Cookie("user_no", user_no);
                    cookie_user_no.setMaxAge(60*60);
                    response.addCookie(cookie_user_no);
                    Cookie cookie_password = new Cookie("password", password);
                    cookie_password.setMaxAge(60*60);
                    response.addCookie(cookie_password);
                }
            }else{
                Cookie cookie1 = getCookieByName(request, "type");
                if (cookie1 != null) {
                    cookie1.setMaxAge(0);
                    response.addCookie(cookie1);
                }

                Cookie cookie2 = getCookieByName(request, "remember");
                if (cookie2 != null) {
                    cookie2.setMaxAge(0);
                    response.addCookie(cookie2);
                }
                Cookie cookie3 = getCookieByName(request, "user_no");
                if (cookie3 != null) {
                    cookie3.setMaxAge(0);
                    response.addCookie(cookie3);
                }
                Cookie cookie4 = getCookieByName(request, "password");
                if (cookie4 != null) {
                    cookie4.setMaxAge(0);
                    response.addCookie(cookie4);
                }
            }
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            String JsonStr = gson.toJson(user);
            response.getWriter().write(JsonStr);

        }

    }
    public static Cookie getCookieByName(HttpServletRequest request, String name) {
        Map<String, Cookie> cookieMap = ReadCookieMap(request);
        if (cookieMap.containsKey(name)) {
            Cookie cookie = (Cookie) cookieMap.get(name);
            return cookie;
        } else {
            return null;
        }
    }
    private static Map<String, Cookie> ReadCookieMap(HttpServletRequest request) {
        Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
        Cookie[] cookies = request.getCookies();
        if (null != cookies) {
            for (Cookie cookie : cookies) {
                cookieMap.put(cookie.getName(), cookie);
            }
        }
        return cookieMap;
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void adminLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_no = request.getParameter("user_no");
        String password = request.getParameter("password");
    }
    protected void teacherLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_no = request.getParameter("user_no");
        String password = request.getParameter("password");
    }
    protected void studentLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user_no = request.getParameter("user_no");
        String password = request.getParameter("password");
    }


}
