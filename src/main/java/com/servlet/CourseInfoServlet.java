package com.servlet;

import com.entity.SC;
import com.entity.SCCTStu;
import com.google.gson.Gson;
import com.service.impl.SCCTStuServiceImpl;
import com.service.impl.SCServiceImpl;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 作者：ysq
 * 日期: 2020/12/10 15:41
 * 描述:
 */
@WebServlet("/SC.do")
public class CourseInfoServlet extends BaseServlet {
    SCCTStuServiceImpl scctStuService = new SCCTStuServiceImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doPost(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }
    public void queryPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        Page<SCCTStu> userPage = scctStuService.queryByPage(pageNo, Page.PAGE_SIZE);
//        System.out.println(scctStuService.queryByPage(pageNo, Page.PAGE_SIZE));
        Gson gson = new Gson();
        String gsonStr = gson.toJson(userPage);
        response.getWriter().write(gsonStr);
    }
    public void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        System.out.println("insert");
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        System.out.println("delete");
        Integer Id = Integer.valueOf(request.getParameter("userId"));//TODO:修改userId
        String result = String.valueOf(scctStuService.delete(Id));
        response.getWriter().write(result);
    }

    public void query(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String t_no = request.getParameter("t_no");
        System.out.println(name);
        System.out.println(t_no);
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        Page<SCCTStu> userPage = scctStuService.queryByPageByNameorTid(name, t_no, pageNo, Page.PAGE_SIZE);
        Gson gson = new Gson();
        String gsonStr = gson.toJson(userPage);
        response.getWriter().write(gsonStr);

    }

}
