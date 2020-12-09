package com.entity;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:14
 * 描述:教课表(老师)
 */
public class TC {
    private Integer id;//编号(主键)
    private Integer t_id;//老师编号
    private Integer c_id;//课程编号
    private String create_time;//建表时间
    private String update_time;//更新表时间

    public TC() {
    }

    public TC(Integer t_id, Integer c_id) {
        this.t_id = t_id;
        this.c_id = c_id;
    }

    public TC(Integer id, Integer t_id, Integer c_id) {
        this.id = id;
        this.t_id = t_id;
        this.c_id = c_id;
    }

    public TC(Integer id, Integer t_id, Integer c_id, String create_time, String update_time) {
        this.id = id;
        this.t_id = t_id;
        this.c_id = c_id;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    @Override
    public String toString() {
        return "TC{" +
                "id=" + id +
                ", t_id=" + t_id +
                ", c_id=" + c_id +
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

    public Integer getT_id() {
        return t_id;
    }

    public void setT_id(Integer t_id) {
        this.t_id = t_id;
    }

    public Integer getC_id() {
        return c_id;
    }

    public void setC_id(Integer c_id) {
        this.c_id = c_id;
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
