<%@page import="supporter.SupporterDAO"%>
<%@page import="supporter.SupporterBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));

String supportType=request.getParameter("supportType");
supportType=supportType.equals("year")? "년 단위 정기후원" : supportType;
String donation=request.getParameter("donation");
String[] yearCheck=request.getParameterValues("yearCheck");
String yearDonation1=null;
String yearDonation2=null;

String payment=request.getParameter("payment");
payment=payment.equals("account")? "계좌이체" : payment.equals("creditCard")? "카드결제" : payment;
String payNum=request.getParameter("payNum");
String year=request.getParameter("year");
String month=request.getParameter("month");
String day=request.getParameter("day");

String ownerName=request.getParameter("ownerName");

SupporterBean sb=new SupporterBean();
sb.setNum(num);
sb.setSupportType(supportType);
sb.setDonation(donation);
if(yearCheck!=null) {
	for(int i=0; i<yearCheck.length; i++) {	
		if(i==0) {
			yearDonation1=yearCheck[i];
			sb.setYearDonation(yearDonation1);
		} else {
			yearDonation2=yearCheck[i];
			sb.setYearDonation(yearDonation1+","+yearDonation2);
		}
	}
}	
sb.setPayment(payment);
sb.setPayNum(payNum);
sb.setYear(year);
sb.setMonth(month);
sb.setDay(day);
sb.setOwnerName(ownerName);

SupporterDAO sdao=new SupporterDAO();
sdao.updateSupporter(sb);

response.sendRedirect("myCats.jsp");

%>