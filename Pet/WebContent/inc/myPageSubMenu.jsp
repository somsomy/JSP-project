<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="sub_img_member2"></div>
<nav id="sub_menu">
<ul>
<li onclick="location.href='myPage.jsp'">나의 정보</li>
<li onclick="location.href='myCats.jsp'">나의 고양이들</li>
<%
String id=(String)session.getAttribute("id");

if(id!=null) {
if(id.equals("admin")) {
%>
<li onclick="location.href='catList.jsp'">고양이목록</li>
<%} }%>
</ul>
</nav>