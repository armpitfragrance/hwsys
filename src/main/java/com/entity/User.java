package com.entity;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:14
 * 描述:用户表
 */
public class User {
    private Integer id;//编号(主键)
    private String type;//用户类型
    private String psw;//密码
    private String realname;//真实姓名
    private String sex;//性别
    private Integer age;//年龄
    private String create_time;//建表时间
    private String update_time;//更新表时间

    public User() {
    }

    public User(String type, String psw, String realname, String sex, Integer age) {
        this.type = type;
        this.psw = psw;
        this.realname = realname;
        this.sex = sex;
        this.age = age;
    }

    public User(Integer id, String type, String psw, String realname, String sex, Integer age) {
        this.id = id;
        this.type = type;
        this.psw = psw;
        this.realname = realname;
        this.sex = sex;
        this.age = age;
    }

    public User(Integer id, String type, String psw, String realname, String sex, Integer age, String create_time, String update_time) {
        this.id = id;
        this.type = type;
        this.psw = psw;
        this.realname = realname;
        this.sex = sex;
        this.age = age;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", psw='" + psw + '\'' +
                ", realname='" + realname + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                ", create_time='" + create_time + '\'' +
                ", update_time='" + update_time + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
