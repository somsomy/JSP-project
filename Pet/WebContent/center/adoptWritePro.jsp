<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
String catName=request.getParameter("catName");

Timestamp date=new Timestamp(System.currentTimeMillis());

int readcount=0; 

BoardBean bb = new BoardBean();
bb.setName(name);
bb.setCatName(catName);
bb.setSubject(subject);
bb.setContent(content);
bb.setDate(date);
bb.setReadcount(readcount);

BoardDAO bdao = new BoardDAO();

bdao.insertBoard(bb);

response.sendRedirect("adopt.jsp");
%>