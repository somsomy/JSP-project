<%@page import="cats.CatsDAO"%>
<%@page import="cats.CatsBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
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
int catId=Integer.parseInt(multipartRequest.getParameter("catId"));
String catName=multipartRequest.getParameter("catName");
String age=multipartRequest.getParameter("age");
String gender=multipartRequest.getParameter("gender");
String neuter=multipartRequest.getParameter("neuter");
String catDate=multipartRequest.getParameter("catDate");
String vac=multipartRequest.getParameter("vac");
String catIng=multipartRequest.getParameter("catIng");
String catInfo=multipartRequest.getParameter("catInfo");

String fileName = multipartRequest.getOriginalFileName("file");
String fileRealName = multipartRequest.getFilesystemName("file");

if(fileRealName==null) {
	fileRealName=multipartRequest.getParameter("oldfile");
}

CatsDAO cdao=new CatsDAO();

CatsBean cb = new CatsBean();
cb.setCatId(catId);
cb.setCatName(catName);
cb.setCatAge(age);
cb.setCatGender(gender);
cb.setCatNeuter(neuter);
cb.setCatDate(catDate);
cb.setCatVaccination(vac);
cb.setFileName(fileName);
cb.setFileRealName(fileRealName);
cb.setCatIng(catIng);
cb.setCatInfo(catInfo);

cdao.updateCats(cb);
response.sendRedirect("catList.jsp");
%>