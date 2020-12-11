package com.entity;

/**
 * 作者：ysq
 * 日期: 2020/12/10 16:44
 * 描述:
 */
public class SCCTStu {
    private Integer id;//选课id
    private String name;//选课名字
    private String realname;//授课老师姓名
    private Integer t_no;//授课老师工号
    private Integer count;//选课人数

    public SCCTStu() {
    }

    public SCCTStu(Integer id, String name, String realname, Integer t_no, Integer count) {

        this.id = id;
        this.name = name;
        this.realname = realname;
        this.t_no = t_no;
        this.count = count;
    }

    @Override
    public String toString() {
        return "SCCTStu{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", realname='" + realname + '\'' +
                ", t_no=" + t_no +
                ", count=" + count +
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
}
