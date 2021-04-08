<%@page import="board.QnADAO"%>
<%@page import="board.QnABean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int code=Integer.parseInt(request.getParameter("code"));
String subject=request.getParameter("subject");
String content=request.getParameter("content");

QnABean qb = new QnABean();
qb.setCode(code);
qb.setSubject(subject);
qb.setContent(content);

QnADAO qdao = new QnADAO();
qdao.updateBoard(qb);

response.sendRedirect("qna.jsp");
%>