package com.changyue.crud.controller;

import com.changyue.crud.bean.Employee;
import com.changyue.crud.bean.Msg;
import com.changyue.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;
import java.util.jar.JarEntry;

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
     * @return msg
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
     * @return msg
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
     * @return msg
     */
    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {

            Map<String, Object> mapModel = new HashMap<>();
            //校验失败 返回失败的信息
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段" + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                mapModel.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFile", mapModel);
        } else {
            employeeService.saveEmp(employee);
        }
        return Msg.success();
    }

    /**
     * 员工更新
     * <p>
     * 如果前端ajax直接使用PUT请求 请求体中有数据 实体对象没有成功封装
     * Tomcat:Tomcat不会封装PUT请求的数据 只有POST请求才会
     * <p>
     * 直接发送前端PUT
     * 配置filter HttpPutFormContentFilter 将请求体中的数据包装成Map request重新包装 getParameter 可以获得数据
     *
     * @param employee 需要修改的员工信息
     * @return msg
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 校验用户名是否存在
     *
     * @return msg
     */
    @RequestMapping(value = "/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam String empname) {
        boolean isExist = employeeService.checkUser(empname);
        if (isExist) {
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

    /**
     * 根据员工id查询员工
     *
     * @param id 员工id
     * @return msg
     */
    @RequestMapping(value = "/emps/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        return Msg.success().add("emp", employeeService.getEmp(id));
    }


    /**
     * 根据员工id删除员工
     * 单个和批量
     *
     * @param id 员工id
     * @return msg
     */
    @RequestMapping(value = "/emps/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable String id) {
        if (id.contains("-")) {

            String[] ids = id.split("-");
            ArrayList<Integer> idsList = new ArrayList<>();

            for (String s : ids) {
                idsList.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(idsList);

        } else {
            employeeService.deleteEmp(Integer.parseInt(id));
        }
        return Msg.success();
    }

}
