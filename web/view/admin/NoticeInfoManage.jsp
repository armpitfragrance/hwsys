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
    <title>课程信息管理</title>
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

    <link rel="stylesheet" href="../../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../src/layuiadmin/style/admin.css" media="all">

    <script type="text/javascript">
        var currentPage = 1;//当前页数
        var oldPageTotal = 0;//总页数

        $(function () {
            let title = $("#search-if-title").val();
            let time = $("#search-if-time").val();
            $.ajax({
                url: "/notice.do",
                data: {action: "search", pageNo: "1",title:title,time:time},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // console.log(data);
                    initDate(data);
                }
            });
            <!--发布公告-->
            $("#button-add-handup").on("click", function () {
                let formatter = $("#add-notice-form").serialize();
                $.ajax({
                    url: "/notice.do",
                    data: formatter,
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        // console.log(data);
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

            <!--修改公告,提交修改-->
            $("#button-update-handup").on("click", function () {
                let formatter = $("#update-notice-form").serialize();
                $.ajax({
                    url: "/notice.do",
                    data: formatter,
                    type: "POST",
                    dataType: "json",
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
                let title = $("#search-if-title").val();
                let time = $("#search-if-time").val();
                console.log(title + "," + time);
                $.ajax({
                    url: "/notice.do",
                    data: {action: "search",pageNo:1, title: title, time: time},
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
                if(currentPage<4){
                    begin=1;
                    end=5;
                }else if((oldPageTotal-currentPage)==0){
                    begin=currentPage-4;
                    end=currentPage;
                }else if((oldPageTotal-currentPage)<=4){
                    begin=currentPage-(4-(oldPageTotal-currentPage));
                    end=oldPageTotal;
                }else if((oldPageTotal-currentPage)>4){
                    begin=currentPage-2;
                    end=currentPage+2;
                }
                for (let i = begin; i <=end; i++) {
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
                trNode.append("<td></td>");
                trNode.append("<td>" + dataObj.items[a].id + "</td>");
                trNode.append("<td>" + dataObj.items[a].title + "</td>");
                trNode.append("<td>" + dataObj.items[a].content + "</td>");
                trNode.append("<td>" + dataObj.items[a].notice_time + "</td>");
                trNode.append("<td style=\"text-align: center\">\n" +
                    "<button class=\"upbtn layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\"  >" +
                    "<i class=\"layui-icon layui-icon-edit\"></i>编辑</button>\n" +
                    "<button class=\"delbtn layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                    "<i class=\"layui-icon layui-icon-delete\"></i>删除</button>\n" +
                    "</td>");
//data-toggle="modal" data-target="#addModal"
                $("#page-body").append(trNode);
            }

            <!--表格内操作-->
            <!--编辑-->
            $(".upbtn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[1]).html().trim();
                console.log(id);
                updateinitData(id);
                $("#updateModal").modal('show');
            });
            <!--删除-->
            $(".delbtn").on("click", function () {
                //获取要删除的数据的id
                let id = $($(this).parents("tr").children("td")[1]).html().trim();
                // console.log(id);
                $.ajax({
                    url: "/notice.do",
                    data: {action: "delete", id: id},
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        // console.log(data);
                        if (data > 0) {
                            swal("删除成功", "", "success");
                        } else {
                            swal("删除失败", "", "error");
                        }

                        changePage(currentPage);
                    }
                });
            });



        };

        <!--跳转页面-->
        function changePage(i) {
            currentPage = i;
            let title = $("#search-if-title").val();
            let time = $("#search-if-time").val();
            $.ajax({
                url: "/notice.do",
                data: {action: "search", pageNo: i, title: title, time: time},
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

        function add() {
            let addFormData = new FormData($(""));
        }

        function updateinitData(i) {
            $.ajax({
                url: "/notice.do",
                data: {action: "queryForOne", id: i},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    let dataObj = JSON.parse(data);
                    console.log(dataObj);
                    $("#updateid").val(dataObj.id);
                    $("#updatetitle").val(dataObj.title);
                    $("#updatecontent").val(dataObj.content);
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
                <div class="layui-inline">
                    <label class="layui-form-label">标题</label>
                    <div class="layui-input-block">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="search-if-title">
                    </div>
                </div>

                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label">时间</label>
                    <div class="layui-input-block">
                        <input type="text" placeholder="请选择" class="layui-input" id="search-if-time">
                    </div>
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

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="button-delete layui-btn layuiadmin-btn-admin" data-toggle="modal">删除</button>
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
                            <h4 class="modal-title" id="myModalLabel">发布公告</h4>
                        </div>
                        <div class="modal-body">

                            <form id="add-notice-form">
                                <input type="hidden" name="action" value="insert"/>
                                <label for="addtitle">标题</label>
                                <input type="text" name="addtitle" id="addtitle" class="form-control"
                                       placeholder="请输入标题"/><br/>
                                <label for="addcontent">内容</label>
                                <textarea type="text" name="addcontent" id="addcontent" class="form-control"
                                          style="width: 570px;height: 300px"></textarea>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="button-add-close">
                                关闭
                            </button>
                            <button type="button" class="btn btn-primary" id="button-add-handup">发布</button>
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
                            <form id="update-notice-form">
                                <input type="hidden" name="action" value="update"/>
                                <input type="hidden" name="updateid" id="updateid"/>
                                <label for="updatetitle">标题</label>
                                <input type="text" name="updatetitle" id="updatetitle" class="form-control"/><br/>
                                <label for="updatecontent">内容</label>
                                <textarea type="text" name="updatecontent" id="updatecontent" class="form-control"
                                          style="width: 570px;height: 300px"></textarea>
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
                                    <div class="layui-table-cell laytable-cell-2-id"><span>ID</span>
                                        <span class="layui-table-sort layui-inline">
                                            <i class="layui-edge layui-table-sort-asc"></i>
                                            <i class="layui-edge layui-table-sort-desc"></i>
                                        </span>
                                    </div>
                                </th>
                                <th data-field="title">
                                    <div class="layui-table-cell laytable-cell-2-loginname"><span>标题</span></div>
                                </th>
                                <th data-field="content">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>内容</span></div>
                                </th>
                                <th data-field="notice_time">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>发布时间</span>
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
                            <tbody id="page-body">

                            </tbody>
                        </table>


                    </div>

                    <style>.laytable-cell-2-0 {
                        width: 45px;
                    }

                    .laytable-cell-2-id {
                        width: 80px;
                    }

                    .laytable-cell-2-loginname {
                        width: 150px;
                    }

                    .laytable-cell-2-telphone {
                        width: 150px;
                    }

                    .laytable-cell-2-email {
                        width: 150px;
                    }

                    .laytable-cell-2-role {
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
    <script src="../../src/layuiadmin/layui/layui.js" charset="utf-8"></script>
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

