<%@page import="board.ComBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));

ComBoardDAO cbdao=new ComBoardDAO();

cbdao.deleteBoard(num);
	
response.sendRedirect("comment.jsp");

%>