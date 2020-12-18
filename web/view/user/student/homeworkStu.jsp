<%--
  Created by IntelliJ IDEA.
  User: youji
  Date: 2020/12/17
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>作业详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://www.huangwx.cn/css/sweetalert.css">
    <script type="text/javascript" src="https://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../../../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../../src/layuiadmin/style/admin.css" media="all">
    <script>
        /**
         * 作业详情页
         * 功能:
         * 1.查看作业信息
         * 2.查看教师评阅信息
         * 3.提交作业
         */
    </script>
    <script type="text/javascript">
        var hw_id =<%=request.getParameter("hw_id")%>;
        var stu_id =<%=request.getParameter("stu_id")%>;
        $(function () {
            initData();
            <!--提交-->
            $("#handup-btn").on("click", function () {
                $("#hw_id").val(hw_id);
                $("#stu_id").val(stu_id);
                $("#action").val("student-homework-stu-action-insert");
                let formatter = new FormData(document.getElementById("homework-form"));
                console.log(formatter);
                $.ajax({
                    url: "/upload.do",
                    data: formatter,
                    type: "POST",
                    dataType: "json",
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        console.log(data);
                        if (data==1) {
                            swal("提交成功", "", "success");
                            initData();
                        }else if(data==2){
                            swal("请勿重复提交","","error");
                        }else if(data==3){
                            swal("已到截止日期,禁止提交","","error");
                        } else {
                            swal("提交失败", "", "error");
                        }
                    }
                });
            }); <!--提交-->

            <!--修改-->
            $("#update-btn").on("click", function () {
                $("#hw_id").val(hw_id);
                $("#stu_id").val(stu_id);
                $("#action").val("student-homework-stu-action-update");
                console.log($("#"))
                let formatter = new FormData(document.getElementById("homework-form"));
                console.log(formatter);
                $.ajax({
                    url: "/upload.do",
                    data: formatter,
                    type: "POST",
                    dataType: "json",
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        console.log(data);
                        if(data==3){
                            swal("已到截止日期,禁止修改","","error");
                        }else if (data == 1) {
                            swal("修改成功", "", "success");
                            initData();
                        } else {
                            swal("修改失败", "", "error");
                        }
                    }
                });
            });<!--修改-->
        });

        /**
         * 回填作业信息
         */
        function initData() {
            $.ajax({
                url: "/homeworkstu.do",
                data: {
                    action: "queryHomeworkStuByhw_idAndStu_id",
                    hw_id: hw_id,
                    stu_id: stu_id,
                },
                type: "GET",
                dataType: "text",
                success: function (data) {
                    console.log(data);
                    let dataObj = JSON.parse(data);
                    console.log(dataObj);
                    if(dataObj!=null){
                        $("#homework_stu_id").val(dataObj.id);
                        $("#homework_name").val(dataObj.hw_name);
                        $("#handup_time").val(dataObj.handup_time);
                        $("#t_name").val(dataObj.t_name);
                        $("#correct").val(dataObj.correct);
                        $("#score").val(dataObj.score);
                        $("#status").val(dataObj.status);
                        $("#correct_time").val(dataObj.correct_time);
                    }
                }
            });
        };


    </script>
</head>
<body layadmin-themealias="default" style="">
<%--隐藏标签：用于存放session中的值，用于js中使用--%>
<s hidden id="t_id">25</s>
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
                <h3>作业信息</h3>
            </div>

            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">

                    <div style="margin:50px auto; width: 300px;">
                        <form id="homework-form">
                            <input type="hidden" id="user_id">
                            <input type="hidden" name="homework_stu_id" id="homework_stu_id">
                            <input type="hidden" name="hw_id" id="hw_id">
                            <input type="hidden" name="stu_id" id="stu_id">
                            <input type="hidden" name="action" id="action" value="">
                            <div class="layui-inline">
                                <label class="layui-form-label">作业</label>
                                <div class="layui-input-block">
                                    <input type="text" name="homework_name" id="homework_name" autocomplete="off"
                                           class="layui-input" disabled>
                                </div>
                            </div>
                            <br><br>

                            <div class="layui-inline">
                                <label class="layui-form-label">文件</label>
                                <div class="layui-input-block">
                                    <input type="file" name="handup_file" id="handup_file" placeholder="请选择文件"
                                           autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                            <br><br>

                            <div class="layui-inline">
                                <label class="layui-form-label">提交时间</label>
                                <div class="layui-input-block">
                                    <input type="text" name="handup_time" id="handup_time" autocomplete="off"
                                           class="layui-input" disabled>
                                </div>
                            </div>
                            <br><br>

                            <div class="layui-inline">
                                <label class="layui-form-label">评阅教师</label>
                                <div class="layui-input-block">
                                    <input type="text" name="t_name" id="t_name" autocomplete="off"
                                           class="layui-input" disabled>
                                </div>
                            </div>
                            <br><br>

                            <div class="layui-inline">
                                <label class="layui-form-label">评阅意见</label>
                                <div class="layui-input-block">
                                    <input type="text" name="correct" id="correct" autocomplete="off"
                                           class="layui-input" disabled>
                                </div>
                            </div>
                            <br><br>

                            <div class="layui-inline">
                                <label class="layui-form-label">评阅分数</label>
                                <div class="layui-input-block">
                                    <input type="text" name="score" id="score" autocomplete="off"
                                           class="layui-input" disabled>
                                </div>
                            </div>
                            <br><br>

                            <div class="layui-inline">
                                <label class="layui-form-label">评阅状态</label>
                                <div class="layui-input-block">
                                    <input type="text" name="status" id="status" autocomplete="off"
                                           class="layui-input" disabled>
                                </div>
                            </div>
                            <br><br>

                            <div class="layui-inline">
                                <label class="layui-form-label">评阅时间</label>
                                <div class="layui-input-block">
                                    <input type="text" name="correct_time" id="correct_time" autocomplete="off"
                                           class="layui-input" disabled>
                                </div>
                            </div>
                            <br><br>
                            <div style="margin: 0 auto;width: 300px;">
                                &emsp;&emsp;&emsp;
                                <button type="button" class="layui-btn layuiadmin-btn-admin" id="handup-btn">提交</button>

                                <button type="button" class="layui-btn layuiadmin-btn-admin" id="update-btn">修改</button>

                            </div>
                        </form>
                    </div>

                    <style>
                        .layui-form-label {
                            width: 100px;
                        }
                    </style>
                </div>
            </div>
        </div>
    </div>
    <script src="../../../src/layuiadmin/layui/layui.js" charset="utf-8"></script>
    <script>
        layui.use('form', function () {
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
