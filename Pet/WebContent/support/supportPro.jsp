<%@page import="supporter.SupporterBean"%>
<%@page import="supporter.SupporterDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int catId = Integer.parseInt(request.getParameter("catId"));
String userid=(String)session.getAttribute("id");

String supportType=request.getParameter("supportType");
String donation=request.getParameter("donation");
String yearDonation=request.getParameter("yearDonation");
String payment=request.getParameter("payment");
payment=payment.equals("account")? "계좌이체" : "카드결제";
String payNum=request.getParameter("payNum");
String year=request.getParameter("year");
String month=request.getParameter("month");
String day=request.getParameter("day");

String ownerName=request.getParameter("ownerName");
Timestamp date = new Timestamp(System.currentTimeMillis());

SupporterBean sb=new SupporterBean();
sb.setUserid(userid);
sb.setCatId(catId);
sb.setSupportType(supportType);
sb.setDonation(donation);
sb.setYearDonation(yearDonation);
sb.setPayment(payment);
sb.setPayNum(payNum);
sb.setYear(year);
sb.setMonth(month);
sb.setDay(day);
sb.setOwnerName(ownerName);
sb.setDate(date);

if(month.equals("선택")||day.equals("선택")) {
	%>
	<script>
		alert("날짜를 선택해주세요.");
		history.back();
	</script>
	<%
} else {
SupporterDAO sdao=new SupporterDAO();
sdao.insertSupporter(sb);
%>
<script>
alert("후원완료");
location.href="supportCats.jsp";
</script>

<%
}
%>