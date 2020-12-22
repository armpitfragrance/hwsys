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
        String type = FileUtil.getFileSufix(path);
        if (type.equals("pdf")) {
            String local = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + "/upload/" + filename + ".pdf";
            response.getWriter().write(local);
        } else if (type.equals("mp4")) {
            String local = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + "/upload/" + filename + ".mp4";
            response.getWriter().write(local);
        } else {
            String pdfpath = "c:\\transpdf\\" + filename;
            if (File2Pdf.convertToPdfAsAspose(filepath, pdfpath + ".pdf")) {
                String local = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + "/transpdf/" + filename + ".pdf";
                System.out.println(local);
                response.getWriter().write(local);
            } else {
                response.getWriter().write("");
            }
        }

    }
}
