<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"/>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>员工列表</title>
    <script src="${path}/static/js/jquery.js"></script>
    <link rel="stylesheet" href="${path}/static/bootstrap/css/bootstrap.min.css">
    <script src="${path}/static/bootstrap/js/bootstrap.js"></script>
</head>
<body>

<!-- add Modal -->
<div class="modal fade" id="add-emp-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <!-- 添加表单 -->
                <form>
                    <div class="form-group">
                        <label for="empName">员工姓名</label>
                        <input type="text" class="form-control" name="empName" id="empName" placeholder="请输入员工姓名">
                    </div>
                    <div class="form-group">
                        <label for="empEmail">邮箱地址</label>
                        <input type="email" class="form-control" name="email" id="empEmail"
                               aria-describedby="emailHelp"
                               placeholder="请输入邮箱">
                    </div>
                    <div class="form-group">
                        <label for="depts">部门</label>
                        <select class="form-control col-sm-4" id="depts" name="dId">
                        </select>
                    </div>
                    <fieldset class="form-group">
                        <div class="row">
                            <legend class="col-form-label col-sm-2 pt-0">性别</legend>
                            <div class="col-sm-10">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender"
                                           id="gender1-add-input"
                                           value="M" checked>
                                    <label class="form-check-label" for="gender1-add-input">
                                        男
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender"
                                           id="gender2-add-input"
                                           value="F">
                                    <label class="form-check-label" for="gender2-add-input">
                                        女
                                    </label>
                                </div>
                            </div>
                        </div>
                    </fieldset>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp-save-btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-12">
            <h1></h1>
        </div>
    </div>
    <div class="row">
        <div class="btn-group" role="group">
            <button id="add-emp-btn" class="btn btn-info" data-toggle="modal" data-target="#add-emp-modal">新增</button>

            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <table class="table table-hover" id="emp_table">
            <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>员工名字</th>
                <th>性别</th>
                <th>邮箱</th>
                <th>部门</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <div class="row">
        <div class="col-md-6" id="page-info-area"></div>
        <div class="col-md-6" id="page-nav-area"></div>
    </div>
</div>

</body>

<script>

    function showEmpInfo(result) {
        $("#emp_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            //console.info(item);
            var empId = $('<th scope="col"></th>').append(item.empId);
            var empName = $('<th scope="col"></th>').append(item.empName);
            var gender = $('<th scope="col"></th>').append(item.gender === "M" ? "男" : "女");
            var email = $('<th scope="col"></th>').append(item.email);
            var deptName = $('<th scope="col"></th>').append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm").append("编辑").css("marginRight", "10px");
            var removeBtn = $("<button></button>").addClass("btn btn-danger btn-sm").append("删除");
            var btn = $('<th scope="col"></th>').append(editBtn).append(removeBtn);

            $("<tr></tr>").append(empId).append(empName).append(gender).append(email).append(deptName).append(btn).appendTo("#emp_table tbody");

        })
    }

    function toPage(pn) {
        $.ajax({
            url: '${path}/emps',
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                // console.info(result);
                // 解析显示员工的信息
                showEmpInfo(result);
                //解析显示页码信息
                showPageInfo(result);
                // 解析显示分页信息
                showPageNumber(result);
            }
        });
    }

    function showPageNumber(result) {

        var pageInfo = result.extend.pageInfo;
        console.info(pageInfo);
        var pageNavDiv = $("#page-nav-area");
        pageNavDiv.empty();
        var pageNav = $("<ul></ul>").addClass("pagination justify-content-end");

        var firstPage = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("首页").attr("href", "#"));
        var prePage = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&laquo;").attr("href", "#"));

        if (!pageInfo.hasPreviousPage) {
            firstPage.addClass("disabled");
            prePage.addClass("disabled");
        } else {
            firstPage.click(function () {
                toPage(1);
            });

            prePage.click(function () {
                toPage(pageInfo.pageNum - 1);
            });
        }

        var lastPage = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("末页").attr("href", "#"));
        var nextPage = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&raquo;").attr("href", "#"));

        if (!pageInfo.hasNextPage) {
            lastPage.addClass("disabled");
            nextPage.addClass("disabled");
        } else {
            lastPage.click(function () {
                toPage(pageInfo.pages);
            });
            nextPage.click(function () {
                toPage(pageInfo.pageNum + 1);
            });
        }

        pageNav.append(firstPage).append(prePage);

        $.each(pageInfo.navigatepageNums, function (index, item) {
            var num = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append(item).attr("href", "#"));
            if (pageInfo.pageNum == item) {
                num.addClass("active");
            }
            num.click(function () {
                toPage(item);
            });
            pageNav.append(num);
        });

        pageNav.append(nextPage).append(lastPage);
        pageNavDiv.append($("<nav></nav>").append(pageNav));

    }

    var totalNum;

    function showPageInfo(result) {
        /*当前第{pageinfo.pageNum}页,总{pageinfo.pages}页,一共有{pageinfo.total}条记录*/
        $("#page-info-area").empty();
        var pageInfo = result.extend.pageInfo;
        $("#page-info-area").append("<p>当前第" + pageInfo.pageNum + "页,总" + pageInfo.pages + "页,一共有" + pageInfo.total + "条记录</p>")
        totalNum = pageInfo.total;
    }

    //页面加载完成后  ajax请求
    $(function () {
        toPage(1);
    });

    function getDept() {
        var depts = $("#add-emp-modal select");
        $.ajax({
            url: "${path}/depts",
            type: "get",
            success: function (result) {
                $.each(result.extend.depts, function () {

                    depts.append($("<option></option>").append(this.deptName).attr("value", this.deptId));

                })
            }
        })
    }

    $("#add-emp-btn").click(function () {
        //发送ajax 获取部门信息
        getDept();
        $("#add-emp-modal").modal({
            backdrop: "static"
        })
    });

    $("#emp-save-btn").click(function () {
        console.info($("#add-emp-modal form").serialize());
        $.ajax({
            url: "${path}/emps",
            type: "POST",
            data: $("#add-emp-modal form").serialize(),
            success: function (result) {
                /* console.info(result);*/
                //关闭model
                $('#add-emp-modal').modal('hide');
                toPage(totalNum);
            }
        })
    })

</script>

</html>
