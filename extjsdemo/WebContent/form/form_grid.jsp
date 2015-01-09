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
<title>Insert title here</title>
<!-- extjs的样式文件 -->
<link rel="styleSheet" href="../js/extjs/resources/css/ext-all.css">
<!-- extjs的核心文件 -->
<script type="text/javascript" src="../js/extjs/ext-all-debug.js"></script>
<!-- 国际化文件 -->
<script type="text/javascript" src="../js/extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
Ext.onReady(function () {
	
	
	Ext.QuickTips.init(); //显示提示信息 
	
	Ext.define('Person', {
	    extend: 'Ext.data.Model',
	    fields: [{name: 'id',
	        type: 'int',
	        useNull: true
	    }, 'email', 'first', 'last'],
	    validations: [{ type: 'length',
	        field: 'email',
	        min: 1
	    }, {type: 'length',
	        field: 'first',
	        min: 1
	    }, {type: 'length',
	        field: 'last',
	        min: 1
	    }]
	});
    
    // 相当于一个数据源  
    var store = new Ext.data.JsonStore({  
    	model:'Person',
        proxy: {
            type: 'ajax',
            url: '<%=basePath %>/AdminServlet?param=read',
            reader: {
                type: 'json',
                root: 'data',
                totalProperty:"total"
            }
        },
    });  
      
    //1将向后台发出一个请求，请求中包含的参数是start和limit(每页显示的行数)  
    store.load({params:{start:0,limit:20}});  
  
    //CheckBox选择框  
    var sm = new Ext.grid.CheckboxSelectionModel();  
      
    //创建表单的窗口  
    var createFormWindow = function(){  
      
        var postForm = new Ext.form.FormPanel({  
            baseCls: 'x-plain',  
            defaultType: 'textfield',  
            items: [  
                {  
                    xtype:"hidden",  
                    name:"id"  
                },  
                {  
                    fieldLabel:"email",  
                    name:"email"  
                },  
                {  
                    fieldLabel:"first",  
                    name:"first"  
                },  
                {  
                    fieldLabel:"last",  
                    name:"last"  
                }
            ],  
            buttons: [  
                {  
                    xtype:'button',  
                    text: '保存',  
                    handler:function(){  
                        Ext.MessageBox.show({  
                           msg: '正在保存，请稍等...',  
                           progressText: 'Saving...',  
                           width:300,  
                           wait:true,  
                           waitConfig: {interval:200},  
                           icon:'download'  
                       });  
                       postForm.form.doAction('submit',{//2通过form向后台发出请求  
                         url:"person!save.action",  
                         method:'post',  
                         params:'',  
                         success:function(form,action){  
                            Ext.MessageBox.hide();  
                            Ext.Msg.alert('恭喜','保存目标成功');  
                            store.reload();  
                            postWindow.destroy();  
                         },  
                         failure:function(){  
                                Ext.Msg.alert('错误','服务器出现错误请稍后再试！');  
                         }  
                      });                        
                    }  
                },  
                {  
                    text: '取消',  
                    handler:function(){  
                        postWindow.destroy();  
                    }  
                }  
            ]             
        });  
          
          
        //将表单放到一个窗口中，并显示  
        var postWindow = new Ext.Window({  
            title: "人员信息表单",  
            width: 600,  
            height:500,  
            collapsible:true,  
            maximizable:true,  
            layout: 'fit',  
            plain:true,  
            bodyStyle:'padding:5px;',  
            modal:true,  
            items: postForm  
        });  
          
        postWindow.show();  
        return postForm;  
    };    
      
    var tbars = [ //在GridPanel列表界面头部的按钮，包括：添加、删除按钮  
        //添加按钮  
        {  
            text:'添加',  
            tooltip:'添加记录',  
            handler:createFormWindow  
        },  
        {xtype:'tbseparator'},  
        //删除按钮  
        {  
            text:'删除',  
            tooltip:'删除选中的记录',  
            handler:function(){  
            var _record = sm.getSelected();  
            if(_record){  
                //提示是否删除数据  
                Ext.Msg.confirm("是否要删除？","是否要删除这些被选择的数据？",  
                    function(btn){  
                        if(btn == "yes"){  
                            var ss = sm.getSelections();  
                            var delUrl = "person!del.action?";  
                            for(var i=0; i<ss.length; i++){  
                                delUrl = delUrl + "ids=" + ss[i].data.id + "&";  
                                 //ds.remove(ss[i]);  
                            }  
                            //3发出AJAX请求删除相应的数据！  
                            //delUrl=person!del.action?ids=1&ids=2&ids=3&;  
                            Ext.Ajax.request({  
                                url:delUrl,  
                                success:function(){  
                                    Ext.Msg.alert("删除信息成功","您已经成功删除信息！");  
                                    store.reload();  
                                },  
                                failure:function(){  
                                    Ext.Msg.alert('错误','服务器出现错误请稍后再试！');  
                                }  
                            });  
                        }  
                    }  
                );  
            }else{  
                Ext.Msg.alert('删除操作','您必须选择一行数据以便删除！');  
            }  
        }  
        }  
    ];        
      
  
      
    // create the Grid  
    var grid = new Ext.grid.GridPanel({  
        store: store,  
        columns: [  
            sm,  
            {header: "序号", width: 50, sortable: true, dataIndex: 'id'},  
            {header: "姓名", width: 275, sortable: true,  dataIndex: 'email'},  
            {header: "性别", width: 100, sortable: true,  dataIndex: 'first'},  
            {header: "年龄", width: 100, sortable: true,  dataIndex: 'last'} 
        ],  
        height:350,  
        width:900,  
        title:'人员数据信息列表',  
        sm : sm,  
        bbar:new Ext.PagingToolbar({  
            pageSize: 20,  
            store: store,  
            displayInfo: true,  
            displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',  
            emptyMsg: "没有记录"  
        }),  
        tbar:tbars  
    });  
      
    grid.on("rowdblclick",function(){  
        var _record = sm.getSelected();  
        if(_record){  
            var postForm = createFormWindow();  
            postForm.load({//4加载后台数据另一种方式  
                url : 'person!updateInput.action?id='+_record.get("id"),  
                waitMsg : '正在载入数据...',  
                method:"get",  
                failure : function(e) {  
                    Ext.Msg.alert('编辑', '载入失败'+e);  
                }  
            });  
        }else{  
            Ext.Msg.alert('修改操作','您必须选择一行数据以便修改！');  
        }  
    });  
  
    grid.render('grid-example');  
    
});
</script>
</head>
<body>
<div id="grid-example"></div>
</body>
</html>