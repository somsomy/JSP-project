<%@page import="board.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int num=Integer.parseInt(request.getParameter("num"));

NoticeDAO ndao=new NoticeDAO();

ndao.deleteBoard(num);
	
response.sendRedirect("notice.jsp");
	
%>