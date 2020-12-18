package com.servlet;

import com.entity.Homework;
import com.entity.HomeworkManageInfo;
import com.google.gson.Gson;
import com.service.HomeworkService;
import com.service.impl.HomeworkServiceImpl;
import com.utils.Page;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/14 12:45
 * 描述:
 */
@WebServlet("/homework.do")
public class HomeworkServlet extends BaseServlet {
    HomeworkService homeworkService = new HomeworkServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    /**
     * 分页查询
     * 查询条件:课程编号、作业名、截止时间、页数
     * 使用场景:页面初始化、查询等
     * @param request
     * @param response
     * @throws IOException
     */
    public void queryHomeworkByNameAndEndtime(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String name = request.getParameter("name");
        Integer course_id = Integer.valueOf(request.getParameter("course_id"));
        String end_time = request.getParameter("end_time");
        Integer pageNum = Integer.valueOf(request.getParameter("pageNum"));

        Page<HomeworkManageInfo> page = homeworkService.queryHomeworkByNameAndEndtime(pageNum, Page.PAGE_SIZE, course_id, name, end_time);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(page);
        System.out.println(JsonStr);
        response.getWriter().write(JsonStr);
    }

    /**
     * 查询单条信息
     * 使用场景:修改作业信息回填
     * @param request
     * @param response
     * @throws IOException
     */
    public void queryForOne(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        Homework homework = homeworkService.queryHomeworkById(id);
        Gson gson = new Gson();
        String JsonStr = gson.toJson(homework);
        response.getWriter().write(JsonStr);
    }

    /**
     * 删除作业信息
     * @param request
     * @param response
     * @throws IOException
     */
    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id= Integer.valueOf(request.getParameter("homework_id"));
        int result=homeworkService.delete(id);
        response.getWriter().write(""+result);
    }

    /**
     * 布置作业
     * @param request
     * @param response
     */
    public void insert(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        Homework homework=new Homework();
        if (ServletFileUpload.isMultipartContent(request)) {
            //创建FileItemFactory   工厂实现类
            FileItemFactory fileItemFactory = new DiskFileItemFactory();
            //创建用于解析上传数据的工具类
            ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
            List<FileItem> list = null;
            try {
                list = servletFileUpload.parseRequest(request);
                for (FileItem fileItem : list) {
                    if (fileItem.isFormField()) {
                        //普通表单项
                        //对普通表单项的操作
                        String str = fileItem.getFieldName();
                        switch (str) {
                            case "addname"://作业名
                                String name=fileItem.getString("utf-8");
                                homework.setName(name);
                                break;
                            case "addt_id"://教师编号
                                Integer t_id= Integer.valueOf(fileItem.getString());
                                homework.setT_id(t_id);
                                break;
                            case "addcourse_id"://课程编号
                                Integer c_id= Integer.valueOf(fileItem.getString());
                                homework.setC_id(c_id);
                                break;
                            case "addend_time"://截止提交时间
                                String end_time=fileItem.getString();
                                homework.setEnd_time(end_time);
                                break;
                        }
                    } else {
                        //上传的文件
                        //System.out.println("表单项的name=" + fileItem.getFieldName());
                        //System.out.println("上传文件名=" + fileItem.getName());
                        StringBuilder sb = new StringBuilder("C:\\upload\\");
                        sb.append(fileItem.getName());
                        String imgpath = sb.toString();
                        homework.setDocu_name(fileItem.getName());
                        homework.setPath(imgpath);
                        fileItem.write(new File(imgpath));
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        int result=homeworkService.insert(homework);
        response.getWriter().write(""+result);
    }

    public void queryPath(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        Homework homework=homeworkService.queryHomeworkById(id);
        String pathname=homework.getDocu_name();
        response.getWriter().write(pathname);
    }

}
