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
    <style>



        .demo-carousel {
            height: 200px;
            line-height: 200px;
            text-align: center;
        }

        .code {
            width: 400px;
            margin: 0 auto;
        }

        .input-val {
            width: 295px;
            background: #ffffff;
            height: 2.8rem;
            padding: 0 2%;
            border-radius: 5px;
            border: none;
            border: 1px solid rgba(0, 0, 0, .2);
            font-size: 1.0625rem;
        }

        #canvas {
            float: right;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 3px;
            height: 38px;
            width: 105px;
            cursor: pointer;
            background-color: #ffffff;
        }

        .btn {
            width: 100px;
            height: 40px;
            background: #f1f1f1;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 20px auto 0;
            display: block;
            font-size: 1.2rem;
            color: #e22e1c;
            cursor: pointer;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
    </style>
    <script>
        function draw(show_num) {
            var canvas_width = $('#canvas').width();
            var canvas_height = $('#canvas').height();
            var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
            var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
            canvas.width = canvas_width;
            canvas.height = canvas_height;
            var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
            var aCode = sCode.split(",");
            var aLength = aCode.length;//获取到数组的长度

            for (var i = 0; i <= 3; i++) {
                var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
                var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
                var txt = aCode[j];//得到随机的一个内容
                show_num[i] = txt.toLowerCase();
                var x = 10 + i * 20;//文字在canvas上的x坐标
                var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
                context.font = "bold 23px 微软雅黑";

                context.translate(x, y);
                context.rotate(deg);

                context.fillStyle = randomColor();
                context.fillText(txt, 0, 0);

                context.rotate(-deg);
                context.translate(-x, -y);
            }
            for (var i = 0; i <= 5; i++) { //验证码上显示线条
                context.strokeStyle = randomColor();
                context.beginPath();
                context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
                context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
                context.stroke();
            }
            for (var i = 0; i <= 30; i++) { //验证码上显示小点
                context.strokeStyle = randomColor();
                context.beginPath();
                var x = Math.random() * canvas_width;
                var y = Math.random() * canvas_height;
                context.moveTo(x, y);
                context.lineTo(x + 1, y + 1);
                context.stroke();
            }
        }

        function randomColor() {//得到随机的颜色值
            var r = Math.floor(Math.random() * 256);
            var g = Math.floor(Math.random() * 256);
            var b = Math.floor(Math.random() * 256);
            return "rgb(" + r + "," + g + "," + b + ")";
        }

        var cookies = document.cookie.split(";");

        function getCk(mKey) {
            for (var i = 0; i < cookies.length; i++) {
                var kv = cookies[i].split('=');
                if (kv[0].trim() == mKey) {
                    return kv[1].trim();
                }
            }
        }

        $(function () {
            var remember = getCk('remember');
            var user_no = getCk('user_no');
            var password = getCk('password');
            var type = getCk('type');
            console.log(remember + "");
            console.log(user_no);
            console.log(password);
            console.log(type);
            if (remember == 'true') {

                $("#userNo").val(user_no);
                $("#password").val(password);
                $("#remember").prop("checked", remember);
                switch (type) {
                    case "admin":
                        $(':radio[name="role"]').eq(0).prop("checked", true);
                        break;
                    case "t":
                        $(':radio[name="role"]').eq(1).prop("checked", true);
                        break;
                    case "stu":
                        $(':radio[name="role"]').eq(2).prop("checked", true);
                        break;
                }
            }
            var show_num = [];
            draw(show_num);
            $("#canvas").on('click',function(){
                draw(show_num);
            })

        })
    </script>
</head>
<body layadmin-themealias="default" style="background-image:url('img/1121410.jpg');background-size: 100% 100%">

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

    <div class="layadmin-user-login-main"
         style="width: 450px;background-color: rgba(255,250,255,0.65);border-radius: 5px">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>学生作业管理系统</h2>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                       for="userNo"></label>
                <input type="text" name="userNo" id="userNo" lay-verify="username" placeholder="请输入学号/工号"
                       class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="password"></label>
                <input type="password" name="password" id="password" lay-verify="password"
                       placeholder="密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                       for="vercode"></label>
                <input type="text" name="vercode" id="vercode" lay-verify="vercode"
                       placeholder="验证码" class="layui-input" style="width: 300px;display: inline">
                <canvas id="canvas" width="100" height="43"></canvas>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 100px">所属职称：</label>
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
                <input type="checkbox" name="remember" id="remember" lay-skin="primary" title="记住密码">
                <div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>记住密码</span><i
                        class="layui-icon layui-icon-ok"></i></div>
                <a href="forget.html" class="layadmin-user-jump-change layadmin-link"
                   style="margin-top: 7px;margin-left: 8px">忘记密码？</a>
                <a href="reg.html" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px">注册帐号</a>
            </div>
            <div class="layui-form-item">
                <button class="login_btn layui-btn layui-btn-fluid" lay-submit="" lay-filter="LAY-user-login-submit">登
                    入
                </button>
                <SCRIPT>

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
    var isChecked = false;
    var show_num = [];
    $(function () {
        draw(show_num);
    })

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
        form.verify({
            username: function (value) {
                if (value.length < 1) {
                    return '请输入用户名';
                }
            },
            password:function (value) {
                if (value.length < 1) {
                    return '请输入密码';
                }
            },
            vercode:function (value) {
                var num = show_num.join("");
                if (value.length < 1) {
                    return '请输入验证码';
                }else if (value.toLowerCase()!=num) {
                    draw(show_num);
                    return '验证码错误';
                }else if (value.toLowerCase() == num) {
                    // isChecked = true;
                    var user_no = $("#userNo").val();
                    var password = $("#password").val();
                    var remember = $("#remember").prop("checked");
                    var type = $("input[name='role']:checked").val();
                    // console.log(user_no);
                    // console.log(password);
                    // console.log(type);
                    $.ajax({
                        url: "/login.do",
                        data: {user_no: user_no, password: password, type: type, remember: remember},
                        type: "POST",
                        dataType: "text",
                        success: function (data) {
                            var user = JSON.parse(data);
                            if (user != null) {
                                console.log(user);
                                if (type == "admin") {
                                    window.location.href = "view/admin/adminView.jsp";
                                } else if (type == "t") {
                                    window.location.href = "view/user/teacher/Tindex.jsp";
                                } else if (type == "stu") {
                                    window.location.href = "view/user/student/stuView.jsp";
                                }
                            } else {
                                swal("登入失败", "请检查账号或者密码是否输入正确", "error")
                            }
                        }
                    })
                }
            },
        })
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