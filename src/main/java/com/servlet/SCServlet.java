package com.servlet;

import com.entity.SC;
import com.entity.Student;
import com.service.SCService;
import com.service.StudentService;
import com.service.impl.SCServiceImpl;
import com.service.impl.StudentServiceImpl;
import org.testng.annotations.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 作者：youjiahao
 * 日期: 2020/12/14 15:52
 * 描述:
 */
@WebServlet("/sc.do")
public class SCServlet extends BaseServlet {
    StudentService studentService=new StudentServiceImpl();
    SCService scService=new SCServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }
    //添加选课情况
    public void insert(HttpServletRequest request, HttpServletResponse response) throws IOException {
        SC sc=null;
        Integer course_id= Integer.valueOf(request.getParameter("addcourse_id"));
        Integer stu_no= Integer.valueOf(request.getParameter("addstu_no"));

        Student student=studentService.queryStudentByStu_no(stu_no);
        sc=new SC(course_id,student.getId());
        int result=scService.insert(sc);

        response.getWriter().write("" + result);
    }
    //删除选课情况
    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        SC sc=null;
        Integer course_id= Integer.valueOf(request.getParameter("course_id"));
        Integer stu_id= Integer.valueOf(request.getParameter("stu_id"));

        sc=scService.queryByC_idAndStu_id(course_id,stu_id);
        int result=scService.delete(sc.getId());
        response.getWriter().write("" + result);
    }
    //按学号添加学生选课,唯一性判断
    public void unique(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int stu_no= Integer.parseInt(request.getParameter("receive_no"));
        int course_id= Integer.parseInt(request.getParameter("course_id"));
        int result=scService.unique(stu_no,course_id);
        response.getWriter().write(""+result);

    }
}
