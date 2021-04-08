<%@page import="board.ComBoardDAO"%>
<%@page import="board.ComBoardBean"%>
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
String subject=multipartRequest.getParameter("subject");
String content=multipartRequest.getParameter("content");

String fileName = multipartRequest.getOriginalFileName("file");

String fileRealName = multipartRequest.getFilesystemName("file");

ComBoardBean cbb=new ComBoardBean();
cbb.setFileName(fileName);
cbb.setFileRealName(fileRealName);
cbb.setSubject(subject);
cbb.setContent(content);
cbb.setName(name);
cbb.setDate(date);
cbb.setReadcount(readcount);

ComBoardDAO cbdao=new ComBoardDAO();

cbdao.insertBoard(cbb);

response.sendRedirect("comment.jsp");
%>