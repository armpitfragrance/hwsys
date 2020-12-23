package com.servlet;

import com.entity.Teacher;
import com.entity.User;
import com.entity.UserTeacher;
import com.google.gson.Gson;
import com.service.TeacherService;
import com.service.UserService;
import com.service.UserTeacherService;
import com.service.impl.TeacherServiceImpl;
import com.service.impl.UserServiceImpl;
import com.service.impl.UserTeacherServiceImpl;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:32
 * 描述:
 */
@WebServlet("/teacher.do")
public class TeacherServlet extends BaseServlet {
    TeacherService teacherService = new TeacherServiceImpl();
    UserTeacherService userTeacherService = new UserTeacherServiceImpl();
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
        Page<UserTeacher> page = userTeacherService.queryForPage(pageNum, Page.PAGE_SIZE);
        Gson gson = new Gson();
        String jsonStr = gson.toJson(page);
        resp.getWriter().write(jsonStr);
    }

    public void deleteT(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer user_id = Integer.valueOf(req.getParameter("user_id"));
        Integer result1 = teacherService.deleteByUserId(user_id);
        Integer result2 = userService.delete(user_id);
        String result;
        if (result1 > 0 && result2 > 0) {
            result = "1";
        } else {
            result = "-1";
        }

        resp.getWriter().write(result);
    }

    public void addT(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String result;
        int verifytno = Integer.parseInt(req.getParameter("verifytno"));
        String type = req.getParameter("type");
        String realname = req.getParameter("realname");
        Integer t_no = Integer.valueOf(req.getParameter("t_no"));
        String psw = req.getParameter("psw");
        String sex = req.getParameter("sex");
        Integer age = Integer.valueOf(req.getParameter("age"));

        if (verifytno == 1) {
            result = "2";
        } else {
            User user = new User(type, psw, realname, sex, age);
            Integer result1 = userService.insert(user);
            Integer user_id = userService.getMaxId();
            Teacher teacher = new Teacher(user_id, t_no);
            Integer result2 = teacherService.insert(teacher);
            if (result1 > 0 && result2 > 0) {
                result = "1";
            } else {
                result = "-1";
            }
        }
        System.out.println(result);
        resp.getWriter().write(result);
    }

    public void updateT(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String result;
        int verifytno = Integer.parseInt(req.getParameter("verifytno"));
        Integer id = Integer.valueOf(req.getParameter("id"));
        UserTeacher userTeacher = userTeacherService.queryByTId(id);
        Integer user_id = Integer.valueOf(req.getParameter("user_id"));
        String type = req.getParameter("type");
        String realname = req.getParameter("realname");
        Integer t_no = Integer.valueOf(req.getParameter("t_no"));
        String psw = req.getParameter("psw");
        String sex = req.getParameter("sex");
        Integer age = Integer.valueOf(req.getParameter("age"));

        if ((userTeacher.getT_no()!= t_no) && verifytno == 1) {
            result = "2";
        } else {
            User user = new User(user_id, type, psw, realname, sex, age);
            Integer result1 = userService.update(user);
//        Integer user_id = userService.getMaxId();
            Teacher teacher = new Teacher(id, user_id, t_no);
            Integer result2 = teacherService.update(teacher);
            if (result1 > 0 && result2 > 0) {
                result = "1";
            } else {
                result = "-1";
            }
        }


        resp.getWriter().write(result);
    }

    public void query(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        Integer pageNum = Integer.valueOf(req.getParameter("pageNum"));
        String realname = req.getParameter("realname");
        String t_no = req.getParameter("t_no");
        System.out.println(realname + " " + t_no);
        Page<UserTeacher> page = userTeacherService.queryUserStudentByPageByRealNameOrStuNo(pageNum, Page.PAGE_SIZE, realname, t_no);
        Gson gson = new Gson();
        String jsonStr = gson.toJson(page);
        System.out.println(jsonStr);
        resp.getWriter().write(jsonStr);
    }

    public void queryOne(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        Integer t_id = Integer.valueOf(req.getParameter("t_id"));
        UserTeacher userTeacher = userTeacherService.queryByTId(t_id);
        Gson gson = new Gson();
        String jsonStr = gson.toJson(userTeacher);
        System.out.println(jsonStr);
        resp.getWriter().write(jsonStr);
    }

    //工号唯一性判断
    public void unique(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int t_no = Integer.parseInt(request.getParameter("t_no"));
        int result = teacherService.unique(t_no);
        response.getWriter().write("" + result);
    }
}
