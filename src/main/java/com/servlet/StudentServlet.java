package com.servlet;

import com.dao.StudentDao;
import com.entity.Student;
import com.entity.User;
import com.entity.UserStudent;
import com.google.gson.Gson;
import com.service.StudentService;
import com.service.UserService;
import com.service.UserStudentService;
import com.service.impl.StudentServiceImpl;
import com.service.impl.UserServiceImpl;
import com.service.impl.UserStudentServiceImpl;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 15:41
 * 描述:
 */
@WebServlet("/student.do")
public class StudentServlet extends BaseServlet {
    StudentService studentService = new StudentServiceImpl();
    UserStudentService userStudentService = new UserStudentServiceImpl();
    UserService userService = new UserServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }
    public void queryPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        Integer pageNum = Integer.valueOf(req.getParameter("pageNum"));
        Page<UserStudent> page = userStudentService.queryForPage(pageNum, Page.PAGE_SIZE);
        Gson gson = new Gson();
        String jsonStr = gson.toJson(page);
        resp.getWriter().write(jsonStr);
    }
    public void deleteStu(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer user_id = Integer.valueOf(req.getParameter("user_id"));
        Integer result1 = studentService.deleteByUserId(user_id);
        Integer result2 = userService.delete(user_id);
        String result;
        if (result1 > 0 && result2 > 0) {
            result = "1";
        } else {
            result = "-1";
        }

        resp.getWriter().write(result);
    }
    public void addStu(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String type = req.getParameter("type");
        String realname = req.getParameter("realname");
        Integer stu_no = Integer.valueOf(req.getParameter("stu_no"));
        String psw = req.getParameter("psw");
        String sex = req.getParameter("sex");
        Integer age = Integer.valueOf(req.getParameter("age"));
        String classname = req.getParameter("classname");
        User user = new User(type, psw, realname, sex, age);
        Integer result1 = userService.insert(user);
        Integer user_id = userService.getMaxId();
        Student student = new Student(user_id, stu_no, classname);
        Integer result2 =studentService.insert(student);
        String result;
        if (result1 > 0 && result2 > 0) {
            result = "1";
        } else {
            result = "-1";
        }

        resp.getWriter().write(result);
    }
    public void updateStu(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        Integer id = Integer.valueOf(req.getParameter("id"));
        Integer user_id = Integer.valueOf(req.getParameter("user_id"));
        String type = req.getParameter("type");
        String realname = req.getParameter("realname");
        Integer stu_no = Integer.valueOf(req.getParameter("stu_no"));
        String psw = req.getParameter("psw");
        String sex = req.getParameter("sex");
        Integer age = Integer.valueOf(req.getParameter("age"));
        String classname = req.getParameter("classname");
        User user = new User(user_id,type, psw, realname, sex, age);
        Integer result1 = userService.update(user);
//        Integer user_id = userService.getMaxId();
        Student student = new Student(id,user_id, stu_no, classname);
        Integer result2 =studentService.update(student);
        String result;
        if (result1 > 0 && result2 > 0) {
            result = "1";
        } else {
            result = "-1";
        }

        resp.getWriter().write(result);
    }
    public void query(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        Integer pageNum = Integer.valueOf(req.getParameter("pageNum"));
        String realname = req.getParameter("realname");
        String stu_no = req.getParameter("stu_no");
        System.out.println(realname+" "+stu_no);
        Page<UserStudent> page=userStudentService.queryUserStudentByPageByRealNameOrStuNo(pageNum, Page.PAGE_SIZE, realname, stu_no);
        Gson gson = new Gson();
        String jsonStr = gson.toJson(page);
        System.out.println(jsonStr);
        resp.getWriter().write(jsonStr);



    }
}
