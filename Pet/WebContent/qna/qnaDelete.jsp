<%@page import="board.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int code=Integer.parseInt(request.getParameter("code"));

QnADAO qdao=new QnADAO();

qdao.deleteBoard(code);
	
response.sendRedirect("qna.jsp");

%>