package com.entity;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:01
 * 描述:课程类
 */
public class Course {
    private Integer id;//主键id
    private String name;//课程名
    private String path;//课程显示图片路径
    private String create_time;//建表时间
    private String update_time;//改表时间

    public Course() {
    }

    public Course(String name, String path) {
        this.name = name;
        this.path = path;
    }

    public Course(Integer id, String name, String path) {
        this.id = id;
        this.name = name;
        this.path = path;
    }

    public Course(Integer id, String name, String path, String create_time, String update_time) {
        this.id = id;
        this.name = name;
        this.path = path;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", path='" + path + '\'' +
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
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
