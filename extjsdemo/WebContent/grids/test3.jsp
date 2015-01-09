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
<title>分页列表展示</title>
<!-- extjs的样式文件 -->
<link rel="styleSheet" href="../js/extjs/resources/css/ext-all.css">
<!-- extjs的核心文件 -->
<script type="text/javascript" src="../js/extjs/ext-all-debug.js"></script>
<!-- 国际化文件 -->
<script type="text/javascript" src="../js/extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
Ext.onReady(function () {
    var store = Ext.create('Ext.data.Store', {
        fields: ["cataId", "cataNo", "cataRemark", "cataTitle", "cataObjectName", "cataeditstatusName",
             "cataPublishName", "cataEndDate", "holyUpdateTime", "catapushtime"],
        pageSize: 5,  //页容量5条数据
        //是否在服务端排序 （true的话，在客户端就不能排序）
        remoteSort: false,
        remoteFilter: true,
        proxy: {
            type: 'ajax',
            url: '<%=basePath %>/GridsServlet',
            reader: {   //这里的reader为数据存储组织的地方，下面的配置是为json格式的数据，例如：[{"total":50,"rows":[{"a":"3","b":"4"}]}]
                type: 'json', //返回数据类型为json格式
                root: 'rows',  //数据
                totalProperty: 'total' //数据总条数
            }
        },
        sorters: [{
            //排序字段。
            property: 'ordeId',
            //排序类型，默认为 ASC 
            direction: 'desc'
        }],
        autoLoad: true  //即时加载数据
    });

    var grid = Ext.create('Ext.grid.Panel', {
    renderTo: Ext.getDom('cata'),
    store: store,
    height: 400,
    width:800,
    selModel: { selType: 'checkboxmodel' },   //选择框
    columns: [                    
                  { text: '型录ID', dataIndex: 'cataId', align: 'left', maxWidth: 80 },
                  { text: '型录编号', dataIndex: 'cataNo',  maxWidth: 120 },
                  { text: '助记标题', dataIndex: 'cataTitle', align: 'left', minWidth: 80 },
                  { text: '应用对象', dataIndex: 'cataObjectName', maxWidth: 80, align: 'left' },                        
                  { text: '发布状态', dataIndex: 'cataPublishName', maxWidth: 80 },
                  { text: '活动截止日期', dataIndex: 'cataEndDate',xtype:'datecolumn',dateFormat :'Y-m-d H:i:s' },
                  { text: '更新时间', dataIndex: 'holyUpdateTime',xtype:'datecolumn',dateFormat :'Y-m-d H:i:s'},
                  { text: '发布时间', dataIndex: 'catapushtime',xtype:'datecolumn',dateFormat :'Y-m-d H:i:s'}
               ],
    bbar: [{
        xtype: 'pagingtoolbar',
        store: store,
        displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
        emptyMsg: "没有数据",
        beforePageText: "当前页",
        afterPageText: "共{0}页",
        displayInfo: true                 
    }],
     listeners: { 'itemclick': function (view, record, item, index, e) {
       Ext.MessageBox.alert("标题",record.data.cataId);
    }
    },
     tbar:[
     {text:'新增',iconCls:'a_add',handler:showAlert},"-",
     {text:'编辑',iconCls:'a_edit2',handler:showAlert},"-",
     {text:'停用/启用',iconCls:'a_lock'},"-",
     {text:'发布',iconCls:'a_upload',handler:showAlert},"-",
     {text:'组织型录',iconCls:'a_edit',handler:showAlert},"-",
     {text:'管理商品',iconCls:'a_edit',handler:showAlert},"-",
     "->",{ iconCls:"a_search",text:"搜索",handler:showAlert}], 
});
function showAlert (){
var selectedData=grid.getSelectionModel().getSelection()[0].data;

Ext.MessageBox.alert("标题",selectedData.cataId);
}
}); 
</script>
</head>
<body>
<div id="cata" align="center"></div>
</body>
</html>