<%--
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
    <title>教师信息管理</title>
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

    <script>
        var realname;
        var t_no;
        var currentPage = 1;
        var oldPageTotal = 0;

        $(function () {
            realname = "";
            t_no = "";
            $.ajax({
                url: "/teacher.do",
                data: {action: "query", pageNum: "1",realname:realname,t_no:t_no},
                type: "get",
                datatype: "text",
                success: function (data) {
                    // console.log(data);

                    initData(data);
                }
            });
            $("#btn_add").on("click", function () {
                // var userform = document.getElementById("userform");
                // var formData = new FormData(userform);
                var action = $("#action").val();
                var type = $("#type").val();
                var realname = $("#realname").val();
                var t_no = $("#t_no").val();
                var psw = $("#psw").val();
                var sex = $("#sex").val();
                var age = $("#age").val();
                $.ajax({
                    url: "/teacher.do",
                    data: {action: action, type: type, realname: realname, t_no: t_no, psw: psw, sex: sex, age: age},
                    type: "post",
                    datatype: "text",

                    success: function (data) {
                        if (data > 0) {
                            swal("添加成功", "", "success");
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
                var t_no = $("#t_no1").val();
                var psw = $("#psw1").val();
                var sex = $("#sex1").val();
                var age = $("#age1").val();
                var id = $("#id1").val();
                var user_id = $("#user_id1").val();
                $.ajax({
                    url: "/teacher.do",
                    data: {
                        action: action,
                        type: type,
                        realname: realname,
                        t_no: t_no,
                        psw: psw,
                        sex: sex,
                        age: age,
                        id: id,
                        user_id: user_id
                    },
                    type: "post",
                    datatype: "text",

                    success: function (data) {
                        if (data > 0) {
                            swal("修改成功", "", "success");
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
            // $("#pageBtn").append(nextbutton);
            // $("#a1").attr("class", "pagebtn btn btn-primary");

            $(".pagebtn").attr("class", "pagebtn btn btn-default");
            $("#a" + currentPage).attr("class", "pagebtn btn btn-primary");
            for (let i = 0; i < jsonObj.items.length; i++) {
                let trNode = $("<tr></tr>");
                trNode.append("<td>\n" +
                    "                                    <div class=\"layui-table-cell laytable-cell-2-0 laytable-cell-checkbox\">\n" +
                    "                                        <input type=\"checkbox\" name=\"layTableCheckbox\" lay-skin=\"primary\" lay-filter=\"layTableAllChoose\">\n" +
                    "                                        <div class=\"layui-unselect layui-form-checkbox\" lay-skin=\"primary\">\n" +
                    "                                            <i class=\"layui-icon layui-icon-ok\"></i>\n" +
                    "                                        </div>\n" +
                    "                                    </div>\n" +
                    "                                </td>");
                trNode.append("<td>" + jsonObj.items[i].id + "</td>");
                trNode.append("<td>" + jsonObj.items[i].user_id + "</td>");
                trNode.append("<td>" + jsonObj.items[i].t_no + "</td>");
                trNode.append("<td>" + jsonObj.items[i].psw + "</td>");
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
                var user_id = $($(this).parents("tr").children("td")[2]).html().trim();
                console.log(user_id);
                $.ajax({
                    url: "/teacher.do",
                    data: {action: "deleteT", user_id: user_id},
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
                var id = $($(this).parents("tr").children("td")[1]).html().trim();
                var user_id = $($(this).parents("tr").children("td")[2]).html().trim();
                var t_no = $($(this).parents("tr").children("td")[3]).html().trim();
                var psw = $($(this).parents("tr").children("td")[4]).html().trim();

                var realname = $($(this).parents("tr").children("td")[5]).html().trim();
                var sex = $($(this).parents("tr").children("td")[6]).html().trim();
                var age = $($(this).parents("tr").children("td")[7]).html().trim();
                $("#id1").val(id);
                $("#user_id1").val(user_id);

                $("#realname1").val(realname);
                $("#t_no1").val(t_no);
                $("#psw1").val(psw);

                $("#sex1").val(sex);
                $("#age1").val(age);
            });
        }

        function query() {

        }

        function changePage(i) {

            currentPage = i;

            $.ajax({
                url: "/teacher.do",
                data: {action: "query", pageNum: i,realname:realname,t_no:t_no},
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
                <h4 class="modal-title" id="myModalLabel">添加老师信息</h4>
            </div>

            <form id="userform">
                <input type="hidden" value="addT" name="action" id="action">
                <input type="hidden" value="老师" name="type" id="type">
                <div class="modal-body">
                    <!--<span style="width: 80px;display:inline-block">用户名：</span>-->
                    <label for="realname">姓名</label>
                    <input type="text" name="realname" class="form-control" id="realname" placeholder="请输入真实姓名"><br>
                    <!--<span style="width: 80px;display:inline-block">密码：</span>-->
                    <label for="t_no">工号</label>
                    <input type="text" name="t_no" class="form-control" id="t_no" placeholder="请输入工号"><br>
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
                <h4 class="modal-title" id="myModalLabel1">编辑老师信息</h4>
            </div>

            <form id="userform2">
                <input type="hidden" value="updateT" name="action" id="action1">
                <input type="hidden" value="老师" name="type" id="type1">
                <input type="hidden" name="id" id="id1">
                <input type="hidden" name="user_id" id="user_id1">
                <div class="modal-body">
                    <!--<span style="width: 80px;display:inline-block">用户名：</span>-->
                    <label for="realname1">姓名</label>
                    <input type="text" name="realname" class="form-control" id="realname1" placeholder="请输入真实姓名"><br>
                    <!--<span style="width: 80px;display:inline-block">密码：</span>-->
                    <label for="t_no1">工号</label>
                    <input type="text" name="t_no" class="form-control" id="t_no1" placeholder="请输入工号"><br>
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
                <form>

                    <div class="layui-inline">
                        <label class="layui-form-label">姓名</label>
                        <div class="layui-input-block">
                            <input type="text" name="realname" id="realname_q" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">工号</label>
                        <div class="layui-input-block">
                            <input type="text" name="t_no" id="t_no_q" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <button type="button" id="btn_query" class="layui-btn layuiadmin-btn-admin" lay-submit=""
                                lay-filter="LAY-user-back-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                        <script>
                            $("#btn_query").click(function () {
                                realname=$("#realname_q").val();
                                t_no=$("#t_no_q").val();
                                $.ajax({
                                    url: "/teacher.do",
                                    data: {action:"query", realname: realname, t_no: t_no,pageNum: 1},
                                    type: "post",
                                    datatype: "text",
                                    success: function (data) {
                                        alert(data);
                                        initData(data);
                                    }
                                });
                            });
                        </script>
                    </div>

                </form>
            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-admin" data-type="batchdel">删除</button>
                <button class="layui-btn layuiadmin-btn-admin" data-type="add" data-toggle="modal"
                        data-target="#myModal">添加
                </button>
            </div>

            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">
                    <div class="layui-table-header" style="overflow-x: auto; ">
                        <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%">
                            <thead>
                            <tr>
                                <th data-field="0" data-unresize="true">
                                    <div class="layui-table-cell laytable-cell-2-0 laytable-cell-checkbox"><input
                                            type="checkbox" name="layTableCheckbox" lay-skin="primary"
                                            lay-filter="layTableAllChoose">
                                        <div class="layui-unselect layui-form-checkbox" lay-skin="primary">
                                            <i class="layui-icon layui-icon-ok"></i>
                                        </div>
                                    </div>
                                </th>
                                <th data-field="id">
                                    <div class="layui-table-cell laytable-cell-2-id"><span>ID</span>
                                        <span class="layui-table-sort layui-inline">
                                            <i class="layui-edge layui-table-sort-asc"></i>
                                            <i class="layui-edge layui-table-sort-desc"></i>
                                        </span>
                                    </div>
                                </th>
                                <th data-field="user_id">
                                    <div class="layui-table-cell laytable-cell-2-loginname"><span>用户编号</span></div>
                                </th>
                                <th data-field="t_no">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>工号</span></div>
                                </th>
                                <th data-field="psw">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>密码</span></div>
                                </th>
                                <th data-field="realname">
                                    <div class="layui-table-cell laytable-cell-2-email"><span>姓名</span></div>
                                </th>
                                <th data-field="sex">
                                    <div class="layui-table-cell laytable-cell-2-role"><span>性别</span></div>
                                </th>
                                <th data-field="age">
                                    <div class="layui-table-cell laytable-cell-2-jointime"><span>年龄</span>
                                        <span class="layui-table-sort layui-inline">
                                            <i class="layui-edge layui-table-sort-asc"></i>
                                            <i class="layui-edge layui-table-sort-desc"></i>
                                        </span>
                                    </div>
                                </th>
                                <th data-field="8">
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
                        <style>.laytable-cell-2-0 {
                            width: 45px;
                        }

                        .laytable-cell-2-id {
                            width: 80px;
                        }

                        .laytable-cell-2-loginname {
                            width: 160px;
                        }

                        .laytable-cell-2-telphone {
                            width: 160px;
                        }

                        .laytable-cell-2-email {
                            width: 160px;
                        }

                        .laytable-cell-2-role {
                            width: 160px;
                        }

                        .laytable-cell-2-jointime {
                            width: 160px;
                        }

                        .laytable-cell-2-check {
                            width: 160px;
                        }

                        .laytable-cell-2-8 {
                            width: 210px;
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


</body>
</html>
