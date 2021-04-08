<%@page import="board.VolunteerDAO"%>
<%@page import="board.VolunteerBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%
request.setCharacterEncoding("utf-8");

Timestamp date=new Timestamp(System.currentTimeMillis());

int readcount=0; 

String uploadPath=request.getRealPath("/images/uploadImage");

int maxSize = 1024 * 1024 * 100;

String encoding = "UTF-8";

MultipartRequest multipartRequest

= new MultipartRequest(request, uploadPath, maxSize, encoding,

		new DefaultFileRenamePolicy());
String name=multipartRequest.getParameter("name");
String state=multipartRequest.getParameter("state");
String subject=multipartRequest.getParameter("subject");
String content=multipartRequest.getParameter("content");
String file = multipartRequest.getFilesystemName("file");


VolunteerBean vb=new VolunteerBean();
vb.setFile(file);
vb.setSubject(subject);
vb.setContent(content);
vb.setState(state);
vb.setName(name);
vb.setDate(date);
vb.setReadcount(readcount);

VolunteerDAO vbdao=new VolunteerDAO();

vbdao.insertBoard(vb);

response.sendRedirect("volunteer.jsp");

%>
