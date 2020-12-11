package com.entity;

/**
 * 作者：Zhh
 * 日期: 2020/12/11 14:33
 * 描述:
 */
public class UserTeacher {
    private Integer id;//教师编号(主键)
    private Integer user_id;//用户编号(主键)
    private Integer t_no;//学生编号(主键)
    private String psw;//密码
    private String realname;
    private String sex;//性别
    private Integer age;//年龄

    public UserTeacher() {
    }

    public UserTeacher(Integer id, Integer user_id, Integer t_no, String psw, String realname, String sex, Integer age) {
        this.id = id;
        this.user_id = user_id;
        this.t_no = t_no;
        this.psw = psw;
        this.realname = realname;
        this.sex = sex;
        this.age = age;
    }

    @Override
    public String toString() {
        return "UserTeacher{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", t_no=" + t_no +
                ", psw='" + psw + '\'' +
                ", realname='" + realname + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                '}';
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

    public Integer getT_no() {
        return t_no;
    }

    public void setT_no(Integer t_no) {
        this.t_no = t_no;
    }

    public String getPsw() {
        return psw;
    }

    public void setPsw(String psw) {
        this.psw = psw;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }
}
