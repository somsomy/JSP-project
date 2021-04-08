<%@page import="cats.CatsBean"%>
<%@page import="cats.CatsDAO"%>
<%@page import="java.util.Date"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/adoptWrite.css" rel="stylesheet" type="text/css">

 <script defer src="../script/imageUpload.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="sub_img_member2"></div>
<div id="divArticle">
<jsp:include page="../inc/myPageSubMenu.jsp"></jsp:include>
<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);
int catId = Integer.parseInt(request.getParameter("catId"));
CatsDAO cdao = new CatsDAO();
CatsBean cb=cdao.getCats(catId);

Date now = new Date();
String pattern ="yyyy-MM-dd";
SimpleDateFormat sdf = new SimpleDateFormat(pattern);
String today = sdf.format(now);
%>
<article>
<h1>고양이 목록</h1>
<form action="catRegWritePro.jsp" method="post" enctype="multipart/form-data" >
<input type="hidden" name="catId" value="<%=catId%>">
<table id="notice">
<tr id="atd"><td>글제목</td><td colspan="3"><input type="text" name="subject" style="width: 585px;"></td></tr>
<tr><td>작성자</td><td><input type="text" name="name" value="<%=mb.getName() %>" id="writer" readonly></td>
 <td>보호중/입양완료</td><td><input type="text" name="catIng" value="<%=cb.getCatIng()%>" readonly></td></tr>
<tr><td>고양이 이름</td><td><input type="text" name="catName" class="catName" value="<%=cb.getCatName()%>" readonly></td>
 <td>나이</td><td><input type="text" name="catAge" class="catAge" value="<%=cb.getCatAge()%>" readonly></td></tr>
<tr><td>성별</td><td><input type="text" name="catGender" value="<%=cb.getCatGender()%>" readonly></td>
 <td>중성화</td><td><input type="text" name="catNeuter" value="<%=cb.getCatNeuter()%>" readonly></td></tr>
<tr><td>입소날짜</td><td><input type="text" name="catDate" value="<%=sdf.format(cb.getDate())%>" readonly></td>
 <td>접종유무</td><td><input type="text" name="catVaccination" value="<%=cb.getCatVaccination()%>" readonly></td></tr>
<tr><td>특이사항</td><td colspan="3" id="previewId" width="200" height="200">
 <img src="../images/uploadImage/<%=cb.getFileRealName()%>" width="300" height="300">
  <textarea name="catInfo" class="adoptContent" readonly ><%=cb.getCatInfo() %></textarea></td></tr>
<tr id="abtd"><td>글내용</td><td colspan="3"><textarea name="content" class="adoptContent"></textarea></td></tr>
</table>
<input type="submit" value="등록하기" class="writeBtn" >
</form>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>