<%@page import="board.QnADAO"%>
<%@page import="board.QnABean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String name=request.getParameter("name");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

Timestamp date=new Timestamp(System.currentTimeMillis());

int readcount=0; 

QnABean qb = new QnABean();
qb.setName(name);
qb.setSubject(subject);
qb.setContent(content);
qb.setDate(date);
qb.setReadcount(readcount);

QnADAO qdao = new QnADAO();

qdao.insertBoard(qb);

response.sendRedirect("qna.jsp");
%>