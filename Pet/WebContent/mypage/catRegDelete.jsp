<%@page import="cats.CatsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int catId=Integer.parseInt(request.getParameter("catId"));

CatsDAO cdao=new CatsDAO();

cdao.deleteCats(catId);
	
response.sendRedirect("catList.jsp");

%>