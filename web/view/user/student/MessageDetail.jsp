<%@ page import="com.entity.MsgUser" %>
<%@ page import="com.service.impl.MsgUserServiceImpl" %>
<%@ page import="com.entity.Message" %>
<%@ page import="com.entity.UserTeacher" %>
<%@ page import="com.entity.UserStudent" %>

<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>消息详情标题</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
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
        int id = Integer.valueOf(request.getParameter("id"));
//    System.out.println(id);
        MsgUserServiceImpl msgUserService = new MsgUserServiceImpl();
        MsgUser msgUser = msgUserService.queryMessageById(id);
        msgUser.setReadFlag("1");
        msgUserService.isRead(msgUser);
        HttpSession session1 = request.getSession();
        UserStudent student = (UserStudent) session1.getAttribute("user");
    %>
    <script>
        var user_id = <%=student.getUser_id()%>;//todo:获取登入人id
        function clear() {
            console.log(1);
            $("#addtitle").val("");
            $("#addcontent").val("");
        }
    </script>


</head>
<body>

<div class="layui-fluid" id="LAY-app-message-detail">
    <div class="layui-card layuiAdmin-msg-detail">
            <div class="layui-card-header">
                <h1><%=msgUser.getTitle()%></h1>
                <p>
                    <span><%=msgUser.getMessage_time().substring(0,msgUser.getMessage_time().length()-2)%></span>
                </p>
                <p>
                    <span><%=msgUser.getSend_name()%></span>
                </p>
            </div>

            <div class="layui-card-body layui-text">
                <div class="layadmin-text">
                <%=msgUser.getContent()%>
                </div>

                <div style="padding-top: 30px;">
                    <a href="/Message.do?action=stuback" layadmin-event="back" class="back layui-btn layui-btn-primary layui-btn-sm" style="text-decoration: none">返回上级</a>
                    <script>
                        // $(".back").onclick(function () {
                        //     window.location.replace(-1);
                        // });
                    </script>
                    <a href=""  class="back layui-btn layui-btn-success layui-btn-sm" data-toggle="modal" data-target="#addModal" style="text-decoration: none">回信</a>
                    <%--<button class="button-add layui-btn layuiadmin-btn-admin" data-toggle="modal" data-target="#addModal">回信</button>--%>
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
                                            <label for="receive_name">收件人</label>
                                            <input type="text" name="receive_name" id="receive_name" autocomplete="off" disabled="true" value="<%=msgUser.getSend_name()%>"/>
                                            <input type="hidden" name="receive_id" id="receive_id" value="<%=msgUser.getSend_id()%>">
                                            <script>
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
                                <button type="button" class="shut layui-btn layui-btn-primary" data-dismiss="modal" id="button-add-close">
                                    关闭
                                </button>
                                <button type="button" class="send  layui-btn layui-btn" id="button-add-handup">发送</button>
                                <script>
                                    $(".shut").on("click",function () {
                                        clear()
                                    })
                                    $(".send").on("click", function () {
                                        var receive_id = $("#receive_id").val();
                                        var title = $("#addtitle").val();
                                        var content = $("#addcontent").val();
                                        // var send_id = user_id;
                                        $.ajax({
                                            url: "/Message.do",
                                            data: {action: "send", receive_id: receive_id,send_id:user_id,title:title,content:content},
                                            type: "GET",
                                            dataType: "text",
                                            success: function (data) {
                                                if (data > 0) {
                                                    swal("发送成功", "", "success");
                                                } else {
                                                    swal("发送失败", "", "error");
                                                }
                                                $("#addModal").modal("hide");
                                                clear();
                                                // changepage(currentPage);                                            // console.log(data);
                                            }
                                        });
                                    });
                                </script>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>

            </div>

            </div>
    </div>
</div>

<script src="../../../src/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../../../src/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index']);
</script>
</body>
</html>