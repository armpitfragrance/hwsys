package com.servlet;

import com.entity.Course;
import com.entity.TC;
import com.service.CourseService;
import com.service.TCService;
import com.service.impl.CourseServiceImpl;
import com.service.impl.TCServiceImpl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * 作者：Zhh
 * 日期: 2020/12/14 15:03
 * 描述:
 */
@WebServlet("/updatecourse.do")
public class UpdateCourseServlet extends HttpServlet {
    CourseService courseService = new CourseServiceImpl();
    TCService tcService = new TCServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        Course course = new Course();
        TC tc = new TC();
        String oldImage = "";
        if (ServletFileUpload.isMultipartContent(req)) {
            //创建FileItemFactory   工厂实现类
            FileItemFactory fileItemFactory = new DiskFileItemFactory();
            //创建用于解析上传数据的工具类
            ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
            List<FileItem> list = null;
            try {
                list = servletFileUpload.parseRequest(req);
                for (FileItem fileItem : list) {
                    if (fileItem.isFormField()) {
                        //普通表单项
                        //对普通表单项的操作
                        String str = fileItem.getFieldName();
                        switch (str) {
                            case "tc_id":
                                Integer tc_id = Integer.valueOf(fileItem.getString());
                                tc.setId(tc_id);

//                            new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
                                Integer c_id = tcService.queryTCById(tc_id).getC_id();
                                tc.setC_id(c_id);
                                course.setId(c_id);

                                oldImage = courseService.queryById(c_id).getPath();
                                break;

                            case "t_id":
                                Integer t_id = Integer.valueOf(fileItem.getString());
//                            new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
                                tc.setT_id(t_id);
                                System.out.println(tc.getT_id());
                                break;
                            case "c_name":
                                String c_name = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
                                course.setName(c_name);
                                System.out.println(course.getName());
                                break;
                        }
                    } else {
                        //上传的文件

                        if (!fileItem.getName().equals("")) {
                            StringBuilder sb = new StringBuilder("C:\\upload\\");
                            sb.append(new Date().getTime());
                            sb.append(fileItem.getName());
                            String imgpath = sb.toString();
                            course.setPath(imgpath);
                            fileItem.write(new File(imgpath));
                        } else {
                            course.setPath(oldImage);
                        }
                    }
                }
                Integer result2 = courseService.update(course);
//                Integer c_id = courseService.getMaxId();
//                tc.setC_id(c_id);
                Integer result1 = tcService.update(tc);
                String result;
                if (result1 > 0 && result2 > 0) {
                    result = "1";
                } else {
                    result = "-1";
                }
                resp.getWriter().write(result);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
