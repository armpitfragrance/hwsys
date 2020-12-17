package com.servlet;

import com.entity.Message;
import com.entity.MsgUser;
import com.entity.User;
import com.google.gson.Gson;
import com.service.impl.MsgUserServiceImpl;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.ResponseWrapper;
import java.io.IOException;
import java.util.List;

/**
 * 作者：ysq
 * 日期: 2020/12/14 10:29
 * 描述:
 */
@WebServlet("/Message.do")
public class MessageServlet extends BaseServlet {
    MsgUserServiceImpl msgUserService = new MsgUserServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    public void queryPage(HttpServletRequest request, HttpServletResponse response) throws IOException {

        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        Integer receive_id = Integer.valueOf(request.getParameter("receive_id"));
//        Page<MsgUser> page = noticeService.queryByPage(pageNo, Page.PAGE_SIZE);
//        Gson gson = new Gson();
//        String JsonStr = gson.toJson(page);
//        response.getWriter().write(JsonStr);
    }

    public void query(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer receive_id = Integer.valueOf(request.getParameter("receive_id"));
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        String send_name = request.getParameter("send_name");
        String date = request.getParameter("date");
        Page<MsgUser> page = null;
        if (!request.getParameter("readFlag").equals("")) {
            String readFlag = request.getParameter("readFlag");
            page = msgUserService.conditionQueryMessage(receive_id, readFlag, send_name, date, pageNo, Page.PAGE_SIZE);
        } else {
            page = msgUserService.conditionQueryMessage(receive_id, send_name, date, pageNo, Page.PAGE_SIZE);
        }

        Gson gson = new Gson();
        String JsonStr = gson.toJson(page);
        response.getWriter().write(JsonStr);
    }

    public void send(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        Notice notice = new Notice();
        MsgUser message = new MsgUser();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
//        receive_no: receive_no,send_id:user_id, type: type,title:title,content:content
        Integer receive_id = Integer.valueOf(request.getParameter("receive_id"));
        Integer send_id = Integer.valueOf(request.getParameter("send_id"));
        message.setTitle(title);
        message.setContent(content);
        message.setReceive_id(receive_id);
        message.setSend_id(send_id);
        message.setReadFlag("0");
//        System.out.println(message);
        String result = String.valueOf(msgUserService.insert(message));
//        System.out.println(result);
        response.getWriter().write(result);
//        notice.setContent(content);
//        int result = noticeService.insert(notice);

    }


    public void rcvsearch(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        String receive_no = request.getParameter("receive_no");
        String type = request.getParameter("type");
        System.out.println(receive_no);
        System.out.println(type);
        User user = null;
        if ("stu".equals(type)) {
            user = msgUserService.queryStudent(receive_no);
        } else if("t".equals(type)){
            user = msgUserService.queryTeacher(receive_no);
        }
        System.out.println(user);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(user);
        response.getWriter().write(JsonStr);
        System.out.println(JsonStr);
    }

//    public void rcvNoQuery(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        request.setCharacterEncoding("utf-8");
//        response.setContentType("text/html;charset=UTF-8");
//        String receive_id = request.getParameter("receive_id");
//        String receive_name = request.getParameter("receive_name");
//        System.out.println(receive_id + receive_name);
//        String No = msgUserService.queryUserNo(receive_id, receive_name);
//        System.out.println(No);
//        Gson gson = new Gson();
//        String JsonStr = gson.toJson(No);
//        response.getWriter().write(JsonStr);
//    }

    public void back(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("view/user/teacher/Message.jsp");

    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int result = 0;
//        获取要删除的公告的id
        Integer messageId = Integer.valueOf(request.getParameter("messageId"));
        result = msgUserService.delete(messageId);

        response.getWriter().write("" + result);

    }

    public void queryForOne(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        Integer id = Integer.valueOf(request.getParameter("id"));
//        Notice notice = noticeService.queryNoticeById(id);
//        Gson gson = new Gson();
//        String JsonStr = gson.toJson(notice);
//        response.getWriter().write(JsonStr);
    }
}
