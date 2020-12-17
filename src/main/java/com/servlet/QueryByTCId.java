package com.servlet;

import com.dao.TCDao;
import com.dao.impl.TCDaoImpl;
import com.entity.TC;
import com.google.gson.Gson;
import com.service.TCService;
import com.service.impl.TCServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/**
 * 作者：Zhh
 * 日期: 2020/12/17 15:03
 * 描述:
 */
@WebServlet("/TC.do")
public class QueryByTCId extends BaseServlet {
    TCService tcService = new TCServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
    public void queryForOne(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        Integer tc_id = Integer.valueOf(req.getParameter("tc_id"));
        TC tc = tcService.queryTCById(tc_id);
        Gson gson = new Gson();
        String jsonStr = gson.toJson(tc);
        System.out.println(jsonStr);
        resp.getWriter().write(jsonStr);
    }
}
