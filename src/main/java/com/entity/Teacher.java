package com.entity;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:14
 * 描述:老师表
 */
public class Teacher {
    private Integer id;//编号(主键)
    private Integer user_id;//用户编号
    private Integer t_no;//老师工号
    private String create_time;//建表时间
    private String update_time;//更新表时间

    public Teacher() {
    }

    public Teacher(Integer user_id, Integer t_no) {
        this.user_id = user_id;
        this.t_no = t_no;
    }

    public Teacher(Integer id, Integer user_id, Integer t_no) {
        this.id = id;
        this.user_id = user_id;
        this.t_no = t_no;
    }

    public Teacher(Integer id, Integer user_id, Integer t_no, String create_time, String update_time) {
        this.id = id;
        this.user_id = user_id;
        this.t_no = t_no;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", t_no=" + t_no +
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
