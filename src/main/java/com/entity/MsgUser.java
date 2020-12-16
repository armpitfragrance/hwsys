package com.entity;

/**
 * 作者：ysq
 * 日期: 2020/12/14 8:59
 * 描述:
 */
public class MsgUser {
    private Integer id;
    private String title;///标题
    private String content;//内容
    private String message_time;//发送时间
    private Integer send_id;//发送人id
    private Integer receive_id;//收件人id
    private String send_name;//发送人姓名
    private String receive_name;//收件人姓名
    private String readFlag;

    public MsgUser(Integer id, String title, String content, String message_time, Integer send_id, Integer receive_id, String send_name, String receive_name,String readFlag) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.message_time = message_time;
        this.send_id = send_id;
        this.receive_id = receive_id;
        this.send_name = send_name;
        this.receive_name = receive_name;
        this.readFlag = readFlag;
    }

    public MsgUser() {
    }

    @Override
    public String toString() {
        return "MsgUser{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", message_time='" + message_time + '\'' +
                ", send_id=" + send_id +
                ", receive_id=" + receive_id +
                ", send_name='" + send_name + '\'' +
                ", receive_name='" + receive_name + '\'' +
                ", readFlag='" + readFlag + '\'' +
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

    public String getMessage_time() {
        return message_time;
    }

    public void setMessage_time(String message_time) {
        this.message_time = message_time;
    }

    public Integer getSend_id() {
        return send_id;
    }

    public void setSend_id(Integer send_id) {
        this.send_id = send_id;
    }

    public Integer getReceive_id() {
        return receive_id;
    }

    public void setReceive_id(Integer receive_id) {
        this.receive_id = receive_id;
    }

    public String getSend_name() {
        return send_name;
    }

    public void setSend_name(String send_name) {
        this.send_name = send_name;
    }

    public String getReceive_name() {
        return receive_name;
    }

    public void setReceive_name(String receive_name) {
        this.receive_name = receive_name;
    }

    public String getReadFlag() {
        return readFlag;
    }

    public void setReadFlag(String readFlag) {
        this.readFlag = readFlag;
    }
}
