package com.entity;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 17:55
 * 描述: 管理员类
 */
public class Admin {
    private Integer id;//主键id
    private String username;//登录名
    private String psw;//密码
    private String create_time;//建表时间
    private String update_time;//改表时间

    public Admin() {
    }

    public Admin(String username, String psw) {
        this.username = username;
        this.psw = psw;
    }

    public Admin(Integer id, String username, String psw) {
        this.id = id;
        this.username = username;
        this.psw = psw;
    }

    public Admin(Integer id, String username, String psw, String create_time, String update_time) {
        this.id = id;
        this.username = username;
        this.psw = psw;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPsw() {
        return psw;
    }

    public void setPsw(String psw) {
        this.psw = psw;
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

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", psw='" + psw + '\'' +
                ", create_time='" + create_time + '\'' +
                ", update_time='" + update_time + '\'' +
                '}';
    }
}
