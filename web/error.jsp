<%--
  Created by IntelliJ IDEA.
  User: Y
  Date: 2020/12/22
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>报错啦</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="src/layuiadmin/style/admin.css" media="all">
    <link id="layuicss-layer" rel="stylesheet"
          href="https://www.layui.com/admin/std/dist/layuiadmin/layui/css/modules/layer/default/layer.css?v=3.1.1"
          media="all">
    <script>
        function fun() {
            window.parent.location.href='/index.jsp';
        }
    </script>
</head>
<body layadmin-themealias="default">


<div class="layui-fluid">
    <div class="layadmin-tips">
        <i class="layui-icon" face=""></i>
        <div class="layui-text">
            <h2>
                <span class="layui-anim layui-anim-loop layui-anim-">登录失效啦 请重新登录</span>
            </h2>
            <a onclick="fun()"> 返回登录界面</a>
        </div>
    </div>
</div>

<script src="src/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: 'src/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index']);
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
</body>
</html>