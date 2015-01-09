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
<title>常用表单</title>
<!-- extjs的样式文件 -->
<link rel="styleSheet" href="../js/extjs/resources/css/ext-all.css">
<link rel="styleSheet" href="../js/extjs/resources/ext-theme-neptune/ext-theme-neptune-all.css">
<!-- extjs的核心文件 -->
<script type="text/javascript" src="../js/extjs/ext-all-debug.js"></script>
<!-- 国际化文件 -->
<script type="text/javascript" src="../js/extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
Ext.onReady(function () {
    // HtmlEditor需要这个  
    Ext.QuickTips.init();  
  
    var form = new Ext.form.FormPanel({  
        buttonAlign: 'center',  
        width: 600,  
        title: 'form',  
        frame: true,  
        fieldDefaults: {  
            labelAlign: 'right',  
            labelWidth: 70  
        },  
        items: [{  
            xtype: 'container',  
            layout: 'column',  
            items: [{  
                columnWidth:.7,  
                xtype:'fieldset',  
                collapsible: true, //是否为可折叠  
                collapsed: false, //默认是否折叠  
                title: '单纯输入',  
                autoHeight:true,  
                defaults: {width: 300},  
                defaultType: 'textfield',  
                items: [{  
                    fieldLabel: '文本',  
                    name: 'text'  
                },{  
                    xtype: 'numberfield',  
                    fieldLabel: '数字',  
                    name: 'number'  
                },{  
                    xtype:"combo",  
                    fieldLabel: '选择',  
                    name: 'combo',  
                    store: new Ext.data.SimpleStore({  
                        fields: ['value', 'text'],  
                        data: [  
                            ['value1', 'text1'],  
                            ['value2', 'text2']  
                        ]  
                    }),  
                    displayField: 'text',  
                    valueField: 'value',  
                    mode: 'local',  
                    emptyText:'请选择'  
                },{  
                    xtype: 'datefield',  
                    fieldLabel: '日期',  
                    name: 'date'  
                },{  
                    xtype: 'timefield',  
                    fieldLabel: '时间',  
                    name: 'time'  
                },{  
                    xtype: 'textarea',  
                    fieldLabel: '多行',  
                    name: 'textarea'  
                },{  
                    xtype: 'hidden',  
                    name: 'hidden'  
                }]  
            },{  
                xtype: 'container',  
                columnWidth:.3,  
                layout:'form',  
                items:[{  
                    xtype:'fieldset',  
                    checkboxToggle:true, //多选  
                    title: '多选',  
                    autoHeight:true,  
                    defaultType: 'checkbox',  
                    hideLabels: true,  
                    style: 'margin-left:10px;',  
                    bodyStyle: 'margin-left:20px;',  
                    items: [{  
                        boxLabel: '首先要穿暖',  
                        name: 'check',  
                        value: '1',  
                        checked: true,  
                        width: 'auto'  
                    },{  
                        boxLabel: '然后要吃饱',  
                        name: 'check',  
                        value: '2',  
                        checked: true,  
                        width: 'auto'  
                    },{  
                        boxLabel: '房子遮风避雨',  
                        name: 'check',  
                        value: '3',  
                        width: 'auto'  
                    },{  
                        boxLabel: '行路方便',  
                        name: 'check',  
                        value: '4',  
                        width: 'auto'  
                    }]  
                },{  
                    xtype:'fieldset',  
                    checkboxToggle:true,  
                    title: '单选',  
                    autoHeight:true,  
                    defaultType: 'radio',  
                    hideLabels: true,  
                    style: 'margin-left:10px;',  
                    bodyStyle: 'margin-left:20px;',  
                    items: [{  
                        boxLabel: '渴望自由',  
                        name: 'rad',  
                        value: '1',  
                        checked: true,  
                        width: 'auto'  
                    },{  
                        boxLabel: '祈求爱情',  
                        name: 'rad',  
                        value: '2',  
                        width: 'auto'  
                    }]  
                }]  
            }]  
        },{  
            xtype: 'container',  
            layout: 'form',  
            items: [{  
                labelAlign: 'top',  
                xtype: 'htmleditor',  
                fieldLabel: '在线编辑器',  
                id: 'editor',  
                anchor: '98%',  
                height: 200  
            }]  
        }],  
        buttons: [{  
            text: '保存'  
        },{  
            text: '读取'  
        },{  
            text: '取消'  
        }]  
    });  
  
    form.render("form");  //渲染到某个div
}); 
</script>
</head>
<body>
<div id="form" align="center"></div>
</body>
</html>