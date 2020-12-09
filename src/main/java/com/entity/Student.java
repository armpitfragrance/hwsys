package com.entity;

/**
 * 作者：ysq
 * 日期: 2020/12/9 17:59
 * 描述:
 */
public class Student {
    private Integer id;
    private Integer user_id;
    private Integer stu_no;
    private String classname;
    private String create_time;
    private String update_time;

    public Student(Integer id, Integer user_id, Integer stu_no, String classname) {
        this.id = id;
        this.user_id = user_id;
        this.stu_no = stu_no;
        this.classname = classname;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", stu_no=" + stu_no +
                ", classname='" + classname + '\'' +
                ", create_time='" + create_time + '\'' +
                ", update_time='" + update_time + '\'' +
                '}';
    }

    public Student() {
    }

    public Student(Integer id, Integer user_id, Integer stu_no, String classname, String create_time, String update_time) {

        this.id = id;
        this.user_id = user_id;
        this.stu_no = stu_no;
        this.classname = classname;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    public Student(Integer user_id, Integer stu_no, String classname) {

        this.user_id = user_id;
        this.stu_no = stu_no;
        this.classname = classname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getStu_no() {
        return stu_no;
    }

    public void setStu_no(Integer stu_no) {
        this.stu_no = stu_no;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }

    public String getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(String update_time) {
        this.update_time = update_time;
    }
}
