<%@page import="board.NoticeDAO"%>
<%@page import="board.NoticeBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

Timestamp date=new Timestamp(System.currentTimeMillis());

int readcount=0; 

NoticeBean cb = new NoticeBean();
cb.setName(name);
cb.setSubject(subject);
cb.setContent(content);
cb.setDate(date);
cb.setReadcount(readcount);

NoticeDAO ndao = new NoticeDAO();

ndao.insertBoard(cb);

response.sendRedirect("notice.jsp");
%>