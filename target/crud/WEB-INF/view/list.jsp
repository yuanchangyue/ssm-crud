<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<html>
<head>
    <title>员工列表</title>
    <script src="${path}/static/js/jquery.js"></script>
    <link rel="stylesheet" href="${path}/static/bootstrap/css/bootstrap.min.css">
    <script src="${path}/static/bootstrap/js/bootstrap.js"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-12">
            <h1>ssm</h1>
        </div>
    </div>
    <div class="row">
        <div class="btn-group" role="group">
            <button class="btn btn-info">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <table class="table">
            <thead class="thead-light">
            <tr>
                <th scope="col">#</th>
                <th scope="col">empName</th>
                <th scope="col">gender</th>
                <th scope="col">email</th>
                <th scope="col">deptName</th>
                <th scope="col">option</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageinfo.list}" var="emp">
                <tr>
                    <th scope="col">${emp.empId}</th>
                    <th scope="col">${emp.empName}</th>
                    <th scope="col">${emp.gender=="M"?"男":"女"}</th>
                    <th scope="col">${emp.email}</th>
                    <th scope="col">${emp.department.deptName}</th>
                    <th scope="col">
                        <button type="button" class="btn btn-primary btn-sm">编辑</button>
                        <button type="button" class="btn btn-danger btn-sm">删除</button>
                    </th>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="row">
        <div class="col-md-6">
            <p>当前第${pageinfo.pageNum}页,总${pageinfo.pages}页,一共有${pageinfo.total}条记录.</p>
        </div>
        <div class="col-md-6 ">
            <nav>
                <ul class="pagination justify-content-end">
                    <li class="page-item">
                        <a class="page-link" href="${path}/emps?pn=1" tabindex="-1">首页</a>
                    </li>
                    <c:if test="${pageinfo.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="${path}/emps?pn=${pageinfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageinfo.navigatepageNums}" var="num">
                        <c:if test="${num==pageinfo.pageNum}">
                            <li class="page-item active">
                                <a class="page-link" href="#">${num}</a>
                            </li>
                        </c:if>
                        <c:if test="${num!=pageinfo.pageNum}">
                            <li class="page-item">
                                <a class="page-link" href="${path}/emps?pn=${num}">${num}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageinfo.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="${path}/emps?pn=${pageinfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item">
                        <a class="page-link" href="${path}/emps?pn=${pageinfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
