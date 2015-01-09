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
<title>简单分页</title>
<!-- extjs的样式文件 -->
<link rel="styleSheet" href="../js/extjs/resources/css/ext-all.css">
<!-- extjs的核心文件 -->
<script type="text/javascript" src="../js/extjs/ext-all-debug.js"></script>
<!-- 国际化文件 -->
<script type="text/javascript" src="../js/extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
Ext.onReady(function () {
	//1.定义Model
	Ext.define("MyApp.model.User", {
	    extend: "Ext.data.Model",
	    fields: [
	        { name: 'name', type: 'string' },
	        { name: 'age', type: 'int' },
	        { name: 'phone', type: 'string' }
	    ]
	});
	
	//2.创建store
	var store = Ext.create("Ext.data.Store", {
	    model: "MyApp.model.User",
	    autoLoad: true,
	    pageSize: 5,
	    proxy: {
	        type: "ajax",
	        url: "<%=basePath %>/UserServlet",
	        reader: {
	            root: "root",
	            totalProperty:"total"
	        }
	    }
	});
	
	
	//3.创建grid
	var grid = Ext.create("Ext.grid.Panel", {
	    xtype: "grid",
	    store: store,
	    width: 500,
	    height: 200,
	    margin: 30,
	    columnLines: true,
	    renderTo: Ext.getBody(),
	    selModel: {
	        injectCheckbox: 0,
	        mode: "SIMPLE",     //"SINGLE"/"SIMPLE"/"MULTI"
	        checkOnly: true     //只能通过checkbox选择
	    },
	    selType: "checkboxmodel",
	    columns: [
	        { text: '姓名', dataIndex: 'name' },
	        {
	            text: '年龄', dataIndex: 'age', xtype: 'numbercolumn', format: '0',
	            editor: {
	                xtype: "numberfield",
	                decimalPrecision: 0,
	                selectOnFocus: true
	            }
	        },
	        { text: '电话', dataIndex: 'phone', editor: "textfield" }
	    ],
	    plugins: [
	        Ext.create('Ext.grid.plugin.CellEditing', {
	            clicksToEdit: 1
	        })
	    ],
	    listeners: {
	        itemdblclick: function (me, record, item, index, e, eOpts) {
	            //双击事件的操作
	        }
	    },
	    //ttbar在上部
	    bbar: { xtype: "pagingtoolbar", store: store, displayInfo: true }
	});
	  //  grid.render('gridview'); 
}); 
</script>
</head>
<body>
	<div id="gridview" align="center"></div>
</body>
</html>