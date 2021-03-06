<%@page import="Bean.DBBean"%>
<%@page import="Entity.Record"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除记录</title>
	<link rel="stylesheet" href="css/basic.css">
	<link rel="stylesheet" href="css/index.css">
</head>
<body>
<%
	int totalRecord=0;//总的记录条数
	int totalPage=1;//总的页面数
	int pageIndex=1;//当前页面号，用于控制页面翻转，默认为1
	List<Record> records=null;
	DBBean db=new DBBean();
	totalRecord=db.getRecordCount();
	totalPage=(totalRecord-1)/10+1;
	System.out.println("total"+totalPage);
	if(request.getParameter("pageIndex")!=null){//翻页后加载
		//要做下数据类型转换
		pageIndex=Integer.valueOf(request.getParameter("pageIndex"));
		System.out.println("page:"+pageIndex);
		records=db.getRecords(pageIndex);//获取一页的事件记录集,共10条
	}else{//第一次加载
		records=db.getRecords(pageIndex);//获取一页的事件记录集,共10条
	}
	session.setAttribute("records", records);//便于后面使用
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
		    </ul>
			<div id="Stats">
				记录-<%=totalRecord %>
			</div><!--end: Stats 状态-->
    	</div><!-- end: navigator 导航栏 -->
	</div><!-- end: header 头部 -->
	
	<div id="main">
   		<div id="content">
   			<form id="searchForm" name="searchForm" action="delete.jsp"  method="post">
				<input type="hidden" name="pageIndex" id="pageIndex"  value="1"></input>
			</form>
			<span class="titleStyle">请选择你要删除的记录:</span><br>
   			<table>
				<tr>
					<th width="10%">序号</th>
					<th width="60%">标题</th>
					<th width="30%">时间</th>
				</tr>
				<%
					int count=0;
					if(records!=null){
						for(Record r: records){
							count++;
				%>
				<tr>
					<td class="center"><%= count %></td>
					<td><a href="delete2.jsp?recordId=<%= r.getId() %>"><%= r.getTitle() %></a></td>
					<td class="center"><%= r.getTime() %></td>
				</tr>
				<%	
						}
					}
				%>
				 <tr class="alt" >
					<td class="center" colspan="3">
						共<%= totalRecord %>条记录&nbsp;&nbsp;&nbsp;
						共<%= totalPage %>页&nbsp;&nbsp;&nbsp;
						每页10条&nbsp;&nbsp;&nbsp;
						当前第<%= pageIndex %>页&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0);" class="turnPage" onclick="turnTopPage()">上一页</a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0);" class="turnPage" onclick="turnBottomPage()">下一页</a>&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
   			</table>
    	</div><!-- end: content 内容 -->
    </div><!-- end: main 主要部分 -->

    <div id="footer"> 	
    	Copyright &copy;2017 汕大-吴广林
    </div><!-- end: footer底部-->
    </div><!-- end: home 自定义的最大容器 -->
</body>

<script type="text/javascript">
	var pageIndex=<%=pageIndex %>;
	var totalPage=<%=totalPage %>;
	console.log(pageIndex);
	//上一页
	function turnTopPage(){
		if(pageIndex==1){
	        return;
	    }else{
	        document.getElementById("pageIndex").value=pageIndex-1;
	        document.getElementById("searchForm").submit();
	    }
	}
	//下一页
	function turnBottomPage(){
		if(pageIndex>=totalPage){	
            return;
 	  	}else{
 		  document.getElementById("pageIndex").value=pageIndex+1;
 		  document.getElementById("searchForm").submit();
   		}
	}
</script>
</html>