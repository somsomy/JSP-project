<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));
String name=request.getParameter("name");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

BoardBean bb=new BoardBean();
bb.setNum(num);
bb.setName(name);
bb.setSubject(subject);
bb.setContent(content);

BoardDAO bdao=new BoardDAO();

bdao.updateBoard(bb);
	
response.sendRedirect("adopt.jsp");

%>