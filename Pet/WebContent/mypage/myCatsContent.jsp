<%@page import="cats.CatsDAO"%>
<%@page import="cats.CatsBean"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<link href="../css/myCats.css" rel="stylesheet" type="text/css">

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
<h1>나의 고양이</h1>
<hr>
<div id="hinfo">회원님이 후원하고 있는 고양이</div>
<table class="mycatsTable">
<tr><td colspan="2"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" width="300" height="300"></td></tr>
<tr><td class="tdtdtd">고양이 이름</td><td><%=cb.getCatName() %></td></tr>
<tr><td class="tdtdtd">고양이 나이</td><td><%=cb.getCatAge() %></td></tr>
<tr><td class="tdtdtd">고양이 성별</td><td><%=cb.getCatGender() %></td></tr>
</table>
<table class="mycatsTable" id="supInfo">
<tr><td colspan="2" id="supporter">후원정보</td></tr>
<tr><td class="tdtdtd">후원 유형</td><td><%=sb.getSupportType() %></td></tr>
<tr><td class="tdtdtd">후원 금액</td><td><%=sb.getDonation() %>원</td></tr>
<%if(sb.getYearDonation()!=null) { %>
<tr><td class="tdtdtd">년 단위 정기후원 종류</td><td><%=sb.getYearDonation() %></td></tr>
<% } %>
<tr><td class="tdtdtd">후원 결제방법</td><td><%=sb.getPayment() %></td></tr>
<tr><td class="tdtdtd">후원 시작일</td><td><%=sb.getSupportStart() %></td></tr>
</table>
<div class="clear"></div>
<div id="wbtn">
<input type="button" value="후원정보수정" class="writeBtn" onclick="location.href='myCatsUpdateForm.jsp?num=<%=num%>'">
<input type="button" value="후원취소" class="writeBtn" onclick="location.href='myCatsDelete.jsp?num=<%=num%>'">
</div>
</article>
</div>

</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>