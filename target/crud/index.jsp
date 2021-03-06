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

<!-- 添加的模态框 -->
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
                        <label for="empAddName">员工姓名</label>
                        <input type="text" class="form-control" name="empName" id="empAddName"
                               placeholder="请输入员工姓名" required>
                        <div class="valid-feedback"></div>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="form-group">
                        <label for="empAddEmail">邮箱地址</label>
                        <input type="email" class="form-control" name="email" id="empAddEmail"
                               aria-describedby="emailHelp"
                               placeholder="请输入邮箱">
                        <div class="valid-feedback"></div>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="form-group">
                        <label for="empAddDepts">部门</label>
                        <select class="form-control col-sm-4" id="empAddDepts" name="dId">
                        </select>
                    </div>
                    <fieldset class="form-group">
                        <div class="row">
                            <legend class="col-form-label col-sm-2 pt-0">性别</legend>
                            <div class="col-sm-10">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender"
                                           id="gender1-add-input"
                                           value="M" checked>
                                    <label class="form-check-label" for="gender1-add-input">
                                        男
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
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

<!-- 修改的模态框 -->
<div class="modal fade" id="update-emp-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">员工修改</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="empUpdateName">员工姓名</label>
                        <p type="text" class="form-control-plaintext" id="empUpdateName">
                        <div class="valid-feedback"></div>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="form-group">
                        <label for="empUpdateEmail">邮箱地址</label>
                        <input type="email" class="form-control" name="email" id="empUpdateEmail"
                               aria-describedby="emailHelp"
                               placeholder="请输入邮箱">
                        <div class="valid-feedback"></div>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="form-group">
                        <label for="empUPdateDepts">部门</label>
                        <select class="form-control col-sm-4" id="empUPdateDepts" name="dId">
                        </select>
                    </div>
                    <fieldset class="form-group">
                        <div class="row">
                            <legend class="col-form-label col-sm-2 pt-0">性别</legend>
                            <div class="col-sm-10">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender"
                                           id="gender1-update-input"
                                           value="M" checked>
                                    <label class="form-check-label" for="gender1-update-input">
                                        男
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender"
                                           id="gender2-update-input"
                                           value="F">
                                    <label class="form-check-label" for="gender2-update-input">
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
                <button type="button" class="btn btn-primary" id="emp-update-btn">更新</button>
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
            <button id="remove-emp-btn" class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <table class="table table-hover" id="emp_table">
            <thead class="thead-light">
            <tr>
                <th>
                    <input type="checkbox" id="allCheck">
                </th>
                <th>ID</th>
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
            var checkBox = $("<th scope='col'><input class='check-item' type='checkbox'/></th>");
            var empId = $('<th scope="col"></th>').append(item.empId);
            var empName = $('<th scope="col"></th>').append(item.empName);
            var gender = $('<th scope="col"></th>').append(item.gender === "M" ? "男" : "女");
            var email = $('<th scope="col"></th>').append(item.email);
            var deptName = $('<th scope="col"></th>').append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit-btn").append("编辑").css("marginRight", "10px").attr("edit-id", item.empId);
            var removeBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete-btn").append("删除").attr("remove-id", item.empId);
            var btn = $('<th scope="col"></th>').append(editBtn).append(removeBtn);

            $("<tr></tr>").append(checkBox).append(empId).append(empName).append(gender).append(email).append(deptName).append(btn).appendTo("#emp_table tbody");

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
            if (pageInfo.pageNum === item) {
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
    var currentPage;

    function showPageInfo(result) {
        /*当前第{pageinfo.pageNum}页,总{pageinfo.pages}页,一共有{pageinfo.total}条记录*/
        $("#page-info-area").empty();
        var pageInfo = result.extend.pageInfo;
        $("#page-info-area").append("<p>当前第" + pageInfo.pageNum + "页,总" + pageInfo.pages + "页,一共有" + pageInfo.total + "条记录</p>")
        totalNum = pageInfo.total;
        currentPage = pageInfo.pageNum;
    }

    //页面加载完成后  ajax请求
    $(function () {
        toPage(1);
    });

    function getDept(ele) {
        var depts = $(ele);
        depts.empty();
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

    function reset_form(ele) {
        //jquery没有reset方法 使用原生方法
        $(ele)[0].reset();
        $(ele).removeClass("has-success has-error");
        $(ele).find(":input").removeClass("is-valid is-invalid");
        $(ele).find(".valid-feedback").text("");
        $(ele).find(".invalid-feedback").text("");
    }

    //模态框
    $("#add-emp-btn").click(function () {
        //重置模态框的表单
        reset_form("#add-emp-modal form");
        //发送ajax 获取部门信息
        getDept("#add-emp-modal select");
        $("#add-emp-modal").modal({
            backdrop: "static"
        })
    });

    function show_valid_msg(ele, status, msg) {
        var element = $(ele);
        element.removeClass("is-valid is-invalid");
        element.parent().removeClass("has-success has-error");
        element.next(".valid-feedback").text("");
        element.next(".valid-feedback").next(".invalid-feedback").text("");
        if (status === "success") {
            element.parent().addClass("has-success");
            element.addClass("is-valid");
            element.next(".valid-feedback").text(" " + msg);
        } else if (status === "error") {
            element.parent().addClass("has-error");
            element.addClass("is-invalid");
            element.next(".valid-feedback").next(".invalid-feedback").text(" " + msg);
        }
    }

    function validate_add_form() {
        //使用正则表达式校验
        var empName = $("#empAddName").val();
        var empEmail = $("#empAddEmail").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,10})$/;

        if (!regName.test(empName)) {
            show_valid_msg("#empName", "error", "用户名应该使用中文2-5位或者6-16位英文和数字组合! 正确例子：张三,abc");
            return false;
        } else {
            show_valid_msg("#empName", "success", "输入正确");
        }

        if (!regEmail.test(empEmail)) {
            show_valid_msg("#empEmail", "error", "邮箱格式不正确! 正确例子：xxxx@xxx.com");
            return false;
        } else {
            show_valid_msg("#empEmail", "success", "输入正确");
        }
        return true;
    }


    //保存员工
    $("#emp-save-btn").click(function () {
        console.info($("#add-emp-modal form").serialize());

        //数据校验
        if (!validate_add_form()) {
            return false;
        }
        //在数据输入合法的情况下 用户是否已存在
        if ($(this).attr("ajax-va") === "error") {
            return false;
        }

        //发送ajax请求保存员工
        $.ajax({
            url: "${path}/emps",
            type: "POST",
            data: $("#add-emp-modal form").serialize(),
            success: function (result) {
                /* console.info(result);*/
                if (result.code === 100) {
                    //关闭model
                    $('#add-emp-modal').modal('hide');
                    toPage(totalNum);
                } else {
                    //前端非法绕过 直接请求 使用后端验证 JSR303
                    //console.info(result);
                    if (result.extend.errorFile.email !== undefined) {
                        show_valid_msg("#empEmail", "error", result.extend.errorFile.email);
                    }
                    if (result.extend.errorFile.empName !== undefined) {
                        show_valid_msg("#empName", "error", result.extend.errorFile.empName);
                    }
                }
            }
        })
    });

    $("#empAddName").change(function () {
        //发送ajax请求数据库中是否存在该名称
        $.ajax({
            url: "${path}/checkuser",
            data: "empname=" + this.value,
            type: "POST",
            success: function (result) {
                console.info(result);
                if (result.code === 100) {
                    show_valid_msg("#empName", "success", "用户名可用!");
                    $("#emp-save-btn").attr("ajax-va", "success");
                } else {
                    show_valid_msg("#empName", "error", "用户名已存在!");
                    $("#emp-save-btn").attr("ajax-va", "error");
                }
            }
        })
    });

    function getEmp(id) {
        $.ajax({
            url: "${path}/emps/" + id,
            type: "GET",
            success: function (result) {
                // console.info(result);
                var e = result.extend.emp;
                console.info(e);
                $("#empUpdateName").text(e.empName);
                $("#empUpdateEmail").val(e.email);
                $("#update-emp-modal input[name=gender]").val([e.gender]);
                $("#update-emp-modal select").val([e.dId]);

            }
        })
    }

    /*
    * 创建之前绑定不了
    * 1.创建之后绑定
    * 2.使用on()绑定事件
    * */
    $(document).on("click", ".edit-btn", function () {
        //查询部门信息
        getDept("#update-emp-modal select");
        //查询员工信息
        getEmp($(this).attr("edit-id"));
        //员工ID 传递给modal按钮
        $("#emp-update-btn").attr("edit-id", $(this).attr("edit-id"));

        $("#update-emp-modal").modal({
            backdrop: "static"
        })
    });

    /**
     * 更新员工信息
     */
    $("#emp-update-btn").click(function () {

        //1.使用正则表达式校验邮箱
        var empEmail = $("#empUpdateEmail").val();
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,10})$/;

        console.info(empEmail);
        console.info(regEmail);

        if (!regEmail.test(empEmail)) {
            show_valid_msg("#empUpdateEmail", "error", "邮箱格式不正确! 正确例子：xxxx@xxx.com");
            return false;
        } else {
            show_valid_msg("#empUpdateEmail", "success", "输入正确");
        }

        //2.发送ajax请求保存更新员工数据
        $.ajax({
            url: "${path}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#update-emp-modal form").serialize(),
            success: function (result) {
                $('#update-emp-modal').modal('hide');
                toPage(currentPage);
            }
        })
    });

    $(document).on("click", ".delete-btn", function () {
        //1.是否删除 弹窗
        var empName = $(this).parents("tr").find("th:eq(2)").text();
        var removeId = $(this).attr("remove-id");
        //2.确认并删除
        if (confirm("是否需要删除" + empName + "?")) {
            $.ajax({
                url: "${path}/emps/" + removeId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    toPage(currentPage);
                }
            })
        }
    });

    $("#allCheck").click(function () {
        //attr 获取的checked是undefined
        //attr 适合自定义的属性值  使用prop获取原生的dom
        //alert($(this).prop("checked"));
        $(".check-item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check-item", function () {
        //alert($(".check-item:checked").length);
        if ($(".check-item:checked").length === $(".check-item").length) {
            $("#allCheck").prop("checked", true);
        }
    });

    //批量删除
    $("#remove-emp-btn").click(function () {

        var empNames = "";
        var removeIds = "";

        $.each($(".check-item:checked"), function () {
            empNames += $(this).parents("tr").find("th:eq(2)").text() + ",";
            removeIds += $(this).parents("tr").find("th:eq(1)").text() + "-";
        });

        empNames = empNames.substr(0, empNames.length - 1);
        removeIds = removeIds.substr(0, removeIds.length - 1);

        if (confirm("是否删除[" + empNames + "]?")) {
            $.ajax({
                url: "${path}/emps/" + removeIds,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    toPage(currentPage);
                    $("#allCheck").prop("checked", false);
                }
            });
        }

    });


</script>

</html>
