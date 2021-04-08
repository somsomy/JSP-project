<%@page import="board.FindBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));

FindBoardDAO fbdao=new FindBoardDAO();

fbdao.deleteBoard(num);
	
response.sendRedirect("catFind.jsp");

%>