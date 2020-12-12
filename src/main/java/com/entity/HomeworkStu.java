package com.entity;

/**
 * 作者：Zhh
 * 日期: 2020/12/9 18:09
 * 描述:
 */
public class HomeworkStu {
    private Integer id;//主键id
    private Integer hw_id;//布置作业编号
    private Integer stu_id;//学生编号
    private String handup_time;//提交时间
    private String correct;//评阅意见
    private Integer t_id;//评阅教师编号
    private String correct_time;//评阅时间
    private String correct_status;//评阅状态
    private String create_time;//建表时间
    private String update_time;//改表时间

    public HomeworkStu() {
    }

    public HomeworkStu(Integer hw_id, Integer stu_id, String handup_time, String correct, Integer t_id, String correct_time, String correct_status) {
        this.hw_id = hw_id;
        this.stu_id = stu_id;
        this.handup_time = handup_time;
        this.correct = correct;
        this.t_id = t_id;
        this.correct_time = correct_time;
        this.correct_status = correct_status;
    }

    public HomeworkStu(Integer id, Integer hw_id, Integer stu_id, String handup_time, String correct, Integer t_id, String correct_time, String correct_status) {
        this.id = id;
        this.hw_id = hw_id;
        this.stu_id = stu_id;
        this.handup_time = handup_time;
        this.correct = correct;
        this.t_id = t_id;
        this.correct_time = correct_time;
        this.correct_status = correct_status;
    }

    public HomeworkStu(Integer id, Integer hw_id, Integer stu_id, String handup_time, String correct, Integer t_id, String correct_time, String correct_status, String create_time, String update_time) {
        this.id = id;
        this.hw_id = hw_id;
        this.stu_id = stu_id;
        this.handup_time = handup_time;
        this.correct = correct;
        this.t_id = t_id;
        this.correct_time = correct_time;
        this.correct_status = correct_status;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    @Override
    public String toString() {
        return "HomeworkStu{" +
                "id=" + id +
                ", hw_id=" + hw_id +
                ", stu_id=" + stu_id +
                ", handup_time='" + handup_time + '\'' +
                ", correct='" + correct + '\'' +
                ", t_id=" + t_id +
                ", correct_time='" + correct_time + '\'' +
                ", correct_status='" + correct_status + '\'' +
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

    public Integer getHw_id() {
        return hw_id;
    }

    public void setHw_id(Integer hw_id) {
        this.hw_id = hw_id;
    }

    public Integer getStu_id() {
        return stu_id;
    }

    public void setStu_id(Integer stu_id) {
        this.stu_id = stu_id;
    }

    public String getHandup_time() {
        return handup_time;
    }

    public void setHandup_time(String handup_time) {
        this.handup_time = handup_time;
    }

    public String getCorrect() {
        return correct;
    }

    public void setCorrect(String correct) {
        this.correct = correct;
    }

    public Integer getT_id() {
        return t_id;
    }

    public void setT_id(Integer t_id) {
        this.t_id = t_id;
    }

    public String getCorrect_time() {
        return correct_time;
    }

    public void setCorrect_time(String correct_time) {
        this.correct_time = correct_time;
    }

    public String getCorrect_status() {
        return correct_status;
    }

    public void setCorrect_status(String correct_status) {
        this.correct_status = correct_status;
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

