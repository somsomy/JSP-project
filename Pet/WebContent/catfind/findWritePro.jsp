<%@page import="board.FindBoardDAO"%>
<%@page import="board.FindBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uploadPath=request.getRealPath("/images/uploadImage");
int maxSize=10*1024*1024;

MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

String subject=multi.getParameter("subject");
String name=multi.getParameter("name");
String phone=multi.getParameter("phone");
String cat=multi.getParameter("cat");
String reward=multi.getParameter("reward");
String catName=multi.getParameter("catName");
String catAge=multi.getParameter("catAge");
String catGender=multi.getParameter("catGender");
String catDate=multi.getParameter("catDate");
String catPlace=multi.getParameter("catPlace");
String content=multi.getParameter("content");
String file=multi.getFilesystemName("file");

Timestamp date=new Timestamp(System.currentTimeMillis());
int readcount=0;

if(file!=null) {
FindBoardBean fbb = new FindBoardBean();
fbb.setSubject(subject);
fbb.setName(name);
fbb.setPhone(phone);
fbb.setCat(cat);
fbb.setReward(reward);
fbb.setCatName(catName);
fbb.setCatAge(catAge);
fbb.setCatGender(catGender);
fbb.setCatDate(catDate);
fbb.setCatPlace(catPlace);
fbb.setContent(content);
fbb.setDate(date);
fbb.setReadcount(readcount);
fbb.setFile(file);

FindBoardDAO fbdao = new FindBoardDAO();
fbdao.insertBoard(fbb);
response.sendRedirect("catFind.jsp");
}
%>
<script>
const file=<%=file%>

if(file==null) {
	alert("이미지를 등록해주세요.");
	history.back();
}
</script>