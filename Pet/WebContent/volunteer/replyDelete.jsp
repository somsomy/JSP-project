<%@page import="java.sql.Timestamp"%>
<%@page import="board.ReplyBean"%>
<%@page import="board.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num=Integer.parseInt(request.getParameter("num"));
int boardNum=Integer.parseInt(request.getParameter("boardNum"));
int re_lev=Integer.parseInt(request.getParameter("re_lev"));
int re_ref=Integer.parseInt(request.getParameter("re_ref"));

Timestamp deleteAt=new Timestamp(System.currentTimeMillis());

ReplyBean rb=new ReplyBean();
rb.setNum(num);
rb.setBoardNum(boardNum);
rb.setRe_lev(re_lev);
rb.setRe_ref(re_ref);
rb.setDeleteAt(deleteAt);

ReplyDAO rdao=new ReplyDAO();

rdao.deleteReply(rb);

response.sendRedirect("volunteerContent.jsp?num="+boardNum);
%>