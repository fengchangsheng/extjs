<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- extjs的样式文件 -->
<link rel="styleSheet" href="../js/extjs/resources/css/ext-all.css">
<!-- extjs的核心文件 -->
<script type="text/javascript" src="../js/extjs/ext-all-debug.js"></script>
<!-- 国际化文件 -->
<script type="text/javascript" src="../js/extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	//确认框
	Ext.Msg.prompt('我是标题！','请输入姓名：',function(op,val){
		console.info(op);
		console.info(val);
	},this,true,'张三');
	
	//等待框
	Ext.Msg.wait('提示信息','我是内容',{
		interval:500,//循环定时的间隔
		duration:50000,//总时长
		increment:15,//执行进度条的次数
		text:'updating...',//进度条上的文字
		scope:this,
		fn:function(){
			alert('更新成功!');
		},
		animate:true           //进度条动画效果
	})
	
	//shwo方法
	Ext.Msg.show({
		title:'我是自定义的提示框',
		msg:'我是内容',
		width:300,
		height:300,
		buttons:Ext.Msg.YESNOCANCEL,//yes no cancel三个按钮
		icon:Ext.Msg.ERROR   //INFO Question WARING
	});
	
	
});



</script>
</head>
<body>

</body>
</html>