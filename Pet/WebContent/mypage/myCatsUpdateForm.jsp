<%@page import="java.util.Date"%>
<%@page import="cats.CatsDAO"%>
<%@page import="cats.CatsBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="supporter.SupporterBean"%>
<%@page import="supporter.SupporterDAO"%>
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

 <script defer src="../script/support.js"></script>
 <script defer src="../script/support2.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">나의 고양이들</div>
<hr id="texthr">
<div id="text2">회원님께서 후원하고 있는 고양이들.</div>
<jsp:include page="../inc/myPageSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<article>
<%
String id=(String)session.getAttribute("id");
int num=Integer.parseInt(request.getParameter("num"));

SupporterDAO sdao=new SupporterDAO();
SupporterBean sb=sdao.getBoard(num);
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");

CatsDAO cdao=new CatsDAO();
CatsBean cb=cdao.getCats(sb.getCatId());
%> 
<h1>나의 고양이들</h1>
<hr>
<div id="hinfo">회원님이 후원하고 있는 고양이들</div>
<table class="mycats">
<tr><td colspan="2"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" class="mycatsImg"></td></tr>
<tr><td class="tdtdtd">고양이 이름</td><td><%=cb.getCatName() %></td></tr>
<tr><td class="tdtdtd">고양이 나이</td><td><%=cb.getCatAge() %></td></tr>
<tr><td class="tdtdtd">고양이 성별</td><td><%=cb.getCatGender() %></td></tr>
</table>
<form action="myCatsUpdatePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num %>">
<h2>후원정보</h2>
<hr>
<table class="supinfo" id="suptype">
<tr><td class="sub">유형</td>
<td class="info_ck" onclick="check()"><input type="radio" name="supportType" value="1회 일시후원" class="ckpoint" checked>1회 일시후원
<input type="radio" name="supportType" value="월 단위 정기후원" class="ckpoint">월 단위 정기후원
<input type="radio" name="supportType" value="year" class="ckpoint">년 단위 정기후원</td></tr>
<tr><td class="sub">후원금액</td>
<td class="info_ck" onclick="check()"><input type="radio" name="donation" value="10000" checked>1만원
<input type="radio" name="donation" value="20000" class="ckpoint">2만원
<input type="radio" name="donation" value="40000" class="ckpoint">4만원
<input type="radio" name="donation" value="60000" class="ckpoint">6만원
<input type="radio" name="donation" value="80000" class="ckpoint">8만원
<input type="radio" name="donation" value="100000" class="ckpoint">10만원
</td></tr>
<tr><td class="sub">년 단위 정기후원 종류 (년 후원 유형을 선택했을 경우만 선택)</td>
<td onclick="check()"><input type="checkbox" name="yearCheck" value="입소날짜 기준 n주년 기념일">입소날짜 기준 n주년 기념일
<input type="checkbox" name="yearCheck" value="세계 고양이의 날(8/8)">세계 고양이의 날(8/8)
</td></tr>
<tr><td></td><td><span id="message"></span></td></tr>
</table>
<h2>결제정보</h2>
<hr>
<table class="supinfo" id="payInfo">
<tr><td>결제 방법</td><td class="pay" onclick="type()">
<input type="radio" name="payment" value="account" class="ckpoint" id="ckaccount" checked >계좌이체 
<input type="radio" name="payment" value="creditCard" class="ckpoint" id="ckaccount">카드결제</td></tr>
<tr><td id="accNum">계좌번호</td><td><input type="text" name="payNum"></td></tr>
<tr><td>이체시작날짜</td>
<td>
<select name="year">
<%
String pattern="yyyy";
sdf = new SimpleDateFormat(pattern);
Date now = new Date();
String today = sdf.format(now);
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
<tr><td id="accName">예금주명</td><td><input type="text" name="ownerName" ></td></tr>
</table>
<div class="clear"></div>
<div id="wbtn">
<input type="submit" value="후원정보수정" class="writeBtn" >
</div>
</form>
</article>
</div>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>