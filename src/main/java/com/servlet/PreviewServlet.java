package com.servlet;

import com.google.gson.Gson;
import com.utils.File2Pdf;
import com.utils.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

/**
 * 作者：ysq
 * 日期: 2020/12/21 17:37
 * 描述:
 */
@WebServlet("/preview")
public class PreviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getParameter("path");
        preview(request, response, path);
    }

    //下载文件
    private void preview(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");

        System.out.println(""+path);

        File file=new File("C:\\upload\\",""+path);
        String filepath = "C:\\upload\\" + path;

        String filename = FileUtil.getFilePrefix(path);
        String pdfpath = "c:\\transpdf\\" + filename;
//        System.out.println("文件名"+filename);
        if (File2Pdf.convertToPdfAsAspose(filepath, pdfpath + ".pdf")) {
            String local = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + "/transpdf/" + filename + ".pdf";
            // http://localhost:8080/transpdf/2017%E7%BA%A7%E9%9D%9E%E5%B8%88%E5%AE%9E%E4%B9%A0%E6%89%8B%E5%86%8C%EF%BC%88%E4%BF%AE%E6%94%B9%EF%BC%89.pdf
            System.out.println(local);
            response.getWriter().write(local);
        } else {
            response.getWriter().write("");
        }
    }
}
