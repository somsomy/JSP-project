<%@page import="java.util.Date"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/findUpdate.css" rel="stylesheet" type="text/css">

 <script defer src="../script/imageUpload.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">관리자 고양이 등록</div>
<hr id="texthr">
<div id="text2">고양이 등록 / 취소 관리</div>
<jsp:include page="../inc/myPageSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");

MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);

Date now = new Date();
String pattern ="yyyy-MM-dd";
SimpleDateFormat sdf = new SimpleDateFormat(pattern);
String today = sdf.format(now);
%>
<script>
const id=<%=id%>
if(id!='admin') {
	alert("로그인이 필요합니다");
	location.href="../member/login.jsp";
}

</script>

<article>
<h1>보호중인 고양이 등록</h1>
<hr>
<form action="catRegPro.jsp" method="post" enctype="multipart/form-data" >
<table id="catUpdateTab">
<tr><td class="sub"><label for="subject">고양이이름</label></td><td colspan="3" class="sub"><input type="text" name="catName" placeholder="고양이 이름을 입력해주세요."  class="ttd" id="subject"></td></tr>
<tr><td colspan="4" id="writer">작성자 <%=mb.getNick() %></td></tr>
<tr><td class="line" id="ph">나이</td><td class="line"><input type="text" name="age" class="input_ch"></td>
<td class="line" id="do">보호중/입양완료</td>
<td class="line">
<select name="catIng">
<option>보호중</option>
<option>입양완료</option>
</select>
</td>
</tr>
<tr><td class="subsub">성별</td><td>
<input type="radio" name="gender" value="수컷" checked>수컷 <input type="radio" name="gender" value="암컷"> 암컷</td>
<td class="subsub">중성화</td><td>
<input type="radio" name="neuter" value="O" checked>완료 <input type="radio" name="neuter" value="X"> 안함
</tr>
<tr><td class="subsub">입소날짜</td><td>
<input type="date" name="catDate" max="<%=today%>" >
</td>
<td class="subsub">접종유무</td><td>
<input type="radio" name="vac" value="O" checked>완료 <input type="radio" name="vac" value="X">안함
</td></tr>
<tr><td class="subsub">특이사항</td><td colspan="3" id="previewId"><textarea name="catInfo" placeholder="내용을 입력해주세요."></textarea></td></tr>
 <tr id="abtd"><td class="subsub">이미지</td><td colspan="3">
  <label class="file">이미지등록
  <input type="file" name="file" id="file" onchange="previewImage(this,'previewId')"></label>
  </td></tr>
</table>
<div id="wbtn">
<input type="submit" value="등록" class="writeBtn" >
</div>
</form>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>