<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
request.setAttribute("basePath",  basePath);
%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆表单</title>
<!-- extjs的样式文件 -->
<link rel="styleSheet" href="../js/extjs/resources/css/ext-all.css">
<!-- extjs的核心文件 -->
<script type="text/javascript" src="../js/extjs/ext-all-debug.js"></script>
<!-- 国际化文件 -->
<script type="text/javascript" src="../js/extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
Ext.onReady(function () {
	var form = Ext.create("Ext.form.Panel", {
	    width: 500,
	    height: 300,
	    margin: 20,
	    title: "Form",
	    renderTo: Ext.getBody(),
	    collapsible: true,  //可折叠
	    autoScroll: true,   //自动创建滚动条
	    defaultType: 'textfield',
	    defaults: {
	        anchor: '100%',
	    },
	    fieldDefaults: {
	        labelWidth: 80,
	        labelAlign: "left",
	        flex: 1,
	        margin: 5
	    },
	    items: [
	        {
	            xtype: "container",
	            layout: "hbox",
	            items: [
	                { xtype: "textfield", name: "name", fieldLabel: "姓名", allowBlank: false },
	                { xtype: "numberfield", name: "age", fieldLabel: "年龄", decimalPrecision: 0, vtype: "age" }
	            ]
	        },
	        {
	            xtype: "container",
	            layout: "hbox",
	            items: [
	                { xtype: "textfield", name: "phone", fieldLabel: "电话", allowBlank: false, emptyText: "电话或手机号码" },
	                { xtype: "textfield", name: "phone", fieldLabel: "邮箱", allowBlank: false, emptyText: "Email地址", vtype: "email" }
	            ]
	        },
	        {
	            xtype: "textareafield",
	            name: "remark",
	            fieldLabel: "备注",
	            height: 50
	        }
	    ],
	    buttons: [
	        { xtype: "button", text: "保存" }//提交或保存事件绑定参见login.jsp
	    ]
	});
}); 
</script>
</head>
<body>

</body>
</html>