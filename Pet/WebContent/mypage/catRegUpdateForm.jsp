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

int catId = Integer.parseInt(request.getParameter("catId"));
CatsDAO cdao = new CatsDAO();
CatsBean cb=cdao.getCats(catId);

Date now = new Date();
String pattern ="yyyy-MM-dd";
SimpleDateFormat sdf = new SimpleDateFormat(pattern);
String today = sdf.format(now);
%>
<script defer>
const id=<%=id%>

if(id!='admin') {
	alert("로그인이 필요합니다");
	location.href="../member/login.jsp";
}
</script>
<article>
<h1>고양이 정보 수정</h1>
<hr>
<form action="catRegUpdatePro.jsp" method="post" enctype="multipart/form-data" name="fr">
<input type="hidden" name="catId" value="<%=catId%>">
<table id="catUpdateTab">
<tr><td class="sub"><label for="subject">고양이이름</label></td><td colspan="3" class="sub"><input type="text" name="catName" placeholder="고양이 이름을 입력해주세요." value="<%=cb.getCatName()%>" class="ttd" id="subject"></td></tr>
<tr><td colspan="4" id="writer">작성자 <%=mb.getNick() %></td></tr>
<tr><td class="line" id="ph">나이</td><td class="line"><input type="text" name="age"  value="<%=cb.getCatAge()%>" class="input_ch"></td>
<td class="line" id="do">보호중/입양완료</td>
<td class="line">
<select name="catIng">
<option <% if(cb.getCatIng().equals("보호중")){%>selected<%}%>>보호중</option>
<option <% if(cb.getCatIng().equals("입양완료")){%>selected<%}%>>입양완료</option>
</select>
</td>
</tr>
<tr><td class="subsub">성별</td><td>
<input type="radio" name="gender" value="수컷" <% if(cb.getCatGender().equals("수컷")){%>checked<%}%>>수컷
 <input type="radio" name="gender" value="암컷" <% if(cb.getCatGender().equals("암컷")){%>checked<%}%>> 암컷</td>
<td class="subsub">중성화</td><td>
<input type="radio" name="neuter" value="O" <% if(cb.getCatNeuter().equals("O")){%>checked<%}%>>완료
 <input type="radio" name="neuter" value="X"<% if(cb.getCatNeuter().equals("X")){%>checked<%}%>> 안함
</tr>
<tr><td class="subsub">입소날짜</td><td>
<input type="date" name="catDate" max="<%=today%>"  value="<%=cb.getCatDate()%>" >
</td>
<td class="subsub">접종유무</td><td>
<input type="radio" name="vac" value="O" <% if(cb.getCatVaccination().equals("O")){%>checked<%}%>>완료 
<input type="radio" name="vac" value="X" <% if(cb.getCatVaccination().equals("X")){%>checked<%}%>>안함
</td></tr>
<tr><td class="subsub">특이사항</td><td colspan="3" id="previewId"><textarea name="catInfo" placeholder="내용을 입력해주세요."><%=cb.getCatInfo() %></textarea></td></tr>
 <tr><td class="subsub">기존이미지</td><td><%=cb.getFileRealName() %></td></tr>
 <tr id="abtd"><td class="subsub">이미지</td><td colspan="3">
  <label class="file">이미지등록
  <input type="file" name="file" id="file" onchange="previewImage(this,'previewId')"></label>
   <input type="hidden" name="oldfile" value="<%=cb.getFileRealName() %>">
  </td></tr>
</table>
<div id="wbtn">
<input type="submit" value="수정" class="writeBtn" >
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