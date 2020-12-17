package com.entity;

/**
 * 作者：ysq
 * 日期: 2020/12/9 17:47
 * 描述:
 */
public class Message {
    private Integer id;
    private String title;
    private String content;
    private String message_time;
    private Integer send_id;
    private Integer receive_id;
    private Integer readFlag;
    private String create_time;
    private String update_time;

    public Message(Integer id, String title, String content, String message_time, Integer send_id, Integer receive_id,Integer readFlag, String create_time, String update_time) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.message_time = message_time;
        this.send_id = send_id;
        this.receive_id = receive_id;
        this.readFlag = readFlag;
        this.create_time = create_time;
        this.update_time = update_time;
    }

    public Message(Integer id, String title, String content, Integer send_id, Integer receive_id,Integer readFlag) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.send_id = send_id;
        this.receive_id = receive_id;
        this.readFlag = readFlag;
    }

    public Message(String title, String content, Integer send_id, Integer receive_id,Integer readFlag) {
        this.title = title;
        this.content = content;
        this.send_id = send_id;
        this.receive_id = receive_id;
        this.readFlag = readFlag;
    }


    public Message() {
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

    public Integer getReadFlag() {
        return readFlag;
    }

    public void setReadFlag(Integer readFlag) {
        this.readFlag = readFlag;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", message_time='" + message_time + '\'' +
                ", send_id=" + send_id +
                ", receive_id=" + receive_id +
                ", readFlag=" + readFlag +
                ", create_time='" + create_time + '\'' +
                ", update_time='" + update_time + '\'' +
                '}';
    }
}
