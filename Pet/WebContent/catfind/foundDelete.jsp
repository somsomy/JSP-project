<%@page import="board.FoundBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));

FoundBoardDAO fbdao=new FoundBoardDAO();

fbdao.deleteBoard(num);
	
response.sendRedirect("catFound.jsp");

%>