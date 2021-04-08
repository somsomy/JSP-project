<%@page import="board.FindBoardDAO"%>
<%@page import="board.FindBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uploadPath=request.getRealPath("/images/uploadImage");
int maxSize=10*1024*1024;

MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

int num=Integer.parseInt(multi.getParameter("num"));
String subject=multi.getParameter("subject");
String name=multi.getParameter("name");
String cat=multi.getParameter("cat");
String reward=multi.getParameter("reward");
String catName=multi.getParameter("catName");
String catAge=multi.getParameter("catAge");
String catGender=multi.getParameter("catGender");
String catDate=multi.getParameter("catDate");
String catPlace=multi.getParameter("catPlace");
String content=multi.getParameter("content");
String file=multi.getFilesystemName("file");

if(file==null) {
	file=multi.getParameter("oldfile");
}

FindBoardBean fbb = new FindBoardBean();
fbb.setNum(num);
fbb.setSubject(subject);
fbb.setName(name);
fbb.setCat(cat);
fbb.setReward(reward);
fbb.setCatName(catName);
fbb.setCatAge(catAge);
fbb.setCatGender(catGender);
fbb.setCatDate(catDate);
fbb.setCatPlace(catPlace);
fbb.setContent(content);
fbb.setFile(file);

FindBoardDAO fbdao = new FindBoardDAO();
fbdao.updateBoard(fbb);
response.sendRedirect("catFind.jsp");
%>