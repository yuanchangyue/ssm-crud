package com.changyue.crud.test;

import com.changyue.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Arrays;
import java.util.List;

/**
 * @program: crud
 * @description: 使用Spring测试模块请求功能 测试curd请求的正确性
 * @author: ChangYue
 * @create: 2019-07-06 19:40
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:dispatcher-servlet.xml"})
public class MvcTest {

    @Autowired
    WebApplicationContext context;

    MockMvc mockMvc;

    @Before
    public void initMockMvc() {

        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult pn = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

        //请求成功后 拿到PageInfo：
        MockHttpServletRequest request = pn.getRequest();
        PageInfo pageinfo = (PageInfo) request.getAttribute("pageinfo");

        System.out.println("当前页码" + pageinfo.getPageNum());
        System.out.println("总页码" + pageinfo.getPages());
        System.out.println("总记录数" + pageinfo.getTotal());
        System.out.println("当前页面需要的显示的连续页码");
        System.out.println(Arrays.toString(pageinfo.getNavigatepageNums()) + " ");

        List<Employee> list = pageinfo.getList();

        for (Employee employee : list) {
            System.out.println(employee);
        }

    }

}
