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
<script defer src="../script/support2.js"></script>

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


String supportType=request.getParameter("supportType");
String[] yearDonationArr=request.getParameterValues("yearCheck");

if(supportType.equals("year")&&yearDonationArr==null) {
	%>
	<script>
		alert("년 단위 정기후원 종류를 선택해주세요.");
		history.back();
	</script>
	<%
}

String donation=request.getParameter("donation");

supportType=supportType.equals("year")? "년 단위 정기후원" : supportType;

String postCode=request.getParameter("postCode");
String address=request.getParameter("address");
String detailAddress=request.getParameter("detailAddress");

String id=(String)session.getAttribute("id");

MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);
%>
<article>
<h1>1:1 후원</h1>
<hr>
<form action="supportPro.jsp" method="post">
<input type="hidden" name="catId" value="<%=catId%>">
<input type="hidden" name="id" value="<%=id%>">
<table class="table1">
	<tr><td rowspan="2"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" width="300" height="300"></td>
	<td><%=cb.getCatName() %></td></tr>
	<tr><td>입소날짜 : <%=cb.getCatDate() %> | 나이 : <%=cb.getCatAge() %> | 성별 : <%=cb.getCatGender() %></td></tr>
</table>
<span class="step">후원정보 - 후원자정보 -<span id="step1"> 결제정보</span> - 후원완료</span>

<h2>결제정보</h2>
<hr>
<table class="supinfo" id="payInfo">
<tr><td>후원 유형</td><td><input type="text" name="supportType" value="<%=supportType %>" readonly></td></tr>
<tr><td>후원 금액</td><td><input type="text" name="donation" value="<%=donation %>" readonly></td></tr>
<%
if(yearDonationArr!=null) {
	%>
<tr><td>년 단위 정기후원 종류</td><td><input type="text" name="yearDonation" value="<%
for(String yearDonation : yearDonationArr) {
	out.print(yearDonation + " ");
}
%>" readonly>
	<%
} %>
</td>
</tr>
<tr><td>결제 방법</td><td class="pay" onclick="type()">
<input type="radio" name="payment" value="account"  class="ckpoint" id="ckaccount" checked >계좌이체 
<input type="radio" name="payment" value="creditCard"  class="ckpoint" id="ckcard">카드결제</td></tr>
<tr><td id="accNum">계좌번호</td><td><input type="text" name="payNum" required></td></tr>
<%if(!supportType.equals("once")) { %>
<tr><td>이체시작날짜</td>
<td>
<select name="year">
<%
pattern="yyyy";
sdf = new SimpleDateFormat(pattern);
today = sdf.format(now);
int newYear=Integer.parseInt(today);
for(int i=newYear; i<=newYear+10; i++) { %>
 <option value="<%=i%>년"><%=i %>년</option>
 <%} %>
</select>
<select name="month">
 <option>선택</option>
<%for(int i=1; i<=12; i++) { %>
 <option value="<%=i%>월"><%=i %>월</option>
<% } %>
</select>
<select name="day">
 <option>선택</option>
 <option value="5일">5일</option>
 <option value="10일">10일</option>
 <option value="20일">20일</option>
</select>
<img src="../images/dry-clean.png" class="dot"> 정기후원의 경우 선택한 일에 자동이체가 됩니다.
</td>
</tr>
<%} %>
<tr><td id="accName">예금주명</td><td><input type="text" name="ownerName" required ></td></tr>
</table>
<div id="wbtn">
<input type="button" value="뒤로" class="writeBtn" onclick="history.back()">
<input type="submit" value="후원 완료하기" class="writeBtn">
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