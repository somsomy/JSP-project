<%@page import="board.ComBoardDAO"%>
<%@page import="board.ComBoardBean"%>
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
String fileName = multipartRequest.getOriginalFileName("file");
String fileRealName= multipartRequest.getFilesystemName("file");

ComBoardBean cbb=new ComBoardBean();
ComBoardDAO cbdao=new ComBoardDAO();

String file=multipartRequest.getParameter("fileRealName");
String oldfile=multipartRequest.getParameter("oldfile");
if(file!=null) {
	if(!file.equals(" ")&&fileRealName==null) {
		fileRealName=oldfile;
	} else {
		cbdao.deleteFile(uploadPath, oldfile);
	}
}

cbb.setNum(num);
cbb.setSubject(subject);
cbb.setContent(content);
cbb.setFileName(fileName);
cbb.setFileRealName(fileRealName);

cbdao.updateFileBoard(cbb);

response.sendRedirect("commentContent.jsp?num="+num);

%>