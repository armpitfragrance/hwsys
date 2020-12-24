。<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/12/10
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>学生信息管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../src/layuiadmin/style/admin.css" media="all">

    <link rel="stylesheet" type="text/css" href="https://www.huangwx.cn/css/sweetalert.css">
    <script type="text/javascript" src="https://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/bootstrap.min.js"></script>


    <script type="text/javascript">
        var realname;
        var stu_no;
        var currentPage = 1;
        var oldPageTotal = 0;
        var verifysno = 0;

        $(function () {
            realname = "";
            stu_no = "";
            $.ajax({
                url: "/student.do",
                data: {action: "query", pageNum: "1", realname: realname, stu_no: stu_no},
                type: "get",
                datatype: "text",
                success: function (data) {
                    // console.log(data);
                    initData(data);
                }
            });

            $("#stu_no").on("blur", function () {
                var stu_no = $("#stu_no").val();
                $.ajax({
                    url: "/student.do",
                    data: {action: "unique", stu_no: stu_no,},
                    type: "get",
                    datatype: "text",
                    success: function (data) {
                        if (data > 0) {
                            verifysno = 1;
                            // $("#verify-sno").val("学号已存在");
                        } else {
                            verifysno = 0;
                        }
                        console.log(data);
                        console.log(verifysno);
                    }
                });
            });

            $("#stu_no1").on("blur", function () {
                var stu_no = $("#stu_no1").val();
                $.ajax({
                    url: "/student.do",
                    data: {action: "unique", stu_no: stu_no,},
                    type: "get",
                    datatype: "text",
                    success: function (data) {
                        if (data > 0) {
                            verifysno = 1;
                            // $("#verify-sno").val("学号已存在");
                        } else {
                            verifysno = 0;
                        }
                        console.log(data);
                        console.log(verifysno);
                    }
                });
            });

            $("#btn_add").on("click", function () {
                // var userform = document.getElementById("userform");
                // var formData = new FormData(userform);
                var action = $("#action").val();
                var type = $("#type").val();
                var realname = $("#realname").val();
                var stu_no = $("#stu_no").val();
                var psw = $("#psw").val();
                var sex = $("#sex").val();
                var age = $("#age").val();
                var classname = $("#classname").val();

                $.ajax({
                    url: "/student.do",
                    data: {
                        action: action,
                        type: type,
                        realname: realname,
                        stu_no: stu_no,
                        psw: psw,
                        sex: sex,
                        age: age,
                        classname: classname,
                        verifysno: verifysno
                    },
                    type: "post",
                    datatype: "text",

                    success: function (data) {
                        if (data == 1) {
                            swal("添加成功", "", "success");
                        } else if (data == 2) {
                            swal("添加失败:学号已存在", "", "error");
                        } else {
                            swal("添加失败", "", "error");
                        }


                        $("#myModal").modal("hide");
                        changePage(currentPage);
                    }
                });

            });
            $("#btn_update").on("click", function () {
                // var userform = document.getElementById("userform");
                // var formData = new FormData(userform);
                var action = $("#action1").val();
                var type = $("#type1").val();
                var realname = $("#realname1").val();
                var stu_no = $("#stu_no1").val();
                var psw = $("#psw1").val();
                var sex = $("#sex1").val();
                var age = $("#age1").val();
                var classname = $("#classname1").val();
                var id = $("#id1").val();
                var user_id = $("#user_id1").val();
                $.ajax({
                    url: "/student.do",
                    data: {
                        action: action,
                        type: type,
                        realname: realname,
                        stu_no: stu_no,
                        psw: psw,
                        sex: sex,
                        age: age,
                        classname: classname,
                        id: id,
                        user_id: user_id,
                        verifysno: verifysno
                    },
                    type: "post",
                    datatype: "text",

                    success: function (data) {
                        if (data == 1) {
                            swal("修改成功", "", "success");
                        } else if (data == 2) {
                            swal("修改失败:学号已存在", "", "error");
                        } else {
                            swal("修改失败", "", "error");
                        }

                        $("#myModal1").modal("hide");
                        changePage(currentPage);
                    }
                });

            });

        });

        function initData(data) {
            let index = 1;
            $("#tbody1").empty();
            $("#pageBtn").empty()

            let jsonObj = JSON.parse(data);
            console.log(data);
            oldPageTotal = jsonObj.pageTotal;
            $("#pageBtn").append("<b id='pageTotal'></b>");
            $("#pageTotal").html("共" + jsonObj.pageTotal + "页")

            let nextbutton = "<button type='button' class='btn btn-default' id='next' onclick='changePage(currentPage+1)'>下一页</button> ";
            let lastbutton = "<button type='button' class='btn btn-default' id='last' onclick='changePage(currentPage-1)'>上一页</button> ";


            if (jsonObj.pageTotal != 1&&currentPage != 1) {
                $("#pageBtn").append('<a class="btn btn-default" onclick="changePage(1)">首页\<<</a>');
            }
            if (currentPage != 1) {
                $("#pageBtn").append(lastbutton);
            }

            if (oldPageTotal < 5) {
                for (i = index; i <= index + oldPageTotal - 1; i++) {
                    $("#pageBtn").append("<a id=\"a" + i + "\" class=\"pagebtn btn btn-default\"  onclick=\"changePage(" + i + ")\">" + i + "</a>");
                }
            } else {
                if (currentPage <= 3) {
                    index = 1;
                } else if (currentPage > 3 && currentPage < (jsonObj.pageTotal - 2)) {
                    index = currentPage - 2;
                } else if (currentPage >= (jsonObj.pageTotal - 2)) {
                    index = jsonObj.pageTotal - 4;
                }
                for (i = index; i <= index + 4; i++) {
                    $("#pageBtn").append("<a id=\"a" + i + "\" class=\"pagebtn btn btn-default\"  onclick=\"changePage(" + i + ")\">" + i + "</a>");
                }
            }

            if (currentPage != jsonObj.pageTotal) {
                $("#pageBtn").append(nextbutton);
            }
            if (jsonObj.pageTotal != 1&&currentPage!=jsonObj.pageTotal) {
                $("#pageBtn").append('<a class="btn btn-default" onclick="changePage(' + jsonObj.pageTotal + ')">\>>最后一页</a>');
            }
            // $("#pageBtn").append(nextbutton);
            // $("#a1").attr("class", "pagebtn btn btn-primary");

            $(".pagebtn").attr("class", "pagebtn btn btn-default");
            $("#a" + currentPage).attr("class", "pagebtn btn btn-primary");
            for (let i = 0; i < jsonObj.items.length; i++) {
                let trNode = $("<tr></tr>");
                trNode.append("<td style=\"text-align: center\">" + jsonObj.items[i].id + "</td>");
                trNode.append("<td>" + jsonObj.items[i].user_id + "</td>");
                trNode.append("<td>" + jsonObj.items[i].stu_no + "</td>");
                trNode.append("<td>" + jsonObj.items[i].psw + "</td>");
                trNode.append("<td>" + jsonObj.items[i].classname + "</td>");
                trNode.append("<td>" + jsonObj.items[i].realname + "</td>");
                trNode.append("<td>" + jsonObj.items[i].sex + "</td>");
                trNode.append("<td>" + jsonObj.items[i].age + "</td>");
                trNode.append("<td style=\"text-align: center\">" +
                    "<a class=\"upbtn layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\" data-toggle=\"modal\" data-target=\"#myModal1\"><i\n" +
                    "                                            class=\"upbtn layui-icon layui-icon-edit\" ></i>编辑</a>" +
                    "<a class=\"delbtn layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\"><i\n" +
                    "                                            class=\"layui-icon layui-icon-delete\"></i>删除</a>" +
                    "</td>")
                $("#tbody1").append(trNode);
            }
            ;
            $(".delbtn").on("click", function () {
                var user_id = $($(this).parents("tr").children("td")[1]).html().trim();
                console.log(user_id);
                $.ajax({
                    url: "/student.do",
                    data: {action: "deleteStu", user_id: user_id},
                    type: "post",
                    dataType: "text",
                    success: function (data) {
                        if (data > 0) {
                            swal("删除成功", "", "success");
                        } else {
                            swal("删除失败", "", "error");
                        }

                        changePage(currentPage);
                    }
                });
            });
            $(".upbtn").on("click", function () {
                var id = $($(this).parents("tr").children("td")[0]).html().trim();
                var user_id = $($(this).parents("tr").children("td")[1]).html().trim();
                var stu_no = $($(this).parents("tr").children("td")[2]).html().trim();
                var psw = $($(this).parents("tr").children("td")[3]).html().trim();
                var classname = $($(this).parents("tr").children("td")[4]).html().trim();
                var realname = $($(this).parents("tr").children("td")[5]).html().trim();
                var sex = $($(this).parents("tr").children("td")[6]).html().trim();
                var age = $($(this).parents("tr").children("td")[7]).html().trim();
                $("#id1").val(id);
                $("#user_id1").val(user_id);

                $("#realname1").val(realname);
                $("#stu_no1").val(stu_no);
                $("#psw1").val(psw);

                $("#sex1").val(sex);
                $("#age1").val(age);
                $("#classname1").val(classname);
            });
        }

        function query() {

        }

        function changePage(i) {

            currentPage = i;

            $.ajax({
                url: "/student.do",
                data: {action: "query", pageNum: i, realname: realname, stu_no: stu_no},
                type: "get",
                datatype: "text",
                success: function (data) {
                    let jsonObj = JSON.parse(data);
                    if (currentPage > jsonObj.pageTotal) {
                        currentPage = currentPage - 1;
                        changePage(currentPage);
                    }
                    initData(data);
                }
            });

        }

    </script>
</head>
<body layadmin-themealias="default" style="">
<%--添加模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加学生信息</h4>
            </div>

            <form id="userform">
                <input type="hidden" value="addStu" name="action" id="action">
                <input type="hidden" value="学生" name="type" id="type">
                <div class="modal-body">
                    <!--<span style="width: 80px;display:inline-block">用户名：</span>-->
                    <label for="realname">姓名</label>
                    <input type="text" name="realname" class="form-control" id="realname" placeholder="请输入真实姓名"><br>
                    <!--<span style="width: 80px;display:inline-block">密码：</span>-->
                    <label for="stu_no">学号</label><label id="verify-sno"></label>
                    <input type="text" name="stu_no" class="form-control" id="stu_no" placeholder="请输入学号"><br>
                    <label for="psw">密码</label>
                    <input type="password" name="psw" class="form-control" id="psw" placeholder="请输入密码"><br>
                    <!--<span style="width: 80px;display:inline-block">类型：</span>-->
                    <label for="sex">性别</label>
                    <select class="form-control" id="sex" name="sex">
                        <option name="sex" class="sex" value="男">男</option>
                        <option name="sex" class="sex" value="女">女</option>
                    </select>
                    <label for="age">年龄</label>
                    <input type="text" name="age" class="form-control" id="age" placeholder="请输入年龄"><br>
                    <label for="classname">班级</label>
                    <input type="text" name="classname" class="form-control" id="classname" placeholder="请输入班级名称"><br>

                    <!--<span style="width: 80px;display:inline-block">状态：</span><input type="radio" value="0" name="status">禁用&nbsp;<input type="radio" value="1" name="status">启用-->


                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">关闭</button>
                <button type="button" class="layui-btn layuiadmin-btn-admin" id="btn_add">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<%--编辑模态框--%>
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">编辑学生信息</h4>
            </div>

            <form id="userform2">
                <input type="hidden" value="updateStu" name="action" id="action1">
                <input type="hidden" value="学生" name="type" id="type1">
                <input type="hidden" name="id" id="id1">
                <input type="hidden" name="user_id" id="user_id1">
                <div class="modal-body">
                    <!--<span style="width: 80px;display:inline-block">用户名：</span>-->
                    <label for="realname1">姓名</label>
                    <input type="text" name="realname" class="form-control" id="realname1" placeholder="请输入真实姓名"><br>
                    <!--<span style="width: 80px;display:inline-block">密码：</span>-->
                    <label for="stu_no1">学号</label>
                    <input type="text" name="stu_no" class="form-control" id="stu_no1" placeholder="请输入学号"><br>
                    <label for="psw1">密码</label>
                    <input type="password" name="psw" class="form-control" id="psw1" placeholder="请输入密码"><br>
                    <!--<span style="width: 80px;display:inline-block">类型：</span>-->
                    <label for="sex1">性别</label>
                    <select class="form-control" id="sex1" name="sex">
                        <option name="sex" class="sex" value="男">男</option>
                        <option name="sex" class="sex" value="女">女</option>
                    </select>
                    <label for="age1">年龄</label>
                    <input type="text" name="age" class="form-control" id="age1" placeholder="请输入年龄"><br>
                    <label for="classname1">班级</label>
                    <input type="text" name="classname" class="form-control" id="classname1" placeholder="请输入班级名称"><br>

                    <!--<span style="width: 80px;display:inline-block">状态：</span><input type="radio" value="0" name="status">禁用&nbsp;<input type="radio" value="1" name="status">启用-->


                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">关闭</button>
                <button type="button" class="layui-btn layuiadmin-btn-admin" id="btn_update">编辑</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <form id="queryform">


                    <div class="layui-inline">
                        <label class="layui-form-label">姓名</label>
                        <div class="layui-inline">
                            <input id="realname_q" type="text" name="realname" placeholder="请输入" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">学号</label>
                        <div class="layui-inline">
                            <input id="stu_no_q" type="text" name="stu_no" placeholder="请输入" autocomplete="off"
                                   class="layui-input">
                        </div>
                        <div class="layui-inline">
                            <button id="btn_query" type="button" class="layui-btn layuiadmin-btn-admin" lay-submit=""
                                    lay-filter="LAY-user-back-search">
                                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                            </button>
                            <script>
                                $("#btn_query").click(function () {
                                    realname = $("#realname_q").val();
                                    stu_no = $("#stu_no_q").val();
                                    $.ajax({
                                        url: "/student.do",
                                        data: {action: "query", realname: realname, stu_no: stu_no, pageNum: 1},
                                        type: "post",
                                        datatype: "text",
                                        success: function (data) {
                                            // alert(data);
                                            initData(data);
                                        }
                                    });
                                });
                            </script>
                        </div>
                    </div>


                </form>
            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-admin" data-toggle="modal" data-target="#myModal">添加</button>
            </div>

            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">
                    <div class="layui-table-header" style="overflow-x: auto; ">
                        <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%">
                            <thead>
                            <tr>

                                <th data-field="id" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-id"><span>编号</span>

                                    </div>
                                </th>
                                <th data-field="user_id" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-loginname"><span>用户编号</span></div>
                                </th>
                                <th data-field="stu_no" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>学号</span></div>
                                </th>
                                <th data-field="psw" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>密码</span></div>
                                </th>
                                <th data-field="classname" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>班级</span></div>
                                </th>
                                <th data-field="realname" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-email"><span>姓名</span></div>
                                </th>
                                <th data-field="sex" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-role"><span>性别</span></div>
                                </th>
                                <th data-field="age" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-jointime"><span>年龄</span>

                                    </div>
                                </th>
                                <th data-field="8" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-8" align="center"><span>操作</span></div>
                                </th>
                            </tr>
                            </thead>
                            <tbody id="tbody1">
                            <%--<tr>--%>
                            <%--<td>--%>
                            <%--<div class="layui-table-cell laytable-cell-2-0 laytable-cell-checkbox">--%>
                            <%--<input type="checkbox" name="layTableCheckbox" lay-skin="primary" lay-filter="layTableAllChoose">--%>
                            <%--<div class="layui-unselect layui-form-checkbox" lay-skin="primary">--%>
                            <%--<i class="layui-icon layui-icon-ok"></i>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <%--</td>--%>
                            <%--<td>1</td>--%>
                            <%--<td>001</td>--%>
                            <%--<td>001</td>--%>
                            <%--<td>123</td>--%>
                            <%--<td>数学一班</td>--%>
                            <%--<td>张三</td>--%>
                            <%--<td>男</td>--%>
                            <%--<td>34</td>--%>
                            <%--<td style="text-align: center">--%>
                            <%--<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i--%>
                            <%--class="layui-icon layui-icon-edit"></i>编辑</a>--%>
                            <%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i--%>
                            <%--class="layui-icon layui-icon-delete"></i>删除</a>--%>
                            <%--</td>--%>
                            <%--</tr>--%>
                            </tbody>
                        </table>
                    </div>
                    <div align="center" id="pageBtn">
                        <style>
                            .laytable-cell-2-0 {
                                width: 45px;
                            }

                            .laytable-cell-2-id {
                                width: 80px;
                            }

                            .laytable-cell-2-loginname {
                                width: 140px;
                            }

                            .laytable-cell-2-telphone {
                                width: 140px;
                            }

                            .laytable-cell-2-email {
                                width: 140px;
                            }

                            .laytable-cell-2-role {
                                width: 140px;
                            }

                            .laytable-cell-2-jointime {
                                width: 140px;
                            }

                            .laytable-cell-2-check {
                                width: 140px;
                            }

                            .laytable-cell-2-8 {
                                width: 190px;
                            }</style>
                    </div>
                </div>
            </div>
        </div>


        <style id="LAY_layadmin_theme">.layui-side-menu, .layadmin-pagetabs .layui-tab-title li:after, .layadmin-pagetabs .layui-tab-title li.layui-this:after, .layui-layer-admin .layui-layer-title, .layadmin-side-shrink .layui-side-menu .layui-nav > .layui-nav-item > .layui-nav-child {
            background-color: #20222A !important;
        }

        .layui-nav-tree .layui-this, .layui-nav-tree .layui-this > a, .layui-nav-tree .layui-nav-child dd.layui-this, .layui-nav-tree .layui-nav-child dd.layui-this a {
            background-color: #009688 !important;
        }

        .layui-layout-admin .layui-logo {
            background-color: #20222A !important;
        }</style>
        <div class="layui-layer-move">
        </div>
    </div>


</div>
</body>
</html>
