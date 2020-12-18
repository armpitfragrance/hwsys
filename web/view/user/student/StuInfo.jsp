<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/12/14
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>个人信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link href="../../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../../src/layuiadmin/style/admin.css" media="all">

    <link rel="stylesheet" type="text/css" href="https://www.huangwx.cn/css/sweetalert.css">
    <script type="text/javascript" src="https://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script type="text/javascript" src="../../../js/bootstrap.min.js"></script>
    <script>
        var stu_id;

        $(function () {
            stu_id = $("#stu_id").html();
            console.log(stu_id);
            initData();
            $("#btn_update").on("click", function () {
                // var userform = document.getElementById("userform");
                // var formData = new FormData(userform);
                var realname = $("#realname").val();
                var stu_no = $("#stu_no").val();
                var classname = $("#classname").val();
                var psw = $("#psw").val();
                var sex = $("#sex").val();
                var age = $("#age").val();
                var user_id = $("#user_id").val();
                $.ajax({
                    url: "/student.do",
                    data: {
                        action: "updateStu",
                        type: "学生",
                        realname: realname,
                        stu_no: stu_no,
                        classname:classname,
                        psw: psw,
                        sex: sex,
                        age: age,
                        id: stu_id,
                        user_id: user_id
                    },
                    type: "post",
                    datatype: "text",

                    success: function (data) {
                        if (data > 0) {
                            swal("保存成功", "", "success");
                        } else {
                            swal("保存失败", "", "error");
                        }
                    }
                });

            });
        });
        function initData() {

            $.ajax({
                url: "/student.do",
                data: {action: "queryOne", stu_id:stu_id},
                type: "get",
                datatype: "text",
                success: function (data) {
                    // console.log(data);
                    var obj = JSON.parse(data);
                    $("#realname").val(obj.realname);
                    $("#stu_no").val(obj.stu_no);
                    $("#classname").val(obj.classname);
                    $("#psw").val(obj.psw);
                    $("#sex").val(obj.sex);
                    $("#age").val(obj.age);
                    $("#user_id").val(obj.user_id);
                    console.log(obj.user_id);
                }
            });
        }
    </script>
</head>
<body layadmin-themealias="default" style="">
<%--隐藏标签：用于存放session中的值，用于js中使用--%>
<s hidden id="stu_id">9</s>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">

            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;text-align: center">
                <%--<button class="layui-btn layuiadmin-btn-admin" data-type="batchdel">删除</button>--%>
                <%--<button class="layui-btn layuiadmin-btn-admin" data-type="add" data-toggle="modal"--%>
                <%--data-target="#myModal">添加--%>
                <%--</button>--%>
                <h3>个人信息</h3>
            </div>

            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">

                    <div style="margin:50px auto; width: 300px;">
                        <form >
                            <input type="hidden" id="user_id">
                            <div class="layui-inline">
                                <label class="layui-form-label">姓名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="realname" id="realname" placeholder="请输入" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div><br><br>
                            <div class="layui-inline">
                                <label class="layui-form-label">学号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="stu_no" id="stu_no" placeholder="请输入" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div><br><br>
                            <div class="layui-inline">
                                <label class="layui-form-label">班级</label>
                                <div class="layui-input-block">
                                    <input type="text" name="classname" id="classname" placeholder="请输入" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div><br><br>
                            <div class="layui-inline">
                                <label class="layui-form-label">密码</label>
                                <div class="layui-input-block">
                                    <input type="password" name="psw" id="psw" placeholder="请输入" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div><br><br>
                            <div class="layui-inline">
                                <label class="layui-form-label">性别</label>
                                <div class="layui-input-block" style="width: 80px">
                                    <select class="layui-input" id="sex" name="sex">
                                        <option name="sex" class="sex" value="男">男</option>
                                        <option name="sex" class="sex" value="女">女</option>
                                    </select>
                                </div>
                            </div><br><br>
                            <div class="layui-inline">
                                <label class="layui-form-label">年龄</label>
                                <div class="layui-input-block">
                                    <input type="text" name="age" id="age" placeholder="请输入" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div><br><br>
                            <div  style="margin: 0 auto;width: 146.5px;">
                                <button type="button" class="layui-btn layui-btn-primary" onclick="initData()" >重置</button>
                                <button type="button" class="layui-btn layuiadmin-btn-admin" id="btn_update">保存</button>
                            </div>
                        </form>
                    </div>

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
    <script src="../../../src/layuiadmin/layui/layui.js" charset="utf-8"></script>
    <script>
        layui.use('form', function(){
            var form = layui.form;
            form.render();
        });
    </script>

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
