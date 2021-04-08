<%@page import="board.ReplyDAO"%>
<%@page import="board.ReplyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));
int boardNum=Integer.parseInt(request.getParameter("boardNum"));

String content=request.getParameter("recontent");

ReplyBean rb=new ReplyBean();
rb.setNum(num);
rb.setContent(content);

ReplyDAO rdao=new ReplyDAO();
rdao.updateReply(rb);

response.sendRedirect("volunteerContent.jsp?num="+boardNum);
%>