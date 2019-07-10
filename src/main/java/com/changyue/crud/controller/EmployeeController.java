package com.changyue.crud.controller;

import com.changyue.crud.bean.Employee;
import com.changyue.crud.bean.Msg;
import com.changyue.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
     * 只适合浏览器
     *
     * @return
     */
    @RequestMapping(value = "/emp")
    public String getEmp(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        //分页 页码 每页大小
        PageHelper.startPage(pn, 5);
        //查询的list
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo 封装了详细的数据 连续显示的页数
        PageInfo page = new PageInfo<>(emps, 5);
        model.addAttribute("pageinfo", page);
        return "list";
    }


    /**
     * 查询员工 分页显示
     * 前后端分离 返回json数据
     *
     * @return 数据
     */
    @RequestMapping(value = "/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {

        //分页 页码 每页大小
        PageHelper.startPage(pn, 5);
        //查询的list
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo 封装了详细的数据 连续显示的页数
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        //返回
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 员工保存
     *
     * @param employee 前端传来的数据
     * @return
     */
    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }

}
