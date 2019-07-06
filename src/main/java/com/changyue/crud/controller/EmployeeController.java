package com.changyue.crud.controller;

import com.changyue.crud.bean.Employee;
import com.changyue.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @program: crud
 * @description:
 * @author: ChangYue
 * @create: 2019-07-06 19:20
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工 分页显示
     *
     * @return
     */
    @RequestMapping(value = "/emp")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        //分页 页码 每页大小
        PageHelper.startPage(pn, 5);
        //查询的list
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo 封装了详细的数据 连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageinfo", page);
        return "list";
    }

    /**
     * jackjson
     * 查询员工 分页显示
     *
     * @return
     */
    @RequestMapping(value = "/emps")
    @ResponseBody
    public PageInfo getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {

        //分页 页码 每页大小
        PageHelper.startPage(pn, 5);
        //查询的list
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo 封装了详细的数据 连续显示的页数

        return new PageInfo(emps, 5);
    }

}
