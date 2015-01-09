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
<title>ExtJs grid CRUD</title>
<!-- extjs的样式文件 -->
<link rel="styleSheet" href="../js/extjs/resources/css/ext-all.css">
<!-- extjs的核心文件 -->
<script type="text/javascript" src="../js/extjs/ext-all-debug.js"></script>
<!-- 国际化文件 -->
<script type="text/javascript" src="../js/extjs/ext-lang-zh_CN.js"></script>
<!-- base on  ExtJs4.2 -->
<script type="text/javascript">
Ext.onReady(function(){
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
	//构造store
	var store = Ext.create('Ext.data.Store', {
        //autoLoad: true,
        autoSync: true,
        model: 'Person',
        proxy: {
             type: 'ajax',
             api: {
                read: '<%=basePath %>/AdminServlet?param=read',//查询
                create: '<%=basePath %>/AdminServlet?param=add',//创建
                update: '<%=basePath %>/AdminServlet?param=update',//更新
                destroy: '<%=basePath %>/AdminServlet?param=deletes'//删除
            },
            reader: {
                type: 'json',
                root: 'data'
            },
            writer: {
                type: 'json'
            }
        },
        listeners: {
            write: function(store, operation){
                var record = operation.getRecords()[0],
                    name = Ext.String.capitalize(operation.action),
                    verb;
                    
                if (name == 'Destroy') {
                    record = operation.records[0];
                    verb = 'Destroyed';
                } else {
                    verb = name + 'd';
                }
                Ext.example.msg(name, Ext.String.format("{0} user: {1}", verb, record.getId()));
            }
        }
    });
    
    store.load({
		params:{
			start:0,
			limit:20
		}
	});
    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
    	id:'edit',
        listeners: {
		  	edit:function(rowEditing,context){
		  		context.record.commit();
        		store.reload();//提交后重新加载   获取新数据   包括自动生成的id
        	}, 
            cancelEdit: function(rowEditing, context) {
                // Canceling editing of a locally added, unsaved record: remove it
                if (context.record.phantom) {
                    store.remove(context.record);
                }
            }
        }
    });

    //创建 panel
    var grid = Ext.create('Ext.grid.Panel', {
        renderTo: document.body,
        plugins: [rowEditing],
        width: 400,
        height: 300,
        frame: true,
        title: 'Users',
        store: store,
        iconCls: 'icon-user',
        columns: [{
            text: 'ID',
            width: 40,
            sortable: true,
            dataIndex: 'id'
        }, {
            text: 'Email',
            flex: 1,
            sortable: true,
            dataIndex: 'email',
            field: {
                xtype: 'textfield'
            }
        }, {
            header: 'First',
            width: 80,
            sortable: true,
            dataIndex: 'first',
            field: {
                xtype: 'textfield'
            }
        }, {
            text: 'Last',
            width: 80,
            sortable: true,
            dataIndex: 'last',
            field: {
                xtype: 'textfield'
            }
        }],
        dockedItems: [{
            xtype: 'toolbar',
            items: [{
                text: 'Add',
                iconCls: 'icon-add',
                handler: function(){
                    // empty record
                    store.insert(0, new Person());//从指定索引处开始插入  插入Model实例  并触发add事件
                    rowEditing.startEdit(0, 0);//开始编辑，并显示编辑器
                   
                }
            }, '-', {
                itemId: 'delete',
                text: 'Delete',
                iconCls: 'icon-delete',
                disabled: true,
                handler: function(){
                    var selection = grid.getView().getSelectionModel().getSelection()[0];
                    if (selection) {
                        store.remove(selection);
                    }
                }
            }]
        }]
    });
    grid.getSelectionModel().on('selectionchange', function(selModel, selections){
        grid.down('#delete').setDisabled(selections.length === 0);
    });
	
});

</script>
</head>
<body>

</body>
</html>