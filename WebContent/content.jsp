<%@page import="Entity.Record"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>这是一条看不见的标题</title>
	<link rel="stylesheet" href="css/content.css">
</head>
<body>
	<%
		int id=1;
		String content="";
		id=Integer.valueOf(request.getParameter("recordId"));
		List<Record> records=null;
		Record selectR=new Record("","","");
		if(session.getAttribute("records")!=null){
			records=(List<Record>)session.getAttribute("records");
			for(Record r: records){
				if(r.getId()==id){
					selectR=r;
				}
			}
		}else{//如果为空，则重定向到首页。避免直接输入content.jsp地址访问
			response.sendRedirect("index.jsp");
		}
		
	%>
	<div id="main">
   		<div id="content">
   			<%=selectR.getContent()%>
    	</div><!-- end: content 内容 -->
    </div><!-- end: main 主要部分 -->
</body>
<script type="text/javascript">
	window.onload=function(){
		document.title="<%=selectR.getTitle()%>";
	}
</script>
</html>