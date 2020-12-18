package com.servlet;

import com.entity.SC;
import com.entity.SCCTStu;
import com.google.gson.Gson;
import com.service.CourseService;
import com.service.SCService;
import com.service.TCService;
import com.service.impl.CourseServiceImpl;
import com.service.impl.SCCTStuServiceImpl;
import com.service.impl.SCServiceImpl;
import com.service.impl.TCServiceImpl;
import com.sun.xml.internal.bind.v2.TODO;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/**
 * 作者：ysq
 * 日期: 2020/12/10 15:41
 * 描述:
 */
@WebServlet("/SC.do")
public class CourseInfoServlet extends BaseServlet {
    SCCTStuServiceImpl scctStuService = new SCCTStuServiceImpl();
    TCService tcService = new TCServiceImpl();
    SCService scService = new SCServiceImpl();
    CourseService courseService = new CourseServiceImpl();

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
    public void queryNoPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String t_no = request.getParameter("t_no");
//        System.out.println(name);
//        System.out.println(t_no);
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        Page<SCCTStu> userPage = scctStuService.queryByPageByNameorTid(name, t_no, pageNo, 200);
        Gson gson = new Gson();
        String gsonStr = gson.toJson(userPage);
        response.getWriter().write(gsonStr);

    }
    public void querySC(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String stu_no = request.getParameter("stu_no");
        String stu_id = request.getParameter("stu_id");
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        Page<SCCTStu> userPage = scctStuService.queryByPageByNameorStuId(name, stu_id, pageNo, 200);
        Gson gson = new Gson();
        String gsonStr = gson.toJson(userPage);
        response.getWriter().write(gsonStr);
    }
    //课程管理页面的删除，如果之后管理员界面的课程管理删除出问题就用这个
    public void deleteSCCTStu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        Integer tc_id = Integer.valueOf(request.getParameter("tc_id"));
        Integer c_id = tcService.queryTCById(tc_id).getC_id();//用于删除course,sc表中的课程
        Integer result1 = tcService.deleteByTCId(tc_id);
        Integer result2 = scService.deleteByCId(c_id);
        Integer result3 = courseService.deleteById(c_id);
//        System.out.println(result1);
//        System.out.println(result2);
//        System.out.println(result3);
        String result;
        if (result1 > 0 && result3 > 0) {
            result = "1";
        } else {
            result = "-1";
        }

        response.getWriter().write(result);








    }
    public void addSC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        Integer tc_id = Integer.valueOf(request.getParameter("tc_id"));
        Integer c_id = tcService.queryTCById(tc_id).getC_id();//用于添加sc表中的信息
        Integer stu_id = Integer.valueOf(request.getParameter("stu_id"));//todo 前端传入
        SC sc = new SC();
        sc.setC_id(c_id);
        sc.setStu_id(stu_id);

        Integer result2 = scService.insert(sc);
        String result;
        if (result2 >0) {
            result = "1";
        } else {
            result = "-1";
        }
        response.getWriter().write(result);
    }
    public void deleteSC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset:utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        Integer tc_id = Integer.valueOf(request.getParameter("tc_id"));
        Integer c_id = tcService.queryTCById(tc_id).getC_id();//用于删除course,sc表中的课程
        Integer stu_id = Integer.valueOf(request.getParameter("stu_id"));//todo 前端传入
        Integer result2 = scService.deleteByCIdAndStuId(c_id,stu_id);
        String result;
        if (result2 >0) {
            result = "1";
        } else {
            result = "-1";
        }
        response.getWriter().write(result);
    }
    public void back(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("view/user/student/StuCourseManage.jsp");
    }

}
