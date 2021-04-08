<%@page import="board.ReplyBean"%>
<%@page import="board.ReplyDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int boardNum=Integer.parseInt(request.getParameter("boardNum"));

String name=request.getParameter("name");
String content=request.getParameter("content");

Timestamp date=new Timestamp(System.currentTimeMillis());

ReplyBean rb=new ReplyBean();
rb.setBoardNum(boardNum);
rb.setName(name);
rb.setContent(content);
rb.setDate(date);

ReplyDAO rdao=new ReplyDAO();
rdao.insertReply(rb);

response.sendRedirect("volunteerContent.jsp?num="+boardNum);

%>