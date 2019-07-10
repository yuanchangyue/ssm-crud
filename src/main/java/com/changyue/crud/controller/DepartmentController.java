package com.changyue.crud.controller;

import com.changyue.crud.bean.Msg;
import com.changyue.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @program: ssm-crud
 * @description: 处理部门相关的请求
 * @author: ChangYue
 * @create: 2019-07-10 23:10
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 获得全部部门信息
     * @return 部门
     */
    @RequestMapping(value = "/depts")
    @ResponseBody
    public Msg getDepts() {
        return Msg.success().add("depts", departmentService.getDepts());
    }



}
