package com.entity;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 17:59
 * 描述:
 */
public class Homework {
    private Integer id;//主键id
    private String name;//作业名称
    private String docu_name;//文档（附件）名称
    private String path;//附件路径
    private Integer t_id;//教师编号
    private Integer c_id;//课程编号
    private String create_time;//建表时间
    private String update_time;//改表时间

    public Homework() {
    }

    public Homework(String name, String docu_name, String path, Integer t_id, Integer c_id) {
        this.name = name;
        this.docu_name = docu_name;
        this.path = path;
        this.t_id = t_id;
        this.c_id = c_id;
    }

    public Homework(Integer id, String name, String docu_name, String path, Integer t_id, Integer c_id) {
        this.id = id;
        this.name = name;
        this.docu_name = docu_name;
        this.path = path;
        this.t_id = t_id;
        this.c_id = c_id;
    }

    public Homework(Integer id, String name, String docu_name, String path, Integer t_id, Integer c_id, String create_time, String update_time) {
        this.id = id;
        this.name = name;
        this.docu_name = docu_name;
        this.path = path;
        this.t_id = t_id;
        this.c_id = c_id;
        this.create_time = create_time;
        this.update_time = update_time;
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

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
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

    @Override
    public String toString() {
        return "Homework{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", docu_name='" + docu_name + '\'' +
                ", path='" + path + '\'' +
                ", t_id=" + t_id +
                ", c_id=" + c_id +
                ", create_time='" + create_time + '\'' +
                ", update_time='" + update_time + '\'' +
                '}';
    }
}
