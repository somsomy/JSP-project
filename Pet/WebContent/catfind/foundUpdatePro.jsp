<%@page import="board.FoundBoardDAO"%>
<%@page import="board.FoundBoardBean"%>
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


FoundBoardDAO fbdao=new FoundBoardDAO();
String fileName=multipartRequest.getParameter("fileRealName");
String oldfile=multipartRequest.getParameter("oldfile");

if(fileName!=null) {
	if(!fileName.equals(" ")&&file==null) {
		file=oldfile;
	}

	if(fileName.equals(" ")&&file==null) {
		fbdao.deleteFile(uploadPath, oldfile);
	} else if(fileName.equals(" ")&&file!=null) {
		fbdao.deleteFile(uploadPath, oldfile);
	}
}

FoundBoardBean fbb=new FoundBoardBean();

fbb.setNum(num);
fbb.setSubject(subject);
fbb.setContent(content);
fbb.setFile(file);

fbdao.updateBoard(fbb);

response.sendRedirect("foundContent.jsp?num="+num);

%>