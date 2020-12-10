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
</head>
<body layadmin-themealias="default" style="">

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">标题</label>
                    <div class="layui-input-block">
                        <input type="text" name="t_no" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
                    <label class="layui-form-label">时间</label>
                    <div class="layui-input-block">
                        <input type="text" placeholder="请选择" class="layui-input" id="test1">
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-admin" lay-submit="" lay-filter="LAY-user-back-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-admin" data-type="batchdel">删除</button>
                <button class="layui-btn layuiadmin-btn-admin" data-type="add">添加</button>
            </div>

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
                                <th data-field="title">
                                    <div class="layui-table-cell laytable-cell-2-loginname"><span>标题</span></div>
                                </th>
                                <th data-field="content">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>内容</span></div>
                                </th>
                                <th data-field="notice_time">
                                    <div class="layui-table-cell laytable-cell-2-telphone"><span>发布时间</span>
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
                            <tbody>
                            <tr>
                                <td>
                                    <div class="layui-table-cell laytable-cell-2-0 laytable-cell-checkbox">
                                        <input type="checkbox" name="layTableCheckbox" lay-skin="primary" lay-filter="layTableAllChoose">
                                        <div class="layui-unselect layui-form-checkbox" lay-skin="primary">
                                            <i class="layui-icon layui-icon-ok"></i>
                                        </div>
                                    </div>
                                </td>
                                <td>1</td>
                                <td>维护</td>
                                <td>停机维护</td>
                                <td>2020-12-10 19:00:00</td>
                                <td style="text-align: center">
                                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                                            class="layui-icon layui-icon-edit"></i>编辑</a>
                                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                                            class="layui-icon layui-icon-delete"></i>删除</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
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
    <script src="../../src/layuiadmin/layui/layui.js" charset="utf-8"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
    <script>
        layui.use('laydate', function(){
            var laydate = layui.laydate;

            //执行一个laydate实例
            laydate.render({
                elem: '#test1' //指定元素
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

