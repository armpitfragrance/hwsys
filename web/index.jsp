<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="utf-8">
    <title>登入</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://www.huangwx.cn/css/sweetalert.css">
    <script type="text/javascript" src="https://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="../src/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../src/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="../src/layuiadmin/style/login.css" media="all">
    <link id="layuicss-layer" rel="stylesheet"
          href="https://www.layui.com/admin/std/dist/layuiadmin/layui/css/modules/layer/default/layer.css?v=3.1.1"
          media="all">

</head>
<body layadmin-themealias="default">

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

    <div class="layadmin-user-login-main" style="width: 450px">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>学生作业管理系统</h2>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                       for="userNo"></label>
                <input type="text" name="userNo" id="userNo" lay-verify="required" placeholder="请输入学号/工号"
                       class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="password"></label>
                <input type="password" name="password" id="password" lay-verify="required"
                       placeholder="密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <%--<div class="layui-col-xs7">--%>
                    <%--<label class="layadmin-user-login-icon layui-icon layui-icon-vercode"--%>
                    <%--for="LAY-user-login-vercode"></label>--%>
                    <%--<input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required"--%>
                    <%--placeholder="图形验证码" class="layui-input">--%>
                    <%--</div>--%>
                    <%--<div class="layui-col-xs5">--%>
                    <%--<div style="margin-left: 10px;">--%>
                    <%--<img src="https://www.oschina.net/action/user/captcha" class="layadmin-user-login-codeimg"--%>
                    <%--id="LAY-user-get-vercode">--%>
                    <%--</div>--%>
                    <%--</div>--%>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">所属职称：</label>
                <div class="layui-input-block">
                    <input type="radio" name="role" value="admin" title="管理员">
                    <div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i>
                        <div>管理员</div>
                    </div>
                    <input type="radio" name="role" value="t" title="教师">
                    <div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i>
                        <div>教师</div>
                    </div>
                    <input type="radio" name="role" value="stu" title="学生" checked="">
                    <div class="layui-unselect layui-form-radio layui-form-radioed"><i
                            class="layui-anim layui-icon"></i>
                        <div>学生</div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="margin-bottom: 20px; height: 50px">
                <input type="checkbox" name="remember" lay-skin="primary" title="记住密码">
                <div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>记住密码</span><i
                        class="layui-icon layui-icon-ok"></i></div>
                <a href="forget.html" class="layadmin-user-jump-change layadmin-link"
                   style="margin-top: 7px;margin-left: 8px">忘记密码？</a>
                <a href="reg.html" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px">注册帐号</a>
            </div>
            <div class="layui-form-item">
                <button class="login_btn layui-btn layui-btn-fluid" lay-submit="" lay-filter="LAY-user-login-submit">登 入</button>
            <SCRIPT>
                $(".login_btn").on("click", function () {
                    var user_no=$("#userNo").val();
                    var password = $("#password").val();
                    var type= $("input[name='role']:checked").val();

                    console.log(user_no);
                    console.log(password);
                    console.log(type);
                    $.ajax({
                        url: "/login.do",
                        data: { user_no: user_no, password:password,type: type},
                        type: "POST",
                        dataType: "text",
                        success: function (data) {
                            var user = JSON.parse(data);
                            if (user != null) {
                                if (type == "admin") {
                                    window.location.href = "view/admin/adminView.jsp";
                                } else if (type == "t") {
                                    window.location.href = "view/user/teacher/Tindex.jsp";
                                }else if (type == "stu") {
                                    window.location.href = "view/user/student/stuView.jsp";
                                }
                            } else {
                                swal("登入失败","请检查账号或者密码是否输入正确","error")
                            }
                        }
                    })
                });
            </SCRIPT>
            </div>
            <div class="layui-trans layui-form-item layadmin-user-login-other">
            </div>
        </div>
    </div>

    <div class="layui-trans layadmin-user-login-footer">
    </div>

    <!--<div class="ladmin-user-login-theme">
      <script type="text/html" template>
        <ul>
          <li data-theme=""><img src="{{ layui.setter.base }}style/res/bg-none.jpg"></li>
          <li data-theme="#03152A" style="background-color: #03152A;"></li>
          <li data-theme="#2E241B" style="background-color: #2E241B;"></li>
          <li data-theme="#50314F" style="background-color: #50314F;"></li>
          <li data-theme="#344058" style="background-color: #344058;"></li>
          <li data-theme="#20222A" style="background-color: #20222A;"></li>
        </ul>
      </script>
    </div>-->

</div>

<script src="../src/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../src/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user'], function () {
        var $ = layui.$
            , setter = layui.setter
            , admin = layui.admin
            , form = layui.form
            , router = layui.router()
            , search = router.search;

        form.render();

        //提交
        // form.on('submit(LAY-user-login-submit)', function (obj) {
        //
        //     //请求登入接口
        //     admin.req({
        //         url: layui.setter.base + 'json/user/login.js' //实际使用请改成服务端真实接口
        //         , data: obj.field
        //         , done: function (res) {
        //
        //             //请求成功后，写入 access_token
        //             layui.data(setter.tableName, {
        //                 key: setter.request.tokenName
        //                 , value: res.data.access_token
        //             });
        //
        //             //登入成功的提示与跳转
        //             layer.msg('登入成功', {
        //                 offset: '15px'
        //                 , icon: 1
        //                 , time: 1000
        //             }, function () {
        //                 location.href = '../'; //后台主页
        //             });
        //         }
        //     });
        //
        // });

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
<div class="layui-layer-move"></div>
</body>
</html>