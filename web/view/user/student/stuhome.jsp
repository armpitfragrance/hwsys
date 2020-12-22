<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>主页</title>
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
    <script type="text/javascript">
        var currentPage = 1;
        var oldPageTotal = 0;//总页数

        $(function () {
            let title = null;
            let time = null;
            $.ajax({
                url: "/notice.do",
                data: {action: "search", pageNo: currentPage, title: title, time: time},
                type: "GET",
                dataType: "text",
                success: function (data) {
                    // console.log(data);
                    initDate(data);
                    console.log(data);
                }
            });


            <!--初始化页面-->
            function initDate(data) {

                let index = 1;
                let dataObj = JSON.parse(data);
                oldPageTotal = dataObj.pageTotal;
                <!--添加公告数据-->
                for (var a = 0; a <dataObj.items.length ; a++) {
                    var trNode = $("<blockquote class='layui-elem-quote'></blockquote>");
                    trNode.append("<div class='pad-btm'>" +
                        "<p class='layuiadmin-big-font'>\n" +
                        "<h3 align='center'>" + dataObj.items[a].title + "</h3>"+
                        "<span  class='layui-breadcrumb' lay-separator='-' style='visibility: visible;'>" +
                        "<a href='javascript:;'>" + dataObj.items[a].notice_time + "</a>" +
                        "</span>" +
                        "</p>" +
                        "</div>" +
                        "<p class='message-text'>" + dataObj.items[a].content + "</p>"
                    );
                    $("#notice").append(trNode);
                }
            };

            $(".more-btn").on("click",function () {
                currentPage = currentPage+1;
                let title = null;
                let time = null;
                $.ajax({
                    url: "/notice.do",
                    data: {action: "search", pageNo: currentPage, title: title, time: time},
                    type: "GET",
                    dataType: "text",
                    success: function (data) {
                        // console.log(data);
                        let jsonObj = JSON.parse(data);
                        initDate(data);
                    }
                });
            })
        })



    </script>

</head>

<body layadmin-themealias="default">

<div class="layui-fluid layadmin-message-fluid">
    <div class="layui-col-md12 layadmin-homepage-list-imgtxt message-content" id="notice" style="">

    </div>

    <div class="layui-row message-content-btn">
        <a href="#" class="more-btn layui-btn">更多</a>
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
</body>
</html>