package com.servlet;

import com.entity.Notice;
import com.google.gson.Gson;
import com.service.NoticeService;
import com.service.impl.NoticeServiceImpl;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 作者：youjiahao
 * 日期: 2020/12/10 15:42
 * 描述:
 */
@WebServlet("/notice.do")
public class NoticeServlet extends BaseServlet {
    NoticeService noticeService = new NoticeServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    public void queryPage(HttpServletRequest request, HttpServletResponse response) throws IOException {

        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));

        Page<Notice> page = noticeService.queryByPage(pageNo, Page.PAGE_SIZE);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(page);
        response.getWriter().write(JsonStr);
    }

    public void search(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String time = request.getParameter("time");
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        Page<Notice> page = noticeService.queryByTitleAndTimeAndPage(title, time, pageNo, Page.PAGE_SIZE);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(page);
        response.getWriter().write(JsonStr);
    }

    public void insert(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Notice notice = new Notice();
        String title = request.getParameter("addtitle");
        String content = request.getParameter("addcontent");

        notice.setTitle(title);
        notice.setContent(content);
        int result = noticeService.insert(notice);
        response.getWriter().write("" + result);

    }

    public void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Notice notice = new Notice();
        Integer id = Integer.valueOf(request.getParameter("updateid"));
        String title = request.getParameter("updatetitle");
        String content = request.getParameter("updatecontent");

        notice.setId(id);
        notice.setTitle(title);
        notice.setContent(content);
        int result = noticeService.update(notice);
        response.getWriter().write("" + result);
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int result = 0;
        //获取要删除的公告的id
//        if(null!=request.getParameter("id")&&!"".equals(request.getParameter("id"))){
//        }
        Integer id = Integer.valueOf(request.getParameter("id"));
        result = noticeService.delete(id);

        response.getWriter().write("" + result);

    }

    public void queryForOne(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        Notice notice = noticeService.queryNoticeById(id);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(notice);
        response.getWriter().write(JsonStr);
    }
}
