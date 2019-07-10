package com.changyue.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @program: ssm-crud
 * @description: 通用就返回类
 * @author: ChangYue
 * @create: 2019-07-10 16:59
 */
public class Msg {
    private int code;
    private String msg;

    private Map<String, Object> extend = new HashMap<>();

    public static Msg success() {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理成功！");
        return msg;
    }

    public static Msg fail() {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理失败！");
        return msg;
    }

    public Msg add(String code, Object value) {
        this.getExtend().put(code, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
