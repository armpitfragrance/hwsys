package com.entity;

/**
 * 作者：youjiahao
 * 日期: 2020/12/16 9:51
 * 描述:评阅作业、提交作业类
 */
public class HomeworkStuManageInfo {
    private Integer id;//编号
    private String hw_name;//作业名称
    private Integer stu_no;//学号
    private String stu_name;//学生姓名
    private String docu_name;//提交文档名
    private String end_time;//截止提交时间
    private String handup_time;//提交时间
    private String t_name;//评阅教师姓名
    private String correct;//评阅意见
    private String score;//评阅分数
    private String status;//评阅状态
    private String correct_time;//评阅时间

    public HomeworkStuManageInfo() {
    }

    public HomeworkStuManageInfo(String hw_name, Integer stu_no, String stu_name, String docu_name, String end_time, String handup_time, String t_name, String correct, String score, String status, String correct_time) {
        this.hw_name = hw_name;
        this.stu_no = stu_no;
        this.stu_name = stu_name;
        this.docu_name = docu_name;
        this.end_time = end_time;
        this.handup_time = handup_time;
        this.t_name = t_name;
        this.correct = correct;
        this.score = score;
        this.status = status;
        this.correct_time = correct_time;
    }

    public HomeworkStuManageInfo(Integer id, String hw_name, Integer stu_no, String stu_name, String docu_name, String end_time, String handup_time, String t_name, String correct, String score, String status, String correct_time) {
        this.id = id;
        this.hw_name = hw_name;
        this.stu_no = stu_no;
        this.stu_name = stu_name;
        this.docu_name = docu_name;
        this.end_time = end_time;
        this.handup_time = handup_time;
        this.t_name = t_name;
        this.correct = correct;
        this.score = score;
        this.status = status;
        this.correct_time = correct_time;
    }

    @Override
    public String toString() {
        return "HomeworkStuManageInfo{" +
                "id=" + id +
                ", hw_name='" + hw_name + '\'' +
                ", stu_no=" + stu_no +
                ", stu_name='" + stu_name + '\'' +
                ", docu_name='" + docu_name + '\'' +
                ", end_time='" + end_time + '\'' +
                ", handup_time='" + handup_time + '\'' +
                ", t_name='" + t_name + '\'' +
                ", correct='" + correct + '\'' +
                ", score='" + score + '\'' +
                ", status='" + status + '\'' +
                ", correct_time='" + correct_time + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getHw_name() {
        return hw_name;
    }

    public void setHw_name(String hw_name) {
        this.hw_name = hw_name;
    }

    public Integer getStu_no() {
        return stu_no;
    }

    public void setStu_no(Integer stu_no) {
        this.stu_no = stu_no;
    }

    public String getStu_name() {
        return stu_name;
    }

    public void setStu_name(String stu_name) {
        this.stu_name = stu_name;
    }

    public String getDocu_name() {
        return docu_name;
    }

    public void setDocu_name(String docu_name) {
        this.docu_name = docu_name;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getHandup_time() {
        return handup_time;
    }

    public void setHandup_time(String handup_time) {
        this.handup_time = handup_time;
    }

    public String getT_name() {
        return t_name;
    }

    public void setT_name(String t_name) {
        this.t_name = t_name;
    }

    public String getCorrect() {
        return correct;
    }

    public void setCorrect(String correct) {
        this.correct = correct;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCorrect_time() {
        return correct_time;
    }

    public void setCorrect_time(String correct_time) {
        this.correct_time = correct_time;
    }
}
