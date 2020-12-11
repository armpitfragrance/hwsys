package com.entity;

/**
 * 作者：Zhh
 * 日期: 2020/12/10 16:46
 * 描述:
 */
public class UserStudent {
    private Integer id;//学生编号(主键)
    private Integer user_id;//用户编号(主键)
    private Integer stu_no;//学生编号(主键)
    private String psw;//密码
    private String classname;
    private String realname;
    private String sex;//性别
    private Integer age;//年龄

    public UserStudent() {
    }

    public UserStudent(Integer id, Integer user_id, Integer stu_no, String psw, String classname, String realname, String sex, Integer age) {
        this.id = id;
        this.user_id = user_id;
        this.stu_no = stu_no;
        this.psw = psw;
        this.classname = classname;
        this.realname = realname;
        this.sex = sex;
        this.age = age;
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

    public String getPsw() {
        return psw;
    }

    public void setPsw(String psw) {
        this.psw = psw;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
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

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    @Override
    public String toString() {
        return "UserStudent{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", stu_no=" + stu_no +
                ", psw='" + psw + '\'' +
                ", classname='" + classname + '\'' +
                ", realname='" + realname + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                '}';
    }
}
