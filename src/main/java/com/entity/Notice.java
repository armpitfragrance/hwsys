package com.entity;

/**
 * 作者：ysq
 * 日期: 2020/12/9 17:51
 * 描述:
 */
public class Notice {
    private Integer id;
    private String title;
    private String content;
    private String notice_time;
    private String create_time;
    private String update_time;

    @Override
    public String toString() {
        return "Notice{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", notice_time='" + notice_time + '\'' +
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

    public String getNotice_time() {
        return notice_time;
    }

    public void setNotice_time(String notice_time) {
        this.notice_time = notice_time;
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

    public Notice() {
    }

    public Notice(String title, String content) {
        this.title = title;
        this.content = content;
    }

    public Notice(Integer id, String title, String content, String notice_time, String create_time, String update_time) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.notice_time = notice_time;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    public Notice(Integer id, String title, String content) {
        this.id = id;
        this.title = title;
        this.content = content;
    }
}
