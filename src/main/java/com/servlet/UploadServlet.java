package com.servlet;

import com.entity.Homework;
import com.entity.HomeworkStu;
import com.service.HomeworkService;
import com.service.HomeworkStuService;
import com.service.impl.HomeworkServiceImpl;
import com.service.impl.HomeworkStuServiceImpl;
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
import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/15 18:34
 * 描述:
 */
@WebServlet("/upload.do")
public class UploadServlet extends HttpServlet {
    HomeworkService homeworkService = new HomeworkServiceImpl();
    HomeworkStuService homeworkStuService=new HomeworkStuServiceImpl();

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
                            switch (action) {
                                case "homework-action-insert":
                                    HomeworkManageInsert(req, resp, list);
                                    break;
                                case "homework-action-update":
                                    HomeworkManageUpdate(req, resp, list);
                                    break;
                                case "homework-stu-action-update":
                                    HomeworkStuManageUpdate(req, resp, list);
                                    break;
                            }
                        }
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    public void HomeworkManageInsert(HttpServletRequest req, HttpServletResponse resp, List<FileItem> fileItems) throws Exception {
        Homework homework = new Homework();
        for (FileItem fileItem : fileItems) {
            if (fileItem.isFormField()) {//普通表单数据
                String filename = fileItem.getFieldName();
                String value = fileItem.getString("utf-8");
                switch (filename) {
                    case "addname":
                        homework.setName(value);
                        break;
                    case "addt_id":
                        homework.setT_id(Integer.valueOf(value));
                        break;
                    case "addcourse_id":
                        homework.setC_id(Integer.valueOf(value));
                        break;
                    case "addend_time":
                        homework.setEnd_time(value);
                        break;
                }
            } else {//上传的文件
                String imgpath = "";
                if (!fileItem.getName().equals("")) {
                    StringBuffer sb = new StringBuffer("C:\\upload\\");
                    sb.append(fileItem.getName());
                    String imgPath = sb.toString();
                    fileItem.write(new File(imgPath));
                    homework.setDocu_name(fileItem.getName());
                    homework.setPath(imgPath);
                }
            }
        }
        int result = homeworkService.insert(homework);
        System.out.println(result);
        resp.getWriter().write("" + result);
    }

    public void HomeworkManageUpdate(HttpServletRequest req, HttpServletResponse resp, List<FileItem> fileItems) throws Exception {
        Homework homework = new Homework();
        for (FileItem fileItem : fileItems) {
            if (fileItem.isFormField()) {//普通表单数据
                String filename = fileItem.getFieldName();
                String value = fileItem.getString("utf-8");
                switch (filename) {
                    case "updateid":
                        homework.setId(Integer.valueOf(value));
                        break;
                    case "updatename":
                        homework.setName(value);
                        break;
                    case "updatet_id":
                        homework.setT_id(Integer.valueOf(value));
                        break;
                    case "updatecourse_id":
                        homework.setC_id(Integer.valueOf(value));
                        break;
                    case "updateend_time":
                        homework.setEnd_time(value);
                        break;
                }
            } else {//上传的文件
                String imgpath = "";
                if (!fileItem.getName().equals("")) {
                    StringBuffer sb = new StringBuffer("C:\\upload\\");
                    sb.append(fileItem.getName());
                    String imgPath = sb.toString();
                    fileItem.write(new File(imgPath));
                    homework.setDocu_name(fileItem.getName());
                    homework.setPath(imgPath);
                }
            }
        }
        int result = homeworkService.update(homework);
        System.out.println(result);
        resp.getWriter().write("" + result);
    }

    private void HomeworkStuManageUpdate(HttpServletRequest req, HttpServletResponse resp, List<FileItem> fileItems) throws Exception {
        HomeworkStu homeworkStu=new HomeworkStu();
        for (FileItem fileItem : fileItems) {
            if (fileItem.isFormField()) {//普通表单数据
                String filename = fileItem.getFieldName();
                String value = fileItem.getString("utf-8");
                switch (filename) {
                    case "homework_stu_id":
                        homeworkStu=homeworkStuService.queryHomeworkStuById(Integer.parseInt(value));
                        break;
                    case "correct":
                        homeworkStu.setCorrect(value);
                        break;
                    case "correct_score":
                        homeworkStu.setScore(Integer.valueOf(value));
                        break;
                    case "correct_time":
                        homeworkStu.setCorrect_time(value);
                        break;
                }
            }
        }
        homeworkStu.setCorrect_status("已评阅");
        int result=homeworkStuService.update(homeworkStu);
        resp.getWriter().write(""+result);


    }
}
