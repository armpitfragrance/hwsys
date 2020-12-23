<%@ page import="com.entity.UserStudent" %><%--
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
    <title>学生端课程管理</title>
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

    <%
        HttpSession session1 = request.getSession();
        UserStudent student = (UserStudent) session1.getAttribute("user");
    %>


    <script type="text/javascript">
        var name;
        var stu_no;//暂时没用
        var stu_id=<%=student.getId()%>;//todo 之后通过session获取
        var currentPage = 1;
        var oldPageTotal = 0;
        $(function () {
            name = "";
            stu_no = "";
            $.ajax({
                url: "/SC.do",
                data: {action: "querySC", pageNo: "1", name: name, stu_no: stu_no,stu_id:stu_id},
                type: "get",
                datatype: "text",
                success: function (data) {
                    // console.log(data);

                    initData(data);
                }
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
                var path=jsonObj.items[i].path;
                var createtime=jsonObj.items[i].createtime;
                createtime = createtime.substring(0, createtime.length - 2);
                path = path.substring(2);
                path = path.replace("/\/g","/");
                path = "http://localhost:8080" + path;
                let trNode = $("<div class=\"detail layui-table-header\"\n" +
                    "                             style=\"float: left;width: 240px;height: 280px;margin: 8.5px;border-radius: 7px;position: relative\">\n" +
                    "                            <h5 style=\"display: none\">"+jsonObj.items[i].id+"</h5>\n" +
                    "                            <div style=\"position: absolute;top: 6px;right: 6px;\" class=\"edit_button\">\n" +
                    // "                                <a class=\"upbtn layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\"\n" +
                    // "                                   data-toggle=\"modal\" data-target=\"#myModal1\" style=\"margin: 1px\">\n" +
                    // "                                    <i class=\"upbtn layui-icon layui-icon-edit\" data-toggle=\"modal\" data-target=\"#myModal1\"></i>编辑</a>\n" +
                    "                                <a class=\"delbtn layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\"\n" +
                    "                                   style=\"margin: 1px;text-decoration: none\">\n" +
                    "                                    <i class=\"layui-icon layui-icon-delete\"></i>退选</a>\n" +
                    "                            </div>\n" +
                    "                            <div class=\"coursedetail\">\n" +
                    "                               <img src=\""+path+"\" width=\"240px\" height=\"165px\"><br>\n" +
                    "                               <div id=\"c_detail\" style=\"margin-left: 8.5px;margin-right: 8.5px;position: absolute;width: 223px;height: 115px;\">\n" +
                    "                                   <h3 style=\"font-size: 17px;margin-top: 5px\"><b>"+jsonObj.items[i].name+"</b></h3>\n" +
                    "                                   <h5 style=\"margin-top: 5px\">"+jsonObj.items[i].realname+"</h5>\n" +
                    "                                   <div style=\"position: absolute;bottom:2px;width: 220px\">\n" +
                    "                                       <span style=\"float: left\">"+createtime+"</span>\n" +
                    "                                       <span style=\"float: right\">"+jsonObj.items[i].count+"人参加</span>\n" +
                    "                                   </div>\n" +
                    "                               </div>\n" +
                    "                            </div>\n" +
                    "                        </div>");

                $("#tbody1").append(trNode);
            };
            $(".edit_button").hide();
            $(".detail").on("mouseenter",function () {

                $(this).find(".edit_button").fadeIn(250);
            });
            $(".detail").on("mouseleave",function () {
                $(this).find(".edit_button").fadeOut(250);
            });
            $(".coursedetail").on("click",function () {
                var t_id=0;
                var c_id=0;
                var tc_id=$($($(this).parent("div")).find("h5")).html().trim();
                $.ajax({
                    url: "/TC.do",
                    data:{action:"queryForOne", tc_id: tc_id},
                    type:"post",
                    dataType: "text",
                    success: function (data) {
                        var jsonObj = JSON.parse(data);
                        console.log(data);
                        t_id = jsonObj.t_id;
                        c_id = jsonObj.c_id;
                        location.href = "StuCourseDetail.jsp?t_id="+t_id+"&c_id="+c_id;
                    }
                });

            });
            $(".delbtn").on("click",function(){
                var tc_id = $($(this).parent("div").prev()).html().trim();
                console.log(tc_id);
                $.ajax({
                    url: "/SC.do",
                    data:{action:"deleteSC", tc_id: tc_id,stu_id:stu_id},
                    type:"post",
                    dataType: "text",
                    success: function (data) {
                        if (data > 0) {
                            swal("退选成功", "", "success");
                        } else {
                            swal("退选失败", "", "error");
                        }

                        changePage(currentPage);
                    }
                });
            });
        }
        function emptyForm() {
            var userform = document.getElementById("courseform");
            userform.reset();
            $("#imgpreview").attr("src", "");
        }
        function changePage(i) {

            currentPage=i;

            $.ajax({
                url: "/SC.do",
                data: {action: "querySC", pageNo: i, name: name, stu_no: stu_no,stu_id:stu_id},
                type: "get",
                datatype: "text",
                success: function (data) {
                    let jsonObj = JSON.parse(data);
                    if (currentPage > jsonObj.pageTotal) {
                        currentPage = currentPage-1;
                        changePage(currentPage);
                    }
                    initData(data);
                }
            });

        }
    </script>
    <script type="text/javascript">
        $(function () {
            $(".edit_button").hide();
            $(".detail").on("mouseenter",function () {

                $(this).find(".edit_button").fadeIn(250);
            });
            $(".detail").on("mouseleave",function () {
                $(this).find(".edit_button").fadeOut(250);
            });
        });
        function preview(file) {
            var $preview = $("#imgpreview");
            if (file.files && file.files[0]) {
                var reader = new FileReader();
                reader.onload = function (evt) {
                    $preview.attr("src", evt.target.result);
                    // prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
                }
                reader.readAsDataURL(file.files[0]);
            } else {
                // prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
            }
        }

    </script>
</head>
<body layadmin-themealias="default" style="">
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <form id="queryform">


                    <div class="layui-inline">
                        <label class="layui-form-label">课程名</label>
                        <div class="layui-inline">
                            <input id="coursename_q" type="text" name="realname" placeholder="请输入课程名" autocomplete="off"
                                   class="layui-input">
                        </div>
                        <div class="layui-inline">
                            <button id="btn_query" type="button" class="layui-btn layuiadmin-btn-admin" lay-submit=""
                                    lay-filter="LAY-user-back-search">
                                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                            </button>
                            <script>
                                $("#btn_query").click(function () {
                                    name=$("#coursename_q").val();
                                    // console.log(name);
                                    // stu_no=$("#stu_no_q").val();
                                    $.ajax({
                                        url: "/SC.do",
                                        data: {action:"querySC", name: name, stu_no: 2,pageNo: 1,stu_id,stu_id},
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
                    <%--<div class="layui-inline">--%>
                        <%--<label class="layui-form-label">学号</label>--%>
                        <%--<div class="layui-input-block">--%>
                            <%--<input id="stu_no_q" type="text" name="stu_no" placeholder="请输入授课学生学号" autocomplete="off"--%>
                                   <%--class="layui-input">--%>
                        <%--</div>--%>
                    <%--</div>--%>


                </form>
            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-admin" data-toggle="modal" id="btn_choose">选择课程</button>
                <script>
                    $("#btn_choose").click(function () {
                        location.href = "ChooseCourse.jsp";
                    });
                </script>
            </div>

            <table id="LAY-user-back-manage" lay-filter="LAY-user-back-manage"></table>
            <div class="layui-form layui-border-box layui-table-view" lay-filter="LAY-table-2" style=" ">
                <div class="layui-table-box" style="overflow-x: auto; " id="tbody1">
                    <%--<div class="layui-table-header" style="overflow-x: auto; ">--%>

                    <%--<div class="detail layui-table-header"--%>
                    <%--style="float: left;width: 240px;height: 280px;margin: 8.5px;border-radius: 7px;position: relative">--%>
                    <%--<h5 style="display: none">填放课程id</h5>--%>
                    <%--<div style="position: absolute;top: 6px;right: 6px;" class="edit_button">--%>
                    <%--<a class="upbtn layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"--%>
                    <%--data-toggle="modal" data-target="#myModal1" style="margin: 1px">--%>
                    <%--<i class="upbtn layui-icon layui-icon-edit"></i>编辑</a>--%>
                    <%--<a class="delbtn layui-btn layui-btn-danger layui-btn-xs" lay-event="del"--%>
                    <%--style="margin: 1px">--%>
                    <%--<i class="layui-icon layui-icon-delete"></i>删除</a>--%>
                    <%--</div>--%>
                    <%--<img src="../../../img/test.jpeg" width="240px" height="165px"><br>--%>
                    <%--<div style="margin-left: 8.5px;margin-right: 8.5px;position: absolute;width: 223px;height: 115px;">--%>
                    <%--<h3 style="font-size: 17px;margin-top: 5px"><b>大学计算机-计算思维导论CAP</b></h3>--%>
                    <%--<h5 style="margin-top: 5px">马保国</h5>--%>
                    <%--<div style="position: absolute;bottom:2px;width: 220px">--%>
                    <%--<span style="float: left">2020-10-20</span>--%>
                    <%--<span style="float: right">200人参加</span>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <%--</div>--%>





                    <style>
                        .detail:hover {
                            box-shadow: 2px 2px 10px #909090;
                        }

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
                <style>
                    .detail:hover {
                        box-shadow: 2px 2px 10px #909090;
                    }
                </style>
            </div>
            <%--<div align="center" id="pageBtn">--%>
            <%--</div>--%>
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
