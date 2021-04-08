<%@page import="supporter.SupporterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));

SupporterDAO sdao=new SupporterDAO();

sdao.deleteBoard(num);
	
response.sendRedirect("myCats.jsp");

%>