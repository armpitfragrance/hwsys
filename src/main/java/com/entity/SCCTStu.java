package com.entity;

/**
 * 作者：ysq
 * 日期: 2020/12/10 16:44
 * 描述:
 */
public class SCCTStu {
    private Integer id;//选课id
    private Integer c_id;//课程id
    private String name;//选课名字
    private String realname;//授课老师姓名
    private Integer t_no;//授课老师工号
    private String path;//图片路径
    private Integer count;//选课人数
    private String createtime;//创建时间

    public SCCTStu() {
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "SCCTStu{" +
                "id=" + id +
                ", c_id=" + c_id +
                ", name='" + name + '\'' +
                ", realname='" + realname + '\'' +
                ", t_no=" + t_no +
                ", path='" + path + '\'' +
                ", count=" + count +
                ", createtime='" + createtime + '\'' +
                '}';
    }

    public SCCTStu(Integer id, Integer c_id, String name, String realname, Integer t_no, String path, Integer count, String createtime) {
        this.id = id;
        this.c_id = c_id;
        this.name = name;
        this.realname = realname;
        this.t_no = t_no;
        this.path = path;
        this.count = count;
        this.createtime = createtime;
    }

    public SCCTStu(Integer id, String name, String realname, Integer t_no, String path, Integer count, String createtime) {

        this.id = id;
        this.name = name;
        this.realname = realname;
        this.t_no = t_no;
        this.path = path;
        this.count = 0;
        this.createtime = createtime;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
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

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public Integer getT_no() {
        return t_no;
    }

    public void setT_no(Integer t_no) {
        this.t_no = t_no;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getC_id() {
        return c_id;
    }

    public void setC_id(Integer c_id) {
        this.c_id = c_id;
    }
}
