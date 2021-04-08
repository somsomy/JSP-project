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
<link href="../css/support.css" rel="stylesheet" type="text/css">

 <script defer src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="../script/postcode.js"></script>
<script defer src="../script/imageUpload.js"></script>
<script defer src="../script/support.js"></script>

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">1:1후원</div>
<jsp:include page="../inc/supportSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

int catId = Integer.parseInt(request.getParameter("catId"));
CatsDAO cdao = new CatsDAO();
CatsBean cb=cdao.getCats(catId);
Date now = new Date();
String pattern ="yyyy-MM-dd";
SimpleDateFormat sdf = new SimpleDateFormat(pattern);
String today = sdf.format(now);
%>

<article>
<h1>1:1 후원</h1>
<hr>
<table class="table1">
	<tr><td rowspan="2"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" width="300" height="300" ></td>
	<td><%=cb.getCatName() %></td></tr>
	<tr><td>입소날짜 : <%=cb.getCatDate() %> | 나이 : <%=cb.getCatAge() %> | 성별 : <%=cb.getCatGender() %></td></tr>
</table>
<span class="step"><span id="step1">후원정보 - 후원자정보</span> - 결제정보 - 후원완료</span>
<h2>후원정보</h2>
<hr>
<form action="support2.jsp" method="post" name="supForm">
<input type="hidden" name="catId" value="<%=catId%>">
<table class="supinfo" id="suptype">
<tr><td class="sub">유형</td>
<td class="info_ck" onclick="check()"><input type="radio" name="supportType" value="1회 일시후원" class="ckpoint" checked>1회 일시후원
<input type="radio" name="supportType" value="월 단위 정기후원" class="ckpoint">월 단위 정기후원
<input type="radio" name="supportType" value="year" class="ckpoint">년 단위 정기후원</td></tr>
<tr><td class="sub">후원금액</td>
<td class="info_ck" onclick="check()"><input type="radio" name="donation" value="10000" class="ckpoint" checked>1만원
<input type="radio" name="donation" value="20000" class="ckpoint">2만원
<input type="radio" name="donation" value="40000" class="ckpoint">4만원
<input type="radio" name="donation" value="60000" class="ckpoint">6만원
<input type="radio" name="donation" value="80000" class="ckpoint">8만원
<input type="radio" name="donation" value="100000" class="ckpoint">10만원
</td></tr>
<tr><td class="sub">년 단위 정기후원 종류 (년 후원 유형을 선택했을 경우만 선택)</td>
<td class="info_ck" onclick="check()"><input type="checkbox" name="yearCheck" value="입소날짜 기준 n주년 기념일" class="ckpoint">입소날짜 기준 n주년 기념일
<input type="checkbox" name="yearCheck" value="세계 고양이의 날(8/8)" class="ckpoint">세계 고양이의 날(8/8)
</td></tr>
<tr><td></td><td><span id="message"></span></td></tr>
</table>

<br>
<%
String id=(String)session.getAttribute("id");

MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);

%>
<script>
const id=<%=id%>

if(id==null) {
	alert("로그인이 필요합니다");
	location.href="../member/login.jsp";
}
</script>
<h2>후원자 정보</h2>
<hr>
<table class="supinfo" id="supporterInfo">
<tr><td>성함 <img src="../images/dry-clean.png" class="dot"></td><td><input type="text" name="name" value="<%=mb.getName() %>" required></td></tr>
<tr><td>휴대전화 <img src="../images/dry-clean.png" class="dot"></td><td><input type="text" name="phone" value="<%=mb.getPhone()%>" required></td></tr>
<tr><td>이메일주소 <img src="../images/dry-clean.png" class="dot"></td><td><input type="text" name="email" value="<%=mb.getEmail()%>" required></td></tr>
</table>
<div id="wbtn">
<input type="submit" value="다음" class="writeBtn">
</div>
<div class="clear"></div>
</form>
</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>