package com.entity;

/**
 * 作者：youjiahao
 * 日期: 2020/12/15 10:02
 * 描述:布置作业类(教师端布置作业展示)
 */
public class HomeworkManageInfo {
    //homework
    private Integer id;//主键id
    private String name;//作业名称
    private String docu_name;//文档（附件）名称
    //teacher、user
    private String t_name;//教师名
    // course
    private String c_name;//课程名
    private String end_time;//截止提交时间

    public HomeworkManageInfo() {
    }

    public HomeworkManageInfo(Integer id, String name, String docu_name, String t_name, String c_name, String end_time) {
        this.id = id;
        this.name = name;
        this.docu_name = docu_name;
        this.t_name = t_name;
        this.c_name = c_name;
        this.end_time = end_time;
    }

    @Override
    public String toString() {
        return "HomeworkManageInfo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", docu_name='" + docu_name + '\'' +
                ", t_name='" + t_name + '\'' +
                ", c_name='" + c_name + '\'' +
                ", end_time='" + end_time + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDocu_name() {
        return docu_name;
    }

    public void setDocu_name(String docu_name) {
        this.docu_name = docu_name;
    }

    public String getT_name() {
        return t_name;
    }

    public void setT_name(String t_name) {
        this.t_name = t_name;
    }

    public String getC_name() {
        return c_name;
    }

    public void setC_name(String c_name) {
        this.c_name = c_name;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }
}
