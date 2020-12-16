package com.servlet;

import com.entity.TMaterial;
import com.google.gson.Gson;
import com.service.TMaterialService;
import com.service.impl.TMaterialServiceImpl;
import com.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 作者：ysq
 * 日期: 2020/12/16 15:58
 * 描述:
 */
@WebServlet("/tMaterial.do")
public class TMaterialServlet extends BaseServlet {
    TMaterialServiceImpl tMaterialService = new TMaterialServiceImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doPost(request, response);
    }

    public void queryTMaterial(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer c_id = Integer.valueOf(request.getParameter("course_id"));
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        String name = request.getParameter("filename");
        String date = request.getParameter("date");
        Page<TMaterial> page = null;
        page = tMaterialService.queryTMaterialByPageByCid(c_id, name, date, pageNo, Page.PAGE_SIZE);
        System.out.println(page);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(page);
        response.getWriter().write(JsonStr);
    }


    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int result = 0;
//        获取要删除的公告的id
        Integer tMaterialId = Integer.valueOf(request.getParameter("tMaterialId"));
        result = tMaterialService.delete(tMaterialId);

        response.getWriter().write("" + result);

    }
}
