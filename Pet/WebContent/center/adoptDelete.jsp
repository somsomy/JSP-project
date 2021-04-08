<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));

BoardDAO bdao=new BoardDAO();

bdao.deleteBoard(num);
	
response.sendRedirect("adopt.jsp");
	
%>