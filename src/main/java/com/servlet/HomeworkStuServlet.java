package com.servlet;

import com.entity.HomeworkStu;
import com.entity.HomeworkStuManageInfo;
import com.google.gson.Gson;
import com.service.HomeworkStuService;
import com.service.impl.HomeworkStuServiceImpl;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 作者：youjiahao
 * 日期: 2020/12/16 10:08
 * 描述:
 */
@WebServlet("/homeworkstu.do")
public class HomeworkStuServlet extends BaseServlet{
    HomeworkStuService homeworkStuService=new HomeworkStuServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    /**
     * 查询:
     * 1.初始化页面(无条件)
     * 2.按条件查询(if:作业名称、截止日期、评阅状态)
     * @param request
     * @param response
     */
    public void queryHomeworkStuByHwNameAndEndtimeAndStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer pageNum= Integer.valueOf(request.getParameter("pageNum"));
        Integer course_id= Integer.valueOf(request.getParameter("course_id"));
        String homework_name=request.getParameter("hw_name");
        String end_time=request.getParameter("end_time");
        String correct_status=request.getParameter("correct_status");
        if("请选择".equals(correct_status)){
            correct_status="";
        }

        Page<HomeworkStuManageInfo> page=homeworkStuService.queryHomeworkStuByHwNameAndEndtimeAndStatus(pageNum,Page.PAGE_SIZE,course_id,homework_name,end_time,correct_status);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(page);
        response.getWriter().write(JsonStr);
    }

    public void queryForOne(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HomeworkStu homeworkStu = homeworkStuService.queryHomeworkStuById(id);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(homeworkStu);
        response.getWriter().write(JsonStr);
    }

    public void queryPath(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HomeworkStu homeworkStu = homeworkStuService.queryHomeworkStuById(id);
        String docu_name=homeworkStu.getDocu_name();
        response.getWriter().write(docu_name);

    }
}
