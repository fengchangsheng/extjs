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
	// 1、 步骤导入库文件
    Ext.require([
        'Ext.form.*',
        'Ext.tip.QuickTipManager'
    ]);
     
    Ext.onReady(function() {
     
        // 2、步骤设置提示
        Ext.tip.QuickTipManager.init();
         
        Ext.create('Ext.form.Panel', {
            title: '上传文件',
            width: 400,
            bodyPadding: 10,
            frame: true,
            renderTo: Ext.getBody(),
            items: [{
                xtype: 'filefield',
                name: 'photo-path', // 服务端获取 “名称”
                afterLabelTextTpl:  '<span style="color:red;font-weight:bold" data-qtip="必需填写">*</span>',
                fieldLabel: '文件',
                labelWidth: 50,
                msgTarget: 'side', //  提示 文字的位置 \title\under\none\side\[element id]
                allowBlank: false,
                anchor: '100%',
                buttonText: '选择文件'
            }],

            buttons: [{
                text: '上传',
                handler: function() {
                    var form = this.up('form').getForm();
                    if(form.isValid()){ // form 验证
                        form.submit({ // 提交
                            url: '',
                            waitMsg: '正在上传...',
                            success: function(fp, o) {
                                Ext.Msg.alert('上传成功', '您的文件 "' + o.result.fileName + '" 成功的保存服务器上...');
                            }
                        });
                    }
                }
            }]
        });
    });
});



</script>
</head>
<body>

</body>
</html>