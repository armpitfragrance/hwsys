package com.entity;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 18:14
 * 描述:教学资料类
 */
public class TMaterial {
    private Integer id;//编号(主键)
    private String title;//标题
    private String content;//内容
    private String path;//路径
    private String name;//名称
    private String handup_time;//提交时间
    private Integer c_id;//课程编号
    private String create_time;//建表时间
    private String update_time;//更新表时间

    public TMaterial() {
    }

    public TMaterial(String title, String content, String path, String name, String handup_time, Integer c_id) {
        this.title = title;
        this.content = content;
        this.path = path;
        this.name = name;
        this.handup_time = handup_time;
        this.c_id = c_id;
    }

    public TMaterial(Integer id, String title, String content, String path, String name, String handup_time, Integer c_id) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.path = path;
        this.name = name;
        this.handup_time = handup_time;
        this.c_id = c_id;
    }

    public TMaterial(String title, String content, String path, String name, Integer c_id) {
        this.title = title;
        this.content = content;
        this.path = path;
        this.name = name;
        this.c_id = c_id;
    }

    public TMaterial(Integer id, String title, String content, String path, String name, String handup_time, Integer c_id, String create_time, String update_time) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.path = path;
        this.name = name;
        this.handup_time = handup_time;
        this.c_id = c_id;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    public TMaterial(Integer id, String title, String content, String path, String name, Integer c_id) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.path = path;
        this.name = name;
        this.c_id = c_id;
    }

    @Override
    public String toString() {
        return "TMaterial{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", path='" + path + '\'' +
                ", name='" + name + '\'' +
                ", handup_time='" + handup_time + '\'' +
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHandup_time() {
        return handup_time;
    }

    public void setHandup_time(String handup_time) {
        this.handup_time = handup_time;
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
