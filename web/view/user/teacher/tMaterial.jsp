<%@ page import="com.entity.UserTeacher" %><%--
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

    <%
        HttpSession session1 = request.getSession();
        UserTeacher teacher = (UserTeacher) session1.getAttribute("user");
    %>

    <script type="text/javascript">
        var currentPage = 1;//当前页数
        var oldPageTotal = 0;//总页数
        var course_id=<%=request.getParameter("c_id")%>;//todo 课程编号
        var user_id=<%=teacher.getUser_id()%>; //上传人 id
        var date;
        var filename;
        $(function () {
            date = "";
            filename = "";
            $.ajax({
                url: "/tMaterial.do",
                data: {
                    action: "queryTMaterial",
                    pageNo: currentPage,
                    course_id: course_id,
                    date: date,
                    filename: filename
                },
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // console.log(data);
                    datainit(data);
                }
            });

            <!--上传按钮-->
            $("#button-add-handup").on("click", function () {
                let formatter = new FormData(document.getElementById("add-tMaterial-form"));
                console.log(formatter);
                $.ajax({
                    url: "/tMaterialUpload.do",
                    data: formatter,
                    type: "POST",
                    dataType: "json",
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        console.log(data);
                        if (data > 0) {
                            swal("上传成功", "", "success");
                        } else {
                            swal("上传失败", "", "error");
                        }
                        $("#button-add-close").click();
                        changepage(oldPageTotal);
                    }
                });
            });

            <!--搜索-->
            $("#button-search").on("click", function () {
                filename = $("#search-if-hwname").val();
                date = $("#search-if-endtime").val();
                $.ajax({
                    url: "/tMaterial.do",
                    data: {
                        action: "queryTMaterial",
                        pageNo: currentPage,
                        course_id: course_id,
                        filename: filename,
                        date: date
                    },
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        changepage(1);
                    }
                });
            });

        });


        function download(path) {
            console.log(path);
            location.href = "/download.do?path=" + path;
        };

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
            if (jsonObj.pageTotal != 1 && currentPage != 1) {
                $("#pagebutton").append('<a class="btn btn-default" onclick="changepage(1)">首页\<<</a>');
            }


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

            if(currentPage!=jsonObj.pageTotal) {
                $("#pagebutton").append(nextbutton);
                $("#next").on('click',function () {
                    changepage(currentPage + 1);
                })

            }
            if (jsonObj.pageTotal != 1 && currentPage != jsonObj.pageTotal) {
                $("#pagebutton").append('<a class="btn btn-default" onclick="changepage(' + jsonObj.pageTotal + ')">\>>最后一页</a>');
            }

            for (var a = 0; a < jsonObj.items.length; a++) {
                var str = jsonObj.items[a].handup_time;
                str = str.substring(0, str.length - 2);
                var trNode = $("<tr></tr>");

                trNode.append("<td style='text-align: center'>" + jsonObj.items[a].id + "</td>");
                trNode.append("<td>" + jsonObj.items[a].name + "</td>");
                trNode.append("<td>" + str + "</td>");
                trNode.append("<td style='text-align: center'>" +
                    "<button class='previewbtn layui-btn layui-btn-normal layui-btn-xs' onclick='filepreview(\""+jsonObj.items[a].name+"\")'>" +
                    "<i class='layui-icon layui-icon-tips'></i>预览</button>\n" +
                    "<button class='downloadbtn layui-btn layui-btn-normal layui-btn-xs' onclick='download(\""+jsonObj.items[a].name+"\")'>" +
                    "<i class='layui-icon layui-icon-layim-download'></i>下载</button>\n" +
                    "<button class='delbtn layui-btn layui-btn-danger layui-btn-xs' lay-event='del'>" +
                    "<i class='layui-icon layui-icon-delete'></i>删除</button>\n" +
                    "</td>");
//data-toggle="modal" data-target="#addModal"
                $("#tbody1").append(trNode);
            }

            <!--表格内操作-->


            $(".delbtn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[0]).html().trim();
                $.ajax({
                    url: "/tMaterial.do",
                    data: {action: "delete", tMaterialId: id},
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
        };

        <!--跳转页面-->
        function changepage(i) {
            currentPage = i;
            $.ajax({
                url: "/tMaterial.do",
                data: {
                    action: "queryTMaterial",
                    pageNo: currentPage,
                    course_id: course_id,
                    date: date,
                    filename: filename
                },
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

    </script>
</head>
<body layadmin-themealias="default" style="">

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0" for="search-if-hwname">教资名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="tMaterialname" placeholder="请输入关键词" autocomplete="off" class="tMaterialname layui-input"
                               id="search-if-hwname">
                    </div>
                </div>

                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label layform-label-2-0" for="search-if-endtime">上传日期</label>
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
                <button class="button_upload button-add layui-btn layuiadmin-btn-admin" data-toggle="modal" data-target="#addModal">
                    教学资料上传
                </button>
            </div>
            <script>
                $(".button_upload").on("click",function () {
                    $(".coures_id").val(course_id);
                });
            </script>

            <!--发布公告(模态框)-->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">上传教学资料</h4>
                        </div>

                        <div class="modal-body">
                            <form id="add-tMaterial-form">
                                <label for="addfile">选择附件</label>
                                <input type="hidden" name="action" value="TMaterial-action-upload"/>
                                <input type="hidden" name="course_id" id="course_id" class="coures_id">
                                <input type="file" name="addfile" id="addfile" class="form-control"
                                       placeholder=""/><br/>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal" id="button-add-close">
                                关闭
                            </button>
                            <button type="button" class="layui-btn" id="button-add-handup">上传</button>
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
                                    <div class="layui-table-cell laytable-cell-2-1"><span>编号</span>

                                    </div>
                                </th>

                                <th data-field="docu_name" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-2"><span>文档名</span></div>
                                </th>
                                <%--<th data-field="course_name">--%>
                                    <%--<div class="layui-table-cell laytable-cell-2-4"><span>大小</span></div>--%>
                                <%--</th>--%>
                                <th data-field="end_time" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-5"><span>创建日期</span></div>
                                </th>
                                <th data-field="8" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-6"><span>操作</span></div>
                                </th>
                            </tr>
                            </thead>
                            <tbody id="page-body">

                            </tbody>
                            <tbody id="tbody1">

                            </tbody>
                        </table>


                    </div>
                </div>
                <div align="center" id="pagebutton">
                    <!--<b id="totalPageCount">共页</b>-->

                    <!--<a class="btn btn-default" href="http://localhost:1201/user.do?action=queryPage&pageNo=">1-->
                    <!--</a>-->
                </div>
                    <style>
                        .layform-label-2-0 {
                            width: 110px;
                        }

                        .laytable-cell-2-1 {
                            width: 100px;
                        }

                        .laytable-cell-2-2 {
                            width: 843px;
                        }

                        .laytable-cell-2-3 {
                            width: 80px;
                        }
                        .laytable-cell-2-4 {
                            width: 70px;
                        }
                        .laytable-cell-2-5 {
                            width: 254px;
                        }
                        .laytable-cell-2-6 {
                            width: 423px;
                        }
                    </style>
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
            //执行一个laydate实例
            laydate.render({//指定元素
                elem: '#addend_time'
            });
            laydate2.render({
                elem: '#search-if-endtime'
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
