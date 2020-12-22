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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Year;

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
        System.out.println(user_no + password + type);
        HttpSession session = request.getSession();
        Gson gson = new Gson();
        if ("admin".equals(type)) {
            System.out.println("admin");
            UserAdminServiceImpl userAdminService = new UserAdminServiceImpl();
            Admin user = userAdminService.Login(user_no, password);
            session.setAttribute("user", user);
//            response.sendRedirect("/adminView.jsp");
            String JsonStr = gson.toJson(user);
            response.getWriter().write(JsonStr);

        } else if ("t".equals(type)) {
            System.out.println("teacher");
            UserTeacherServiceImpl userTeacherService = new UserTeacherServiceImpl();
            UserTeacher user = userTeacherService.teacherLogin(user_no, password);
            session.setAttribute("user", user);
//            response.sendRedirect("/Tindex.jsp");
            session.setMaxInactiveInterval(10);
            String JsonStr = gson.toJson(user);
            response.getWriter().write(JsonStr);

        } else if ("stu".equals(type)) {
            System.out.println("stu");
            UserStudentServiceImpl userStudentService = new UserStudentServiceImpl();
            UserStudent user = userStudentService.Login(user_no, password);
            session.setAttribute("user", user);
            String JsonStr = gson.toJson(user);
            response.getWriter().write(JsonStr);

        }

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
