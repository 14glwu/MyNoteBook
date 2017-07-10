<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>添加记录</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<link rel="stylesheet" href="css/basic.css">
	<link rel="stylesheet" href="css/add.css">
	 <!-- 配置文件 -->
	<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.config.js"></script>
	<!-- 编辑器源码文件 -->
	<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.all.min.js"> </script>
	<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
	<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	<script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
</head>
<body>
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
		    </ul>
			<div id="Stats">
				记录-2&nbsp;
				收藏-0&nbsp;
			</div><!--end: Stats 状态-->
    	</div><!-- end: navigator 导航栏 -->
	</div><!-- end: header 头部 -->
	
	<div id="main">
   		<div id="content">
	   			<span class="titleStyle">标题:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   			<span class="successMessage" id="sMess"></span>
	   			<span class="failMessage" id="fMess"></span>
				<button class="button" onclick="startRequest();return false;">提交</button><br>
	   			<input type="text" id="title" name="title">
	   			<span class="titleStyle">内容:</span><br>
	   			<!-- Ueditor 富文本编辑器 -->
				<div id="editor" name="content" type="text/plain" style="height:400px;"></div>
    	</div><!-- end: content 内容 -->
    </div><!-- end: main 主要部分 -->
    <div id="footer"> 	
    	Copyright &copy;2017 汕大-吴广林
    </div><!-- end: footer底部-->
    </div><!-- end: home 自定义的最大容器 -->
</body>

<script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    
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
		    var time=getTime();
		    var title=document.getElementById("title").value;
		    var content=ue.getContent();
		    //发送请求  
		    xmlhttp.send("action=add&time="
		    		+encodeURIComponent(encodeURIComponent(time))
		    		+"&title="+encodeURIComponent(encodeURIComponent(title))
		    		+"&content="+encodeURIComponent(encodeURIComponent(content)));
	}
	//监听服务器响应ajax请求
	function stateChange(){ 
		    if(xmlhttp.readyState==4){ 
		        if(xmlhttp.status==200){ 
		            //做你想在页面上做的事情 
		            //如果用户名密码正确返回success，错误返回fail
		            if(xmlhttp.responseText=="success"){ 
		            	document.getElementById("sMess").innerHTML="提交成功！";
		            }
		            else{
		            	document.getElementById("fMess").innerHTML="提交失败！";
		            }
		        }
		    }
		}
	//获取提交时系统当前时间
	function getTime(){
		var myDate=new Date();
		return myDate.toLocaleString();
	}
	

</script>

</html>