<%@page import="Bean.DBBean"%>
<%@page import="Entity.Record"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>修改记录</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<link rel="stylesheet" href="css/basic.css">
	<link rel="stylesheet" href="css/delete2.css">
	 <!-- 配置文件 -->
	<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.config.js"></script>
	<!-- 编辑器源码文件 -->
	<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.all.min.js"> </script>
	<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
	<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	<script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
</head>
<body>
	<%
		int totalRecord=0;//总的记录条数
		DBBean db=new DBBean();
		totalRecord=db.getRecordCount();
		int id=1;//传来的id值，默认为1
		String content="";
		List<Record> records=null;
		Record selectR=new Record("","","");
		if(session.getAttribute("records")!=null){
			id=Integer.valueOf(request.getParameter("recordId"));
			records=(List<Record>)session.getAttribute("records");
			for(Record r: records){
				if(r.getId()==id){
					selectR=r;
				}
			}
		}else{//如果为空，则重定向到修改页面。避免直接输入delete2.jsp地址访问
			response.sendRedirect("delete.jsp");
		}
	%>
	<div id="home">
	<div id="header">
		<div id="WebTitle">
			<div class="maintitle"><a href="index.jsp">NoteBook of Eric Wu</a></div>
    		<div class="subtitle">The palest ink is better than the best memory !</div>
    	</div>

    	<div id="navigator">
			<ul id="navList">
				<li><a href="index.jsp">首页</a></li>
		    	<li><a href="add.jsp">新增</a></li>
		    	<li><a href="change.jsp">修改</a></li>
		       	<li><a href="delete.jsp">删除</a></li>
		    </ul>s
			<div id="Stats">
				记录-<%=totalRecord %>
			</div><!--end: Stats 状态-->
    	</div><!-- end: navigator 导航栏 -->
	</div><!-- end: header 头部 -->
	
	<div id="main">
   		<div id="content">
	   			<span class="successMessage" id="sMess"></span>
	   			<span class="failMessage" id="fMess"></span><br><br><br><br><br>
	   			<a href="delete.jsp">返回查看</a>
    	</div><!-- end: content 内容 -->
    </div><!-- end: main 主要部分 -->
    <div id="footer"> 	
    	Copyright &copy;2017 汕大-吴广林
    </div><!-- end: footer底部-->
    </div><!-- end: home 自定义的最大容器 -->
</body>
<script type="text/javascript">
window.onload=function(){
	startRequest();
}

  //创建XMLHttprequest 
	function createXMLHttpRequest(){ 
	    if(window.ActiveXObject){
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }else{
	        xmlhttp = new XMLHttpRequest();
	    }
	}
	//开始请求
	function startRequest(){   
		  	var url="http://localhost:8080/MyNoteBook/RecordServlet";
		    createXMLHttpRequest();
		    //设置状态改变时所调用的函数
		    xmlhttp.onreadystatechange = stateChange ;
		    //设置对服务器的调用
		    xmlhttp.open("POST",url,true);
		    //设置请求头
		    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=gb2312");
		    var id=<%= selectR.getId() %>;
		    //发送请求  
		    xmlhttp.send("action=delete&id="+id);
	}
	//监听服务器响应ajax请求
	function stateChange(){ 
		    if(xmlhttp.readyState==4){ 
		        if(xmlhttp.status==200){ 
		            //做你想在页面上做的事情 
		            //如果用户名密码正确返回success，错误返回fail
		            if(xmlhttp.responseText=="success"){ 
		            	document.getElementById("sMess").innerHTML="删除成功！";
		            }
		            else{
		            	document.getElementById("fMess").innerHTML="删除失败！";
		            }
		        }
		    }
		}
</script>
</html>