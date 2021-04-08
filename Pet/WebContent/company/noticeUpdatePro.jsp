<%@page import="board.NoticeDAO"%>
<%@page import="board.NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));
String name=request.getParameter("name");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

NoticeBean nb=new NoticeBean();
nb.setNum(num);
nb.setName(name);
nb.setSubject(subject);
nb.setContent(content);

NoticeDAO ndao=new NoticeDAO();

ndao.updateBoard(nb);
	
response.sendRedirect("notice.jsp");

%>