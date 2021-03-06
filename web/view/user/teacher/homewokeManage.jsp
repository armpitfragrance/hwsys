<%--
  Created by IntelliJ IDEA.
  User: youji
  Date: 2020/12/14
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>布置作业管理</title>
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
         * 布置作业管理
         * 功能:
         * 1.查询作业:
         *   a.初始化(按时间降序)
         *   b.条件查询(if:作业名称、截止提交时间)
         * 2.发布作业
         * 3.删除作业(id)
         * 4.修改作业(id)
         */
    </script>

    <script type="text/javascript">
        var currentPage = 1;//当前页数
        var oldPageTotal = 0;//总页数
        var course_id=<%=request.getParameter("c_id")%>;
        var t_id=<%=request.getParameter("t_id")%>

        $(function () {
            let name = $("#search-if-hwname").val();
            let end_time = $("#search-if-endtime").val();
            $.ajax({
                url: "/homework.do",
                data: {
                    action: "queryHomeworkByNameAndEndtime",
                    pageNum: "1",
                    course_id: course_id,
                    t_id: t_id,
                    name: name,
                    end_time: end_time
                },
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // console.log(data);
                    initDate(data);
                }
            });

            <!--布置作业-->
            $("#button-add-handup").on("click", function () {
                $("#addcourse_id").val(course_id);
                $("#addt_id").val(t_id);
                let formatter = new FormData(document.getElementById("add-notice-form"));
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

            <!--修改布置作业,提交修改-->
            $("#button-update-handup").on("click", function () {
                $("#updatecourse_id").val(course_id);
                $("#updatet_id").val(t_id);
                let formatter = new FormData(document.getElementById("update-notice-form"));
                $.ajax({
                    url: "/upload.do",
                    data: formatter,
                    type: "POST",
                    dataType: "json",
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        // console.log(data);
                        if (data > 0) {
                            swal("修改成功", "", "success");
                        } else {
                            swal("修改失败", "", "error");
                        }
                        $("#button-update-close").click();
                        changePage(currentPage);
                    }
                });
            });

            <!--搜索-->
            $("#button-search").on("click", function () {
                let name = $("#search-if-hwname").val();
                let end_time = $("#search-if-endtime").val();
                $.ajax({
                    url: "/homework.do",
                    data: {
                        action: "queryHomeworkByNameAndEndtime",
                        pageNum: 1,
                        course_id: course_id,
                        t_id: t_id,
                        name: name,
                        end_time: end_time
                    },
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
            if (dataObj.pageTotal != 1&&currentPage != 1) {
                $("#page-button-order").append('<a class="btn btn-default" onclick="changePage(1)">首页\<<</a>');
            }
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
            if (dataObj.pageTotal != 1&&currentPage != dataObj.pageTotal) {
                $("#page-button-order").append('<a class="btn btn-default" onclick="changePage(' + dataObj.pageTotal + ')">\>>最后一页</a>');
            }
            $(".page-button-order").attr("class", "pagebtn btn btn-default");
            $("#a" + currentPage).attr("class", "pagebtn btn btn-primary");

            <!--添加作业数据-->
            for (var a = 0; a < dataObj.items.length; a++) {
                var str = dataObj.items[a].end_time;
                str = str.substring(0, str.length - 2);
                console.log(str);
                var trNode = $("<tr></tr>");
                trNode.append("<td style='text-align: center'>" + dataObj.items[a].id + "</td>");
                trNode.append("<td>" + dataObj.items[a].name + "</td>");
                trNode.append("<td>" + dataObj.items[a].docu_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].t_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].c_name + "</td>");
                trNode.append("<td>" + str + "</td>");
                trNode.append("<td style=\"text-align: center\">\n" +
                    "<button class=\"upbtn layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\"  >" +
                    "<i class=\"layui-icon layui-icon-edit\"></i>编辑</button>\n" +
                    "<button class=\"delbtn layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                    "<i class=\"layui-icon layui-icon-delete\"></i>删除</button>\n" +
                    "<button class=\"conmmentbtn layui-btn layui-btn-success layui-btn-xs\" lay-event=\"edit\"  >" +
                    "<i class=\"layui-icon layui-icon-edit\"></i>评阅</button>\n"+
                    "</td>");
                $("#page-body").append(trNode);
            }

            <!--表格内操作-->
            <!--编辑-->
            $(".upbtn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[0]).html().trim();
                console.log(id);
                updateinitData(id);
                $("#updateModal").modal('show');
            });
            <!--删除-->
            $(".delbtn").on("click", function () {
                //获取要删除的数据的id
                let homework_id = $($(this).parents("tr").children("td")[0]).html().trim();
                console.log(homework_id);
                $.ajax({
                    url: "/homework.do",
                    data: {
                        action: "delete",
                        course_id: course_id,
                        homework_id: homework_id
                    },
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        console.log(data);
                        if (data > 0) {
                            swal("删除成功", "", "success");
                        } else {
                            swal("删除失败", "", "error");
                        }

                        changePage(currentPage);
                    }
                });
            });
            $(".conmmentbtn").on("click",function () {
                let homework_id = $($(this).parents("tr").children("td")[0]).html().trim();
                location.href="homeworkStuManage.jsp?homework_id="+homework_id+"&course_id="+course_id+"&t_id="+t_id;
            })


        };

        <!--跳转页面-->
        function changePage(i) {
            currentPage = i;
            let name = $("#search-if-hwname").val();
            let end_time = $("#search-if-endtime").val();
            $.ajax({
                url: "/homework.do",
                data: {
                    action: "queryHomeworkByNameAndEndtime",
                    pageNum: i,
                    course_id: course_id,
                    t_id: t_id,
                    name: name,
                    end_time: end_time
                },
                type: "GET",
                dataType: "text",
                success: function (data) {
                    let jsonObj = JSON.parse(data);
                    console.log(jsonObj);
                    if (currentPage > jsonObj.pageTotal) {
                        currentPage = currentPage - 1;
                        changePage(currentPage);
                    }
                    initDate(data);
                }
            });
        };

        <!--编辑页面初始化,数据回填-->
        function updateinitData(i) {
            $.ajax({
                url: "/homework.do",
                data: {action: "queryForOne", id: i},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    let dataObj = JSON.parse(data);
                    var str = dataObj.end_time;
                    str = str.substring(0, str.length - 11);
                    console.log(dataObj);
                    $("#updateid").val(dataObj.id);
                    $("#updatet_id").val(dataObj.t_id);
                    $("#updatename").val(dataObj.name);
                    $("#updateend_time").val(str);
                }
            });
        }
    </script>
</head>
<body layadmin-themealias="default" style="">

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0">作业名称</label>
                    <div class="layui-inline">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="search-if-hwname">
                    </div>
                </div>

                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0">截止日期</label>
                    <div class="layui-inline">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="search-if-endtime">
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
                <!--布置作业-->
                <button class="button-add layui-btn layuiadmin-btn-admin" data-toggle="modal" data-target="#addModal">
                    布置作业
                </button>
            </div>


            <!--发布公告(模态框)-->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">布置作业</h4>
                        </div>
                        <div class="modal-body">

                            <form id="add-notice-form">
                                <input type="hidden" name="action" value="homework-action-insert"/>
                                <input type="hidden" name="addcourse_id" id="addcourse_id" value=""/>
                                <input type="hidden" name="addt_id" id="addt_id" value=""/>
                                <label for="addname">作业名</label>
                                <input type="text" name="addname" id="addname" class="form-control"
                                       placeholder="请输入作业名"/><br/>

                                <label for="addfile">作业附件</label>
                                <input type="file" name="addfile" id="addfile" class="form-control"
                                       placeholder=""/><br/>

                                <label for="addend_time">截止日期</label>
                                <input type="text" name="addend_time" id="addend_time" class="form-control"
                                       placeholder="请输入截止提交时间"/><br/>


                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal" id="button-add-close">
                                关闭
                            </button>
                            <button type="button" class="layui-btn" id="button-add-handup">添加</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>


            <!--编辑模态框-->
            <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            </button>

                        </div>
                        <div class="modal-body">
                            <form id="update-notice-form" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="homework-action-update"/>
                                <input type="hidden" name="updateid" id="updateid"/>
                                <input type="hidden" name="updatecourse_id" id="updatecourse_id" value=""/>
                                <input type="hidden" name="updatet_id" id="updatet_id" value=""/>
                                <label for="updatename">作业名</label>
                                <input type="text" name="updatename" id="updatename" class="form-control"
                                       placeholder="请输入作业名"/><br/>

                                <label for="updatefile">作业附件</label>
                                <input type="file" name="updatefile" id="updatefile" class="form-control"
                                       placeholder=""/><br/>

                                <label for="updateend_time">截止提交时间</label>
                                <input type="text" name="updateend_time" id="updateend_time" class="form-control"
                                       placeholder="请输入截止提交时间"/><br/>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal" id="button-update-close">关闭
                            </button>
                            <button type="button" class="btn btn-primary" id="button-update-handup">
                                修改
                            </button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->


            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">
                    <div class="layui-table-header" style="overflow-x: auto">
                        <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%">
                            <thead>
                            <tr>

                                <th data-field="id" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-0"><span>编号</span>

                                    </div>
                                </th>
                                <th data-field="hw_name" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>作业名称</span></div>
                                </th>
                                <th data-field="docu_name" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-name"><span>文档名</span></div>
                                </th>
                                <th data-field="teacher_name" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-sno"><span>授课教师</span></div>
                                </th>
                                <th data-field="course_name" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>课程名称</span></div>
                                </th>
                                <th data-field="end_time" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>截止日期</span></div>
                                </th>
                                <th data-field="8">
                                    <div class="layui-table-cell laytable-cell-2-8" align="center"><span>操作</span></div>
                                </th>
                            </tr>
                            </thead>
                            <tbody id="page-body">

                            </tbody>
                        </table>


                    </div>

                    <style>
                        .layform-label-2-0 {
                            width: 100px;
                        }

                        .laytable-cell-2-0 {
                            width: 86px;
                        }

                        .laytable-cell-2-standard {
                            width: 217px;
                        }

                        .laytable-cell-2-sno {
                            width: 174px;
                        }

                        .laytable-cell-2-name {
                            width: 433px;
                        }

                        .laytable-cell-2-sex {
                            width: 217px;
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
                            width: 276px;
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
            var laydate2 = layui.laydate;
            var laydate3=layui.laydate;
            //执行一个laydate实例
            laydate.render({//指定元素
                elem: '#addend_time'
            });
            laydate2.render({
                elem: '#search-if-endtime'
            })
            laydate3.render({
                elem:'#updateend_time'
            })

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
