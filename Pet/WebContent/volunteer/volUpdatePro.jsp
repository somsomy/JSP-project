<%@page import="board.VolunteerDAO"%>
<%@page import="board.VolunteerBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String uploadPath=request.getRealPath("/images/uploadImage");

int maxSize = 1024 * 1024 * 100;

String encoding = "UTF-8";

MultipartRequest multipartRequest

= new MultipartRequest(request, uploadPath, maxSize, encoding,

		new DefaultFileRenamePolicy());
int num=Integer.parseInt(multipartRequest.getParameter("num"));
String subject=multipartRequest.getParameter("subject");
String content=multipartRequest.getParameter("content");
String file= multipartRequest.getFilesystemName("file");
String state=multipartRequest.getParameter("state");

if(file==null) {
	file=multipartRequest.getParameter("oldfile");
}

VolunteerBean vb=new VolunteerBean();
VolunteerDAO vdao=new VolunteerDAO();

vb.setNum(num);
vb.setSubject(subject);
vb.setContent(content);
vb.setFile(file);
vb.setState(state);

vdao.updateBoard(vb);

response.sendRedirect("volunteerContent.jsp?num="+num);

%>