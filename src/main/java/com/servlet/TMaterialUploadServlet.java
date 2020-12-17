package com.servlet;

import com.entity.Homework;
//import com.service.HomeworkService;
//import com.service.impl.HomeworkServiceImpl;
import com.entity.TMaterial;
import com.service.impl.TMaterialServiceImpl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/15 18:34
 * 描述:
 */
@WebServlet("/tMaterialUpload.do")
public class TMaterialUploadServlet extends HttpServlet {
    TMaterialServiceImpl tMaterialService = new TMaterialServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        resp.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");
        String action = null;
        if (ServletFileUpload.isMultipartContent(req)) {
            FileItemFactory fileItemFactory = new DiskFileItemFactory();
            ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
            List<FileItem> list = null;

            try {
                list = servletFileUpload.parseRequest(req);
                for (FileItem fileItem : list) {
                    if (fileItem.isFormField()) {
                        String filename = fileItem.getFieldName();
                        if (filename.equals("action")) {
                            action = fileItem.getString();
                            System.out.println(action);
                            TMaterialUpload(req, resp, list);
                        }
                    }
                }

            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    public void TMaterialUpload(HttpServletRequest req, HttpServletResponse resp, List<FileItem> fileItems) throws Exception {
        TMaterial tMaterial = new TMaterial();
        for (FileItem fileItem : fileItems) {
            if (fileItem.isFormField()) {//普通表单数据
                String filename = fileItem.getFieldName();
                String value = fileItem.getString("utf-8");

                switch (filename) {
                    case "course_id":
                        tMaterial.setC_id(Integer.valueOf(value));
                        break;
                }

            } else {//上传的文件
                String imgpath = "";
                if (!fileItem.getName().equals("")) {
                    StringBuffer sb = new StringBuffer("D:\\upload\\");
                    sb.append(fileItem.getName());
                    String imgPath = sb.toString();
                    fileItem.write(new File(imgPath));
                    tMaterial.setName(fileItem.getName());
                    tMaterial.setPath(imgPath);
                }
            }
        }
        int result = tMaterialService.insert(tMaterial);
        System.out.println(result);
        resp.getWriter().write("" + result);
    }
}
