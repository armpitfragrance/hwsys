package com.entity;

/**
 * 作者：ysq
 * 日期: 2020/12/9 17:54
 * 描述:
 */
public class SC {
    private Integer id;
    private Integer c_id;
    private Integer stu_id;
    private String create_time;
    private String update_time;

    @Override
    public String toString() {
        return "SCDao{" +
                "id=" + id +
                ", c_id=" + c_id +
                ", stu_id=" + stu_id +
                ", create_time='" + create_time + '\'' +
                ", update_time='" + update_time + '\'' +
                '}';
    }

    public SC() {
    }

    public SC(Integer c_id, Integer stu_id) {

        this.c_id = c_id;
        this.stu_id = stu_id;
    }

    public SC(Integer id, Integer c_id, Integer stu_id, String create_time, String update_time) {

        this.id = id;
        this.c_id = c_id;
        this.stu_id = stu_id;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    public Integer getId() {

        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getC_id() {
        return c_id;
    }

    public void setC_id(Integer c_id) {
        this.c_id = c_id;
    }

    public Integer getStu_id() {
        return stu_id;
    }

    public void setStu_id(Integer stu_id) {
        this.stu_id = stu_id;
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

    public SC(Integer id, Integer c_id, Integer stu_id) {
        this.id = id;
        this.c_id = c_id;
        this.stu_id = stu_id;
    }

    public void setUpdate_time(String update_time) {
        this.update_time = update_time;
    }
}
