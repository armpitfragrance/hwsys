<%@ page import="com.entity.UserTeacher" %><%--
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
    <title>信息中心</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <script type="text/javascript" src="../../../js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://www.huangwx.cn/css/sweetalert.css">
    <script type="text/javascript" src="https://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="../../../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../../src/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="../../../layui-v2.5.7/layui/css/layui.css">
    <script src="../../../layui-v2.5.7/layui/layui.all.js"></script>
    <script type="text/javascript" src="../../../js/jquery.autocomplete.js"></script>

    <%
        HttpSession session1 = request.getSession();
        UserTeacher teacher = (UserTeacher) session1.getAttribute("user");
    %>
    <script type="text/javascript">
        var currentPage = 1;//当前页数
        var oldPageTotal = 0;//总页数
        var user_id = <%=teacher.getUser_id()%>;//todo:获取登入人id
        var readFlag="";
        var send_name="";
        var date="";
        $(function () {
            send_name = "";
            date = "";
            readFlag = "";
            $.ajax({
                url: "/Message.do",
                data: {action: "query", pageNo: "1",receive_id:user_id, readFlag: readFlag,send_name:send_name, date: date},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // console.log(data);
                    datainit(data);
                }
            });
            <!--发布公告-->
            $("#button-add-handup").on("click", function () {
                let formatter = $("#add-notice-form").serialize();
                $.ajax({
                    url: "/Message.do",
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
        });

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
                var str = jsonObj.items[a].message_time;
                str = str.substring(0, str.length - 2);
                var trNode = $("<tr></tr>");

                if (jsonObj.items[a].readFlag == 1) {
                    trNode.append("<td style='text-align: center'>" + "<button class=\"layui-btn layui-btn-primary layui-btn-xs\">已读</button>"+ "</td>");
                }else {
                    trNode.append("<td style='text-align: center'>" + "<button class=\"layui-btn layui-btn-xs\">未读</button>"+ "</td>");
                }
                trNode.append("<td style='text-align: center'>" + jsonObj.items[a].id + "</td>");
                trNode.append("<td>" + jsonObj.items[a].send_name + "</td>");
                trNode.append("<td>" + jsonObj.items[a].content + "</td>");
                trNode.append("<td>" + str + "</td>");
                trNode.append("<td style=\"text-align: center\">\n" +
                    "<button class=\"detailbtn layui-btn layui-btn-normal layui-btn-xs\">" +
                    "<i class=\"layui-icon layui-icon-edit\"></i>详情</button>\n" +
                    "<button class=\"delbtn layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                    "<i class=\"layui-icon layui-icon-delete\"></i>删除</button>\n" +
                    "</td>");
//data-toggle="modal" data-target="#addModal"
                $("#tbody1").append(trNode);
            }

            <!--表格内操作-->

            $(".detailbtn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[1]).html().trim();
                // console.log(id);
                window.location.href = "MessageDetail.jsp?id=" + id;
                // $("#updateModal").modal('show');
            });
            <!--删除-->

            $(".delbtn").on("click", function () {
                let id = $($(this).parents("tr").children("td")[1]).html().trim();
                $.ajax({
                    url: "/Message.do",
                    data: {action: "delete", messageId: id},
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

        <!--跳转页面-->
        function changepage(i) {
            currentPage = i;
            $.ajax({
                url: "/Message.do",
                data: {action: "query", pageNo: currentPage,receive_id:user_id, readFlag: readFlag,send_name:send_name, date: date},
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

        function add() {
            let addFormData = new FormData($(""));
        }



    </script>


</head>
<body layadmin-themealias="default" style="">

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">发送人</label>
                    <div class="layui-inline">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input"
                               id="send_name">
                    </div>
                    <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                        <label class="layui-form-label">时间</label>
                        <div class="layui-inline">
                            <input type="text" placeholder="请选择" class="layui-input" id="search-if-time">
                        </div>
                        <div class="layui-inline">
                            <!--查询图片按钮-->
                            <button class=" layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="LAY-user-back-search" type="button" id="querybutton">
                                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                            </button>
                            <script>
                                $("#querybutton").click(function () {
                                    // var formData = new FormData(document.getElementById("queryform"));
                                    send_name = $("#send_name").val();
                                    date = $("#search-if-time").val();
                                    $.ajax({
                                        url: "/Message.do",
                                        data:{action: "query", pageNo: currentPage,receive_id:user_id, readFlag: readFlag,send_name:send_name, date: date},
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

                    </div>
                </div>



            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <div class="layui-btn-group">
                    <button class="queryAll layui-btn layui-btn-primary" data-toggle="modal">查看全部</button>
                    <button class="queryRead layui-btn layui-btn-primary" data-toggle="modal">查看已读</button>
                    <button class="queryUnRead layui-btn layui-btn-primary" data-toggle="modal">查看未读</button>
                </div>
                <button class="button-add layui-btn layui-btn-admin" data-toggle="modal" data-target="#addModal">写留言</button>
                <script>
                    $(".queryAll").on("click", function () {
                        send_name = "";
                        date = "";
                        readFlag = "";
                        $.ajax({
                            url: "/Message.do",
                            data: {
                                action: "query",
                                pageNo: "1",
                                receive_id: user_id,
                                readFlag: readFlag,
                                send_name: send_name,
                                date: date
                            },
                            type: "GET",
                            dataType: "text",
                            success: function (data) {
                                // console.log(data);
                                currentPage = 1;
                                datainit(data);
                            }
                        })
                    });

                    $(".queryRead").on("click", function () {
                        send_name = "";
                        date = "";
                        readFlag = 1;
                        $.ajax({
                            url: "/Message.do",
                            data: {
                                action: "query",
                                pageNo: "1",
                                receive_id: user_id,
                                readFlag: readFlag,
                                send_name: send_name,
                                date: date
                            },
                            type: "GET",
                            dataType: "text",
                            success: function (data) {
                                // console.log(data);
                                currentPage = 1;
                                datainit(data);

                            }
                        })
                    });

                    $(".queryUnRead").on("click", function () {
                        send_name = "";
                        date = "";
                        readFlag = 0;
                        $.ajax({
                            url: "/Message.do",
                            data: {
                                action: "query",
                                pageNo: "1",
                                receive_id: user_id,
                                readFlag: readFlag,
                                send_name: send_name,
                                date: date
                            },
                            type: "GET",
                            dataType: "text",
                            success: function (data) {
                                // console.log(data);
                                currentPage = 1;
                                datainit(data);

                            }
                        })
                    });
                </script>
                <!--添加按钮-->

            </div>
            <!--发布公告(模态框)-->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">留言</h4>
                        </div>
                        <div class="modal-body">

                            <form>
                                <div>
                                    <div>
                                    <input type="hidden" name="action" value="insert"/>
                                    <label for="addtitle">标题</label>
                                    <input type="text" name="addtitle" id="addtitle" class="form-control"
                                           placeholder="请输入标题"/><br/>
                                    </div>
                                    <div>
                                        <label for="receive_no">收件人学号/工号</label>
                                        <input type="text" name="receive_no" id="receive_no"/>
                                        <input type="text" name="receive_name" id="receive_name" autocomplete="off" disabled="true"/>
                                        <input type="hidden" name="receive_id" id="receive_id">
                                        <input type="radio" name="type" class="type" value="stu" checked="true" >学生
                                        <input type="radio" name="type" class="type" value="t" >教师
                                    <script>
                                        $('input[type=radio][name=type]').change(function() {
                                            var receive_no = $("#receive_no").val();
                                            var type= $("input[name='type']:checked").val();
                                            console.log(type);
                                            $.ajax({
                                                url: "/Message.do",
                                                data: {action: "rcvsearch", receive_no: receive_no, type: type},
                                                type: "GET",
                                                dataType: "text",
                                                success: function (data) {
                                                    // console.log(data);
                                                    var user = JSON.parse(data);
                                                    if (user == null) {
                                                        $("#receive_name").val("查询不到该学生/老师");
                                                        // $("#button-add-handup").toggleClass("layui-btn");
                                                        // $("#button-add-handup").removeAttr("class","className");
                                                        // $("#button-add-handup").addClass("layui-btn-disabled")
                                                        $("#button-add-handup").addClass("layui-btn-disabled");
                                                    }else {
                                                        $("#receive_name").val(user.realname);
                                                        $("#receive_id").val(user.id);
                                                        $("#button-add-handup").toggleClass("layui-btn-disabled");
                                                        // $("#button-add-handup").removeAttr("class","className");
                                                        $("#button-add-handup").addClass("layui-btn")
                                                    }
                                                }
                                            });
                                        });


                                        $("#receive_no").on("keyup", function () {
                                            //获取要删除的数据的id
                                            var receive_no = $("#receive_no").val();
                                            var type= $("input[name='type']:checked").val();
                                            console.log(type);
                                            $.ajax({
                                                url: "/Message.do",
                                                data: {action: "rcvsearch", receive_no: receive_no, type: type},
                                                type: "GET",
                                                dataType: "text",
                                                success: function (data) {
                                                    // console.log(data);
                                                    var user = JSON.parse(data);
                                                    if (user == null) {
                                                        $("#receive_name").val("查询不到该学生/老师");
                                                        // $("#button-add-handup").toggleClass("layui-btn");
                                                        // $("#button-add-handup").removeAttr("class","className");
                                                        // $("#button-add-handup").addClass("layui-btn-disabled")
                                                        $("#button-add-handup").addClass("layui-btn-disabled");
                                                    }else {
                                                        $("#receive_name").val(user.realname);
                                                        $("#receive_id").val(user.id);
                                                        $("#button-add-handup").toggleClass("layui-btn-disabled");
                                                        // $("#button-add-handup").removeAttr("class","className");
                                                        $("#button-add-handup").addClass("layui-btn")
                                                    }
                                                }
                                            });
                                        });

                                    </script>
                                    </div>
                                    <div>
                                    <label for="addcontent">内容</label>
                                    <textarea type="text" name="addcontent" id="addcontent" class="form-control"
                                              style="width: 570px;height: 300px"></textarea>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal" id="button-add-close">
                                关闭
                            </button>
                            <button type="button" class="send layui-btn layui-btn-disabled" id="button-add-handup">发送</button>
                            <script>
                                $(".send").on("click", function () {
                                    var receive_id = $("#receive_id").val();
                                    var type = $("#type").val();
                                    var title = $("#addtitle").val();
                                    var content = $("#addcontent").val();
                                    // var send_id = user_id;
                                    $.ajax({
                                        url: "/Message.do",
                                        data: {action: "send", receive_id: receive_id,send_id:user_id, type: type,title:title,content:content},
                                        type: "GET",
                                        dataType: "text",
                                        success: function (data) {
                                            if (data > 0) {
                                                swal("发送成功", "", "success");
                                            } else {
                                                swal("发送失败", "", "error");
                                            }
                                            $("#addModal").modal("hide");
                                            changepage(currentPage);                                            // console.log(data);
                                        }
                                    });
                                });
                            </script>
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
                                    <div class="layui-table-cell laytable-cell-2-id" style="align-items: center">
                                        <i class="layui-icon layui-icon-email"></i>
                                    </div>
                                </th>
                                <th data-field="id" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-id"><span>编号</span>
                                    </div>
                                </th>

                                <th data-field="title" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-fromname"><span>发件人</span></div>
                                </th>
                                <th data-field="content" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-content"><span>主题</span></div>
                                </th>
                                <th data-field="notice_time" style="text-align: center">
                                    <div class="layui-table-cell laytable-cell-2-time"><span>时间</span>

                                    </div>
                                </th>
                                <th data-field="8">
                                    <div class="layui-table-cell laytable-cell-2-operate" align="center"><span>操作</span></div>
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
                        width: 20px;
                    }

                    .laytable-cell-2-id {
                        width: 91px;
                    }

                    .laytable-cell-2-fromname {
                        width: 138px;
                    }

                    .laytable-cell-2-content {
                        width:566px;
                    }
                    .laytable-cell-2-time{
                        width: 397px;
                    }

                    .laytable-cell-2-operate {
                        width: 353px;
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

