package com.changyue.crud.service;

import com.changyue.crud.bean.Employee;
import com.changyue.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: crud
 * @description:
 * @author: ChangYue
 * @create: 2019-07-06 19:23
 */
@Service
public class EmployeeService  {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }
}
