package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.naming.java.javaURLContextFactory;

import Bean.DBBean;
import Entity.Record;

/**
 *  RecordServlet 处理事件记录的增删改查
 */
public class RecordServlet extends HttpServlet {
  
    public RecordServlet() {
        super();
    }


	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action=request.getParameter("action");
		if(action.equals("add")) //处理add请求
			this.doAdd(request, response);
		if(action.equals("delete"))//处理delete请求
			this.doDelete(request, response);
		if(action.equals("change"))//处理change请求
			this.doChange(request, response);
	}
	
	/*
	 * 处理新增请求
	 */
	public void doAdd(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String title=request.getParameter("title");
		title=URLDecoder.decode(title,"utf-8");//解码
		String content=request.getParameter("content");
		content=URLDecoder.decode(content,"utf-8");//解码
		String time=request.getParameter("time");
		time=URLDecoder.decode(time,"utf-8");//解码
		Record record=new Record(title,content,time);
		DBBean db=new DBBean();
		Boolean isSuccess=false;//用于判断是否存入成功
		isSuccess=db.insertRecord(record);//将事件记录存入数据库
		if(isSuccess){
			out.print("success");
		}else {
			out.print("fail");
		}
		out.flush();
		out.close();
	}
	
	/*
	 * 处理删除请求
	 */
	public void doDelete(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		int id=Integer.valueOf(request.getParameter("id"));
		Record record=new Record(id,"","","");
		DBBean db=new DBBean();
		Boolean isSuccess=false;//用于判断是否删除成功
		isSuccess=db.deleteRecord(record);//删除事件记录
		if(isSuccess){
			out.print("success");
		}else {
			out.print("fail");
		}
		out.flush();
		out.close();
	}
	
	/*
	 * 处理修改请求
	 */
	public void doChange(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		int id=Integer.valueOf(request.getParameter("id"));
		String title=request.getParameter("title");
		title=URLDecoder.decode(title,"utf-8");//解码
		String content=request.getParameter("content");
		content=URLDecoder.decode(content,"utf-8");//解码
		String time=request.getParameter("time");
		time=URLDecoder.decode(time,"utf-8");//解码
		Record record=new Record(id,title,content,time);
		DBBean db=new DBBean();
		Boolean isSuccess=false;//用于判断是否修改成功
		isSuccess=db.changeRecord(record);//修改事件记录
		if(isSuccess){
			out.print("success");
		}else {
			out.print("fail");
		}
		out.flush();
		out.close();
	}

}
