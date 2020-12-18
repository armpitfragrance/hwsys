<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/12/17
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程详情</title>
    <link href="../../../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../../src/layuiadmin/style/admin.css" media="all">

    <link rel="stylesheet" type="text/css" href="https://www.huangwx.cn/css/sweetalert.css">
    <script type="text/javascript" src="https://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script type="text/javascript" src="../../../js/bootstrap.min.js"></script>
</head>
<body>
<%
    String t_id = request.getParameter("t_id");
    String c_id = request.getParameter("c_id");
    System.out.println(t_id);
    System.out.println(c_id);
%>
<div style="float: left;margin-left:20px;margin-top: 10px;width: 500px;" class="layui-breadcrumb" lay-separator="|"> <a href="StuCourseManage.jsp" style="font-size: 22px">&lt;&lt;返回</a></div>
<div style="float:right;margin-top: 10px;width: 500px;" class="layui-breadcrumb" lay-separator="|" >
    <a href="stucoursedetail1.jsp" target="myFrame" style="font-size: 22px">课程详情</a>
    <a href="homewokeManage.jsp?c_id=<%=c_id%>&t_id=<%=t_id%>" target="myFrame" style="font-size: 22px">作业</a>
    <a href="tMaterial.jsp?c_id=<%=c_id%>" target="myFrame" style="font-size: 22px">教学资料</a>
</div><hr>
<iframe name="myFrame" width="100%" height="100%" style="border: medium none" src="stucoursedetail1.jsp"></iframe>










<script src="../../../src/layuiadmin/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use('element', function() {
        var element = layui.element;
        element.init();
    });
</script>
</body>
</html>
