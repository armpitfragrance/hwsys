package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

/**
 * 作者：youjiahao
 * 日期: 2020/12/1 19:15
 * 描述:
 */
@WebServlet("/download.do")
public class FileDownloadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getParameter("path");
        download(request, response, path);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    //下载文件
    private void download(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
        request.setCharacterEncoding("utf-8");
        String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
        //防止中文乱码
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        //设置相应类型为图片
        response.setContentType("application/octet-stream");
        String agent = request.getHeader("User-Agent");
        if(agent.toLowerCase().indexOf("chrome")>0)
        {
            response.addHeader("content-Disposition", "attachment;filename="+new String(path.getBytes("UTF-8"), "ISO8859-1"));
        }
        else
        {
            response.addHeader("content-Disposition", "attachment;filename="+URLEncoder.encode(path, "UTF-8"));
        }
        //读取工程资源
        System.out.println(""+path);
        File file=new File("D://upload//",""+path);
        if(file.exists()){
            System.out.println("1");
        }
        InputStream fileIn=new FileInputStream(file);
        InputStream in=new BufferedInputStream(fileIn);
        OutputStream out=response.getOutputStream();
        byte[] buff=new byte[1024];
        int len=0;
        while((len=in.read(buff))>-1){
            out.write(buff,0,len);
            out.flush();
        }
        out.close();
        in.close();
        fileIn.close();
    }
}
