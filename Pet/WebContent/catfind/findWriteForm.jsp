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
  <script defer src="../script/reward.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">찾습니다</div>
<hr id="texthr">
<div id="text2">고양이가 따뜻한 가족의 품으로 돌아갈 수 있도록 도와주세요.</div>
<jsp:include page="../inc/catfindSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);

if(id==null) {
	response.sendRedirect("../member/login.jsp");
}
%>
<article>
<h1>찾습니다 게시글 등록</h1>
<hr>
<form action="findWritePro.jsp" method="post" enctype="multipart/form-data" >
<input type="hidden" name="name" value="<%=mb.getNick()%>">
<table id="catUpdateTab">
<tr><td class="sub"><label for="subject">제목</label></td><td colspan="3" class="sub"><input type="text" name="subject" placeholder="제목을 입력해주세요." class="ttd" id="subject"></td></tr>
<tr><td colspan="4" id="writer">작성자 <%=mb.getNick() %></td></tr>
<tr><td class="line" id="ph">연락처</td><td class="line"><input type="text" name="phone" value="<%if(mb.getPhone()!=null){ out.print(mb.getPhone()); }%>" class="input_ch"></td>
<td class="line" id="do">사례금</td><td class="line"><input type="text" name="reward" id="reward" >
<select name="customSelect" id="customSelect" onchange="setSelect();">
 <option>직접입력</option>
 <option>협의</option>
 <option>10만원</option>
 <option>20만원</option>
 <option>30만원</option>
</select></td>
</tr>
<tr><td class="subsub">고양이종</td><td><input type="text" name="cat" class="input_ch" ></td>
<td class="subsub">나이</td><td><input type="text" name="catAge" class="input_ch" ></td>
</tr>
<tr><td class="subsub">고양이 이름</td><td><input type="text" name="catName" class="input_ch" ></td>
<td class="subsub">성별</td><td><input type="radio" name="catGender" value="수컷" checked>수컷<input type="radio" name="catGender" value="암컷">암컷</td></tr>
<tr><td class="subsub">실종 장소</td><td><input type="text" name="catPlace" class="input_ch" ></td>
<td class="subsub">실종 날짜</td><td><input type="text" name="catDate" class="input_ch" ></td></tr>
<tr><td class="subsub">상세내용</td><td colspan="3" id="previewId"><textarea name="content" placeholder="내용을 입력해주세요."></textarea></td></tr>
 <tr id="abtd"><td class="subsub">이미지</td><td colspan="3">
  <label class="file">이미지등록
  <input type="file" name="file" id="file" onchange="previewImage(this,'previewId')"></label>
  </td></tr>
</table>
<div id="wbtn">
<input type="submit" value="등록하기" class="writeBtn" >
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