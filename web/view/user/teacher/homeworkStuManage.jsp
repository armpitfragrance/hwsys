<%--
  Created by IntelliJ IDEA.
  User: youji
  Date: 2020/12/14
  Time: 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>评阅作业管理</title>
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
         * 评阅作业管理
         * 功能:
         * 1.查询:
         *   a.初始化
         *   b.条件查询(if:评阅状态,布置作业(作业名称、截止时间))
         * 2.修改(评阅)
         */


    </script>

    <script type="text/javascript">
        var currentPage = 1;//当前页数
        var oldPageTotal = 0;//总页数
        var course_id=<%=request.getParameter("course_id")%>;//传进来的课程id
        var homework_id=<%=request.getParameter("homework_id")%>;
        var t_id=<%=request.getParameter("t_id")%>;

        $(function () {
            let hw_name = $("#search-if-hwname").val();
            let end_time = $("#search-if-endtime").val();
            let correct_status = $("#search-if-status option:selected").text();
            console.log(correct_status);
            $.ajax({
                url: "/homeworkstu.do",
                data: {
                    action: "queryHomeworkStuByHwNameAndEndtimeAndStatus",
                    pageNum: "1",
                    course_id:course_id,
                    homework_id:homework_id,
                    hw_name:hw_name,
                    end_time: end_time,
                    correct_status:correct_status
                },
                type: "GET",
                dataType: "text",
                success: function (data) {
                    console.log(data);
                    initDate(data);
                }
            });

            <!--评阅作业,提交评阅-->
            $("#button-update-handup").on("click", function () {
                $("#updatecourse_id").val(course_id);
                $("#updatet_id").val(t_id);
                let formatter = new FormData(document.getElementById("correct-form"));
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
                let hw_name = $("#search-if-hwname").val();
                let end_time = $("#search-if-endtime").val();
                let correct_status = $("#search-if-status option:selected").text();
                $.ajax({
                    url: "/homeworkstu.do",
                    data: {
                        action: "queryHomeworkStuByHwNameAndEndtimeAndStatus",
                        pageNum: 1,
                        course_id:course_id,
                        homework_id:homework_id,
                        hw_name:hw_name,
                        end_time: end_time,
                        correct_status:correct_status
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

            <!--添加作业数据-->
            for (var a = 0; a < dataObj.items.length; a++) {
                var trNode = $("<tr></tr>");
                trNode.append("<td></td>");
                trNode.append("<td>" + dataObj.items[a].id + "</td>");
                trNode.append("<td>" + dataObj.items[a].hw_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].stu_no + "</td>");
                trNode.append("<td>" + dataObj.items[a].stu_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].docu_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].end_time + "</td>");
                trNode.append("<td>" + dataObj.items[a].handup_time + "</td>");
                trNode.append("<td>" + dataObj.items[a].t_name + "</td>");
                trNode.append("<td>" + dataObj.items[a].correct + "</td>");
                trNode.append("<td>" + dataObj.items[a].score + "</td>");
                trNode.append("<td>" + dataObj.items[a].status + "</td>");
                trNode.append("<td>" + dataObj.items[a].correct_time + "</td>");

                trNode.append("<td style=\"text-align: center\">\n" +
                    "<button class=\"upbtn layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\"  >" +
                    "<i class=\"layui-icon layui-icon-edit\"></i>评阅</button>\n"
                    + "<button class=\"download-btn layui-btn-primary layui-btn-xs\" lay-event=\"edit\"  >" +
                    "<i class=\"layui-icon layui-icon-download-circle\"></i></button>\n"
                    + "</td>");
                $("#page-body").append(trNode);
            }

            <!--表格内操作-->
            <!--评阅(修改)-->
            $(".upbtn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[1]).html().trim();
                updateinitData(id);
                $("#correctModal").modal('show');
            });
            <!--下载附件-->
            $(".download-btn").on("click",function () {
                let id = $($(this).parents("tr").children("td")[1]).html().trim();
                $.ajax({
                    url: "/homeworkstu.do",
                    data: {action: "queryPath", id: id},
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        console.log(data);
                        download(data);
                    }
                });
            })
        };

        <!--跳转页面-->
        function changePage(i) {
            currentPage = i;
            let hw_name = $("#search-if-hwname").val();
            let end_time = $("#search-if-endtime").val();
            let correct_status = $("#search-if-status option:selected").text();
            $.ajax({
                url: "/homeworkstu.do",
                data: {
                    action: "queryHomeworkStuByHwNameAndEndtimeAndStatus",
                    pageNum: i,
                    course_id:course_id,
                    homework_id:homework_id,
                    hw_name:hw_name,
                    end_time: end_time,
                    correct_status:correct_status
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
                url: "/homeworkstu.do",
                data: {action: "queryForOne", id: i},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    let dataObj = JSON.parse(data);
                    console.log(dataObj);
                    $("#homework_stu_id").val(dataObj.id);
                    $("#correct").val(dataObj.correct);
                    $("#correct_score").val(dataObj.score);
                    $("#correct_time").val(dataObj.correct_time);
                }
            });
        }
        function download(pathname) {
            console.log(pathname)
            location.href="http://localhost/download.do?path="+pathname;
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
                    <div class="layui-input-block">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="search-if-hwname">
                    </div>
                </div>

                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0">截止日期</label>
                    <div class="layui-input-block">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="search-if-endtime">
                    </div>
                </div>

                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0">评阅状态</label>
                    <div class="layui-input-block" style="width: 100px;">
                        <select name="status" class="select-status" lay-verify="" id="search-if-status">
                            <option value="correct">请选择</option>
                            <option value="is_correct">已评阅</option>
                            <option value="is_not_correct">未评阅</option>
                        </select>
                    </div>
                </div>

                <div class="layui-inline">
                    <!--查询图片按钮-->
                    <button class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="LAY-user-back-search"
                            id="button-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>

                <!--编辑模态框-->
                <div class="modal fade" id="correctModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                </button>

                            </div>
                            <div class="modal-body">
                                <form id="correct-form" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="homework-stu-action-update"/>
                                    <input type="hidden" name="homework_stu_id" id="homework_stu_id" value=""/>
                                    <label for="correct">评阅意见</label>
                                    <input type="text" name="correct" id="correct" class="form-control"
                                           placeholder="请输入评阅意见"/><br/>

                                    <label for="correct_score">分数</label>
                                    <input type="text" name="correct_score" id="correct_score" class="form-control"
                                           placeholder="请打分"/><br/>

                                    <label for="correct_time">评阅时间</label>
                                    <input type="text" name="correct_time" id="correct_time" class="form-control"
                                           placeholder="请输入截至提交时间"/><br/>

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
            </div>
        </div>
        <div class="layui-card-body">
            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box">
                    <div class="layui-table-header">
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
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>编号</span>
                                        <span class="layui-table-sort layui-inline">
                                            <i class="layui-edge layui-table-sort-asc"></i>
                                            <i class="layui-edge layui-table-sort-desc"></i>
                                        </span>
                                    </div>
                                </th>
                                <th data-field="hw_name">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>作业名称</span></div>
                                </th>
                                <th data-field="student_sno">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>学号</span></div>
                                </th>
                                <th data-field="student_name">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>学生姓名</span></div>
                                </th>
                                <th data-field="docu_name">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>提交文档名</span></div>
                                </th>
                                <th data-field="end_time">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>截止提交时间</span></div>
                                </th>
                                <th data-field="handup_time">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>提交时间</span></div>
                                </th>
                                <th data-field="teacher_time">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>评阅教师姓名</span></div>
                                </th>
                                <th data-field="correct">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>评阅意见</span></div>
                                </th>
                                <th data-field="correct_score">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>评阅分数</span></div>
                                </th>
                                <th data-field="correct_status">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>评阅状态</span></div>
                                </th>
                                <th data-field="correct_time">
                                    <div class="layui-table-cell laytable-cell-2-standard"><span>评阅时间</span></div>
                                </th>
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
                            width: 45px;
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
            var laydate2=layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#search-if-endtime' //指定元素
            });
            laydate2.render({
                elem: '#correct_time'
            })
        });
        layui.use('form', function () {
            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功

            //……

            //但是，如果你的HTML是动态生成的，自动渲染就会失效
            //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
            form.render({
                elem: '.select-status'
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

