<%@page import="board.ReplyDAO"%>
<%@page import="board.ReplyBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int boardNum=Integer.parseInt(request.getParameter("boardNum"));
int re_lev=Integer.parseInt(request.getParameter("re_lev"));
int re_ref=Integer.parseInt(request.getParameter("re_ref"));
int re_seq=Integer.parseInt(request.getParameter("re_seq"));

String name=request.getParameter("name");
String content=request.getParameter("recontent");

Timestamp date=new Timestamp(System.currentTimeMillis());

ReplyBean rb=new ReplyBean();
rb.setBoardNum(boardNum);
rb.setRe_ref(re_ref);
rb.setRe_lev(re_lev);
rb.setRe_seq(re_seq);
rb.setName(name);
rb.setContent(content);
rb.setDate(date);

ReplyDAO rdao=new ReplyDAO();
rdao.reinsertReply(rb);

response.sendRedirect("volunteerContent.jsp?num="+boardNum);
%>