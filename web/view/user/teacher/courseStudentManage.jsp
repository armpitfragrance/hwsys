<%--
  Created by IntelliJ IDEA.
  User: youji
  Date: 2020/12/14
  Time: 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程学生管理</title>
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
         * 课程学生管理
         * 功能:
         * 1.查询:
         *   a.初始化:该课程的学生信息(id(course))-->根据课程id(sc)-->stu_id(sc、student)-->user_id(student、user)-->select...from user,student
         *   b.条件查询(if:stu_no(student))
         * 2.添加课程学生(添加学生选课)(stu_no(student)):stu_no(student)-->id(student)-->insert...into sc values...
         * 3.踢人(stu_id):delete from sc where stu_id=?,c_id=?
         */

    </script>

    <script type="text/javascript">
        var currentPage = 1;//当前页数
        var oldPageTotal = 0;//总页数
        var course_id=<%=request.getParameter("c_id")%>
            // console.log(course_id);
        $(function () {
            let stu_no = $("#search-if-sno").val();
            $.ajax({
                url: "/student.do",
                data: {action: "queryStudentByCourse", pageNum: "1", course_id: course_id,stu_no:stu_no},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // console.log(data);
                    initDate(data);
                }
            });
            <!--添加课程学生-->
            $("#button-add-handup").on("click", function () {
                $("#addcourse_id").val(course_id);
                let formatter = $("#add-notice-form").serialize();
                console.log($("#addcourse_id").val());
                $.ajax({
                    url: "/sc.do",
                    data: formatter,
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        if (data > 0) {
                            swal("添加成功", "", "success");
                        } else {
                            swal("添加失败", "", "error");
                        }
                        $("#button-add-close").click();
                        changePage(oldPageTotal);
                    }
                });
            });

            <!--搜索-->
            $("#button-search").on("click", function () {
                let stu_no = $("#search-if-sno").val();
                $.ajax({
                    url: "/student.do",
                    data: {action: "queryStudentByCourse", pageNum: 1, course_id: course_id, stu_no: stu_no},
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        changePage(1);
                    }
                });
            });

        });

        <!--初始化页面-->
        function initDate(data) {

            let index = 1;
            $("#page-body").empty();
            $("#page-total").empty();
            $("#page-which").empty();
            $("#page-button-order").empty();
            let dataObj = JSON.parse(data);
            // console.log(dataObj);
            oldPageTotal = dataObj.pageTotal;
            $("#page-which").append("第" + currentPage + "页");
            $("#page-total").append("<b>共" + dataObj.pageTotal + "页</b>");

            <!--下一页-->
            let nextbutton = "<button type='button' class='btn btn-default' id='next' onclick='changePage(currentPage+1)'>下一页</button> ";
            <!--上一页-->
            let lastbutton = "<button type='button' class='btn btn-default' id='last' onclick='changePage(currentPage-1)'>上一页</button> ";

            if (currentPage != 1) {
                //若不是第一页,添加上一页按钮
                $("#page-button-order").append(lastbutton);
            }
            if (currentPage <= 3) {
                index = 1;
            } else if (currentPage > 3 && currentPage < (dataObj.pageTotal - 2)) {
                index = dataObj.pageTotal - 4;
            }
            if (oldPageTotal <= 4) {
                for (let i = index; i <= oldPageTotal; i++) {
                    $("#page-button-order").append("<a id=\"a" + i + "\" class=\"pagebtn btn btn-default\"  onclick=\"changePage(" + i + ")\">" + i + "</a>");
                }
            } else if (oldPageTotal > 4) {
                let begin;
                let end;
                if (currentPage < 4) {
                    begin = 1;
                    end = 5;
                } else if ((oldPageTotal - currentPage) == 0) {
                    begin = currentPage - 4;
                    end = currentPage;
                } else if ((oldPageTotal - currentPage) <= 4) {
                    begin = currentPage - (4 - (oldPageTotal - currentPage));
                    end = oldPageTotal;
                } else if ((oldPageTotal - currentPage) > 4) {
                    begin = currentPage - 2;
                    end = currentPage + 2;
                }
                for (let i = begin; i <= end; i++) {
                    <!--页数-->
                    $("#page-button-order").append("<a id=\"a" + i + "\" class=\"pagebtn btn btn-default\"  onclick=\"changePage(" + i + ")\">" + i + "</a>");
                }
            }

            if (currentPage != dataObj.pageTotal) {
                //若不是最后一页,添加下一页按钮
                $("#page-button-order").append(nextbutton);
            }
            $(".page-button-order").attr("class", "pagebtn btn btn-default");
            $("#a" + currentPage).attr("class", "pagebtn btn btn-primary");

            <!--添加公告数据-->
            for (var a = 0; a < dataObj.items.length; a++) {
                var trNode = $("<tr></tr>");
                trNode.append("<td style='text-align: center'>" + dataObj.items[a].id + "</td>");
                trNode.append("<td>" + dataObj.items[a].stu_no + "</td>");
                trNode.append("<td>" + dataObj.items[a].realname + "</td>");
                trNode.append("<td>" + dataObj.items[a].sex + "</td>");
                trNode.append("<td>" + dataObj.items[a].age + "</td>");
                trNode.append("<td>" + dataObj.items[a].classname + "</td>");
                trNode.append("<td style=\"text-align: center\">\n" +
                    "<button class=\"delbtn layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                    "<i class=\"layui-icon layui-icon-delete\"></i>踢人</button>\n" +
                    "</td>");
                $("#page-body").append(trNode);
            }

            <!--表格内操作-->
            <!--踢人-->
            $(".delbtn").on("click", function () {
                //获取要删除的数据的id
                let stu_id = $($(this).parents("tr").children("td")[0]).html().trim();
                console.log(stu_id);
                $.ajax({
                    url: "/sc.do",
                    data: {action: "delete", course_id: course_id, stu_id: stu_id},
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        console.log(data);
                        if (data > 0) {
                            swal("踢人成功", "", "success");
                        } else {
                            swal("踢人失败", "", "error");
                        }

                        changePage(currentPage);
                    }
                });
            });


        };

        <!--跳转页面-->
        function changePage(i) {
            currentPage = i;
            let stu_no = $("#search-if-sno").val();
            $.ajax({
                url: "/student.do",
                data: {action: "queryStudentByCourse", pageNum: i, course_id: course_id, stu_no: stu_no},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // console.log(data);
                    let jsonObj = JSON.parse(data);
                    if (currentPage > jsonObj.pageTotal) {
                        currentPage = currentPage - 1;
                        changePage(currentPage);
                    }
                    initDate(data);
                }
            });
        };


    </script>
</head>
<body layadmin-themealias="default" style="">

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label">学号</label>
                    <div class="layui-inline">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="search-if-sno">
                    </div>
                    <div class="layui-inline">
                        <!--查询图片按钮-->
                        <button class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="LAY-user-back-search"
                                id="button-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                </div>


            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <!--添加按钮-->
                <button class="button-add layui-btn layuiadmin-btn-admin" data-toggle="modal" data-target="#addModal">
                    添加
                </button>
            </div>
            <!--发布公告(模态框)-->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">添加学生</h4>
                        </div>
                        <div class="modal-body">

                            <form id="add-notice-form">
                                <input type="hidden" name="action" value="insert"/>
                                <input type="hidden" name="addcourse_id" id="addcourse_id" value=""/>
                                <label for="addstu_no">学号</label>
                                <input type="text" name="addstu_no" id="addstu_no" class="form-control"
                                       placeholder="请输入学号"/><br/>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="button-add-close">
                                关闭
                            </button>
                            <button type="button" class="btn btn-primary" id="button-add-handup">添加</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>

            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">
                    <div class="layui-table-header">
                        <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%">
                            <thead>
                            <tr>


                                <th data-field="id" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-0"><span>编号</span>

                                    </div>
                                </th>

                                <th data-field="sno" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-sno"><span>学号</span>

                                    </div>
                                </th>
                                <th data-field="title" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-name"><span>姓名</span></div>
                                </th>
                                <th data-field="content" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-sex"><span>性别</span></div>
                                </th>
                                <th data-field="notice_time" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-age"><span>年龄</span></div>
                                </th>
                                <th data-field="" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-classname"><span>班级</span></div>
                                </th>
                                <th data-field="8" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-8" align="center"><span>操作</span></div>
                                </th>
                            </tr>
                            </thead>
                            <tbody id="page-body">

                            </tbody>
                        </table>


                    </div>

                    <style>.laytable-cell-2-0 {
                        width: 60px;
                    }
                    .laytable-cell-2-standard {
                        width: 150px;
                    }

                    .laytable-cell-2-sno {
                        width: 150px;
                    }

                    .laytable-cell-2-name {
                        width: 150px;
                    }

                    .laytable-cell-2-sex {
                        width: 150px;
                    }

                    .laytable-cell-2-age {
                        width: 150px;
                    }

                    .laytable-cell-2-classname {
                        width: 150px;
                    }

                    .laytable-cell-2-jointime {
                        width: 150px;
                    }

                    .laytable-cell-2-check {
                        width: 150px;
                    }

                    .laytable-cell-2-8 {
                        width: 190px;
                    }</style>
                </div>
                <div align="center">
                    <span id="page-which"></span>
                    <span id="page-button-order"></span>
                    <span id="page-total"></span>
                </div>
            </div>
        </div>

    </div>
    <script src="../../../src/layuiadmin/layui/layui.js" charset="utf-8"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
    <script>
        layui.use('laydate', function () {
            var laydate = layui.laydate;

            //执行一个laydate实例
            laydate.render({
                elem: '#search-if-time' //指定元素
            });
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


</body>
</html>
