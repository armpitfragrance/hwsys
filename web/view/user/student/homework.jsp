<%@ page import="com.entity.UserStudent" %><%--
  Created by IntelliJ IDEA.
  User: youji
  Date: 2020/12/17
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>作业</title>
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
         * 学生端:
         * 作业
         * 功能:
         * 1.查询:
         * a.初始化页面信息
         * b.条件查询老师布置的作业信息
         * 2.下载老师布置的作业附件
         * 3.提交作业
         */
    </script>

    <%
        HttpSession session1 = request.getSession();
        UserStudent student = (UserStudent) session1.getAttribute("user");
    %>

    <script type="text/javascript">
        var currentPage = 1;//当前页数
        var oldPageTotal = 0;//总页数
        var course_id=<%=request.getParameter("c_id")%>;
        var t_id=<%=request.getParameter("t_id")%>
        // var course_id = 1;
        // var t_id = 1;
        var stu_id=<%=student.getId()%>;
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
        function filepreview(path) {
            console.log(path);
            // location.href = "/preview?path=" + path;
            $.ajax({
                url: "/preview?path=" + path,
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // changepage(1);
                    if (data != "") {
                        window.open(data, 'PDF', 'width:50%;height:50%;top:100;left:100;');
                    } else {
                        swal("失败了", "暂时不支持预览该类型文件", "error");
                    }
                }
            });
        };
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
                var trNode = $("<tr></tr>");
                trNode.append("<td style='text-align: center'>" + dataObj.items[a].id + "</td>");
                trNode.append("<td>" + dataObj.items[a].name + "</td>");
                trNode.append("<td>" + dataObj.items[a].docu_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].t_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].c_name + "</td>");
                trNode.append("<td>" + str + "</td>");
                trNode.append("<td style=\"text-align: center\">\n" +
                    "<button class='previewbtn layui-btn layui-btn-normal layui-btn-xs' onclick='filepreview(\""+dataObj.items[a].docu_name+"\")'>" +
                    "<i class='layui-icon layui-icon-tips'></i>预览</button>\n" +
                    "<button class=\"download-btn layui-btn layui-btn-primary layui-btn-xs\" lay-event=\"edit\"  >" +
                    "<i class=\"layui-icon layui-icon-download-circle\"></i>下载</button>\n" +
                    "<button class=\"handup-btn layui-btn layui-btn-xs\" lay-event=\"edit\"  >" +
                    "<i class=\"layui-icon layui-icon-edit\"></i>提交</button>\n" +
                    "</td>");
                $("#page-body").append(trNode);
            }


            <!--表格内操作-->
            <!--下载附件-->
            $(".download-btn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[0]).html().trim();
                $.ajax({
                    url: "/homework.do",
                    data: {action: "queryPath", id: id},
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        console.log(data);
                        download(data);
                    }
                });
            })
            <!--跳转至提交作业页面-->
            $(".handup-btn").on("click", function () {
                let hw_id = $($(this).parents("tr").children("td")[0]).html().trim();
                location.href = "homeworkStu.jsp?hw_id=" + hw_id + "&course_id=" + course_id + "&stu_id=" + stu_id;
            })


        };<!--initData-->



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
        };<!--changePage-->

        <!--下载附件-->
        function download(pathname) {
            console.log(pathname)
            location.href="/download.do?path="+pathname;
        }<!--download-->


    </script>
</head>
<body layadmin-themealias="default" style="">

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0">作业名称</label>
                    <div class="layui-inline ">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="search-if-hwname">
                    </div>
                </div>

                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0">截止日期</label>
                    <div class="layui-inline">
                        <input type="text" name="search-if-endtime" placeholder="请输入" autocomplete="off" class="layui-input"
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
            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">
                    <div class="layui-table-header" style="overflow-x: auto">
                        <table cellspacing="0" cellpadding="0" border="0" class="layui-table" style="width: 100%">
                            <thead>
                            <tr>

                                <th data-field="id" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>编号</span>

                                    </div>
                                </th>
                                <th data-field="hw_name" class="layui-table-cell laytable-cell-2-sno" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-sno"><span>作业名称</span></div>
                                </th>
                                <th data-field="docu_name" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-sno"><span>文档名</span></div>
                                </th>
                                <th data-field="teacher_name">
                                    <div class="layui-table-cell laytable-cell-2-0"><span>授课教师</span></div>
                                </th>
                                <th data-field="course_name">
                                    <div class="layui-table-cell laytable-cell-2-0"><span>课程名称</span></div>
                                </th>
                                <th data-field="end_time" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-name"><span>截止日期</span></div>
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
                            width: 161px;
                        }

                        .laytable-cell-2-standard {
                            width: 96px;
                        }

                        .laytable-cell-2-sno {
                            width: 401px;
                        }

                        .laytable-cell-2-name {
                            width: 242px;
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
                            width: 307px;
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
            laydate.render({//指定元素
                elem: '#search-if-endtime'
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
