package com.changyue.crud.test;

import com.changyue.crud.bean.Employee;
import com.changyue.crud.dao.DepartmentMapper;
import com.changyue.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @program: ssm-crud
 * @description: 测试Mapper 使用Spring 的单元测试 自动注入组件
 * @author: ChangYue
 * @create: 2019-07-06 13:11
 * 1.导入springTest
 * 2.@ContextConfiguration 指定spring配置文件
 * 3.@Autowired
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;


    @Test
    public void testCRUD() {

        System.out.println(departmentMapper);

       /*
        departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));
        employeeMapper.insertSelective(new Employee(null, "TOM", "M", "Tom@changyue.com", 1));
        */

       //批量插入
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {

            String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uuid, "M", uuid+"@changyue.com", 1));

        }


        System.out.println("finish");

    }
}
