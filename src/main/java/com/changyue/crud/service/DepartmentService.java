package com.changyue.crud.service;

import com.changyue.crud.bean.Department;
import com.changyue.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: ssm-crud
 * @description:
 * @author: ChangYue
 * @create: 2019-07-10 23:12
 */
@Service
public class DepartmentService {


    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
