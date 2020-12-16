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
    <link rel="stylesheet" href="../../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../src/layuiadmin/style/admin.css" media="all">
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://www.huangwx.cn/css/sweetalert.css">
    <script type="text/javascript" src="https://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <script type="text/javascript" src="../../js/bootstrap.min.js"></script>
    <script>
        var name ;
        var t_no ;
        var currentPage = 1;
        var oldPage = 0;
        var tabledate;
        $(function () {
            name = "";
            t_no = "";
            $.ajax({
                url: "/SC.do",
                data: {action: "query", name:name,t_no:t_no,pageNo: 1},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    datainit(data);
                    tabledate = data;
                }
            });

        });

        function changepage(i) {
            currentPage = i;
            $.ajax({
                url: "/SC.do",
                data: {action: "query",name:name,t_no:t_no, pageNo: i},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    let jsonObj = JSON.parse(data);
                    if (currentPage>jsonObj.pageTotal){
                        currentPage--;
                        changepage(currentPage);
                    }
                    datainit(data);
                }
            })
        };

        function datainit(data) {
            let index = 1;
            let jsonObj = JSON.parse(data);
            let nextbutton="<button type='button' class='btn btn-default' id='next'>>下一页</button> ";
            let lastbutton="<button type='button' class='btn btn-default' id='last'>上一页<</button> ";
            oldPage = jsonObj.pageTotal;
            $("#tbody1").empty();
            $("#pagebutton").empty();
            $("#pagebutton").html("<b id=\"totalPageCount\">共页</b>\n")
            $("#totalPageCount").html("共" + jsonObj.pageTotal + "页");
            $("#pagebutton").append('<a class="btn btn-default" onclick="changepage(1)">首页\<<</a>');

            if (currentPage!=1) {
                $("#pagebutton").append(lastbutton);
                $("#last").on('click',function () {
                    changepage(currentPage - 1);
                })
            }



            if(oldPage<10){
                for (let i = index; i <= index+oldPage-1; i++) {
                    if (i == currentPage) {
                        $("#pagebutton").append('<a class="btn btn-primary" onclick="changepage(' + i + ')">' + i + '</a>');
                    } else {
                        $("#pagebutton").append('<a class="btn btn-default" onclick="changepage(' + i + ')">' + i + '</a>');
                    }
                }
            }else {
                if(currentPage<=6) {
                    index = 1;
                }else if(currentPage>6&&currentPage<(jsonObj.pageTotal-4)) {
                    index = currentPage - 5;
                }else if(currentPage>=jsonObj.pageTotal-4)
                {
                    index = jsonObj.pageTotal - 9;
                }
                for (let i = index; i <= index + 9; i++) {
                    if (i == currentPage) {
                        $("#pagebutton").append('<a class="btn btn-primary" onclick="changepage(' + i + ')">' + i + '</a>');
                    } else {
                        $("#pagebutton").append('<a class="btn btn-default" onclick="changepage(' + i + ')">' + i + '</a>');
                    }
                }
            }
            // for (let i = 1; i <= jsonObj.pageTotal; i++) {
            //     if (i == currentPage) {
            //         $("#pagebutton").append('<a class="btn btn-primary" onclick="changepage(' + i + ')">' + i + '</a>');
            //     } else {
            //         $("#pagebutton").append('<a class="btn btn-default" onclick="changepage(' + i + ')">' + i + '</a>');
            //     }
            // }

            if(currentPage!=jsonObj.pageTotal) {
                $("#pagebutton").append(nextbutton);
                $("#next").on('click',function () {
                    changepage(currentPage + 1);
                })

            }
            $("#pagebutton").append('<a class="btn btn-default" onclick="changepage(' + jsonObj.pageTotal + ')">\>>最后一页</a>');

            // else {
            //     $("#pagebutton").append(nextbutton);
            //     $("#pagebutton").append(lastbutton);
            // }

            for (let i = 0; i < jsonObj.items.length; i++) {
                let trNode = $("<tr></tr>");
                trNode.append("                                <td>\n" +
                    "                                    <div class=\"layui-table-cell laytable-cell-2-0 laytable-cell-checkbox\">\n" +
                    "                                        <input type=\"checkbox\" name=\"layTableCheckbox\" lay-skin=\"primary\" lay-filter=\"layTableAllChoose\">\n" +
                    "                                        <div class=\"layui-unselect layui-form-checkbox\" lay-skin=\"primary\">\n" +
                    "                                            <i class=\"layui-icon layui-icon-ok\"></i>\n" +
                    "                                        </div>\n" +
                    "                                    </div>\n" +
                    "                                </td>")
                trNode.append("<td>" + jsonObj.items[i].id + "</td>");
                trNode.append("<td>" + jsonObj.items[i].name + "</td>");
                trNode.append("<td>" + jsonObj.items[i].realname + "</td>");
                trNode.append("<td>" + jsonObj.items[i].t_no + "</td>");
                trNode.append("<td>" + jsonObj.items[i].count + "</td>");
                trNode.append("                                <td style=\"text-align: center\">\n" +
                    "\n" +
                    "                                    <a class=\"delbtn layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\"><i\n" +
                    "                                            class=\"layui-icon layui-icon-delete\"></i>删除</a>\n" +
                    "                                </td>");
                $("#tbody1").append(trNode);
            }

            $(".delbtn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[1]).html().trim();
                $.ajax({
                    url: "/SC.do",
                    data: {action: "delete", userId: id},
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        console.log(currentPage);
                        // let newid = $($(this).parents("tr").children("td")[0]).html().trim();
                        // alert(data);
                        if (data > 0) {
                            swal("删除成功", "", "success");
                        }
                        if (data < 0) {
                            swal("删除失败", "", "failed");
                        }
                        changepage(currentPage);
                    }
                });
            });
        }


    </script>
</head>
<body layadmin-themealias="default" style="">

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <form id="queryform">
                    <%--<input type="hidden" name="action" value="query">--%>
                <div class="layui-inline">
                    <label class="layui-form-label">课程名</label>
                    <div class="layui-input-block">
                        <input type="text" id="name" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">工号</label>
                    <div class="layui-input-block">
                        <input type="text" id="t_no" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="LAY-user-back-search" type="button" id="querybutton">
                        <i class="submit layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                    <script>
                        $("#querybutton").click(function () {
                            // var formData = new FormData(document.getElementById("queryform"));
                             name = $("#name").val();
                             t_no = $("#t_no").val();
                            $.ajax({
                                url: "/SC.do",
                                data:{action:"query",name:name, t_no: t_no,pageNo:1},
                                // data: formData,
                                type: "POST",
                                dataType: "text",
                                success: function (data) {
                                    datainit(data);
                                }
                            });
                        });

                    </script>
                </div>
                </form>
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
                                    <div class="layui-table-cell laytable-cell-2-id"><span>ID</span>
                                        <span class="layui-table-sort layui-inline">
                                            <i class="layui-edge layui-table-sort-asc"></i>
                                            <i class="layui-edge layui-table-sort-desc"></i>
                                        </span>
                                    </div>
                                </th>
                                <th data-field="name">
                                    <div class="layui-table-cell laytable-cell-2-loginname"><span>课程名</span></div>
                                </th>
                                <th data-field="t_name">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>授课老师姓名</span></div>
                                </th>
                                <th data-field="t_no">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>授课老师工号</span></div>
                                </th>
                                <th data-field="stu_counts">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>选课人数</span>
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

                            </tbody>
                        </table>
                    </div>
                    <div align="center" id="pagebutton">
                        <!--<b id="totalPageCount">共页</b>-->

                        <!--<a class="btn btn-default" href="http://localhost:1201/user.do?action=queryPage&pageNo=">1-->
                        <!--</a>-->
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

