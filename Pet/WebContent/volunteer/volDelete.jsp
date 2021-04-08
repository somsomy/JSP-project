<%@page import="board.VolunteerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int num=Integer.parseInt(request.getParameter("num"));

VolunteerDAO vdao=new VolunteerDAO();

vdao.deleteBoard(num);
	
response.sendRedirect("volunteer.jsp");
%>