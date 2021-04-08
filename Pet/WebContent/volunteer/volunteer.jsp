<%@page import="board.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.VolunteerBean"%>
<%@page import="java.util.List"%>
<%@page import="board.VolunteerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/volunteer.css" rel="stylesheet" type="text/css">
 
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>

<div class="clear"></div>
<div id="divSub">
<div id="text">자원봉사</div>
<hr id="texthr">
<div id="text2">사랑의 손길을 내어주세요.</div>
<div id="sub_img"></div>
</div>
<div id="divArticle">
<article>
<h1>자원봉사 모집</h1>
<hr>
<%
request.setCharacterEncoding("utf-8");

VolunteerDAO vdao=new VolunteerDAO();

int count=vdao.getBoardCount();

int pageSize=10;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<VolunteerBean> vbList=vdao.getBoardList(startRow, pageSize);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");

ReplyDAO rdao=new ReplyDAO();

%>
<table id="notice">
<tr><th class="thno">No.</th>
	<th class="tno">모집상태</th>
    <th class="ttitle">제목</th>
    <th class="twrite">작성자</th>
    <th class="tdate">작성날짜</th>
    <th class="tread">조회수</th></tr>
  <%for(int i=0; i<vbList.size(); i++) { 
  		VolunteerBean vb=vbList.get(i);
int reCount=rdao.getReplyCount2(vb.getNum());
  %>
<tr onclick="location.href='volunteerContent.jsp?num=<%=vb.getNum() %>'" id="atr"><td><%=vb.getNum() %></td>
<td><%=vb.getState() %></td>
<td id="tdSub"><%=vb.getSubject() %> <img src="../images/speech-bubble.png" width="15"> <%=reCount %></td>
<td><%=vb.getName() %></td><td><%=sdf.format(vb.getDate()) %></td>
<td><%=vb.getReadcount() %></td></tr>
<%} %>
</table>
<div class="clear"></div>
<div id="wbtn">
<%String id=(String)session.getAttribute("id");
if(id!=null) {
if(id.equals("admin")) {
	%>	
<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='volunteerWriteForm.jsp'">
		<%
} }
%>
</div>
<div class="clear"></div>
<div id="table_search">
<form action="noticeSearch.jsp" method="get">
<div id="divSearch">
<input type="text" name="search" placeholder=" Search" class="input_box" >
<button><img src="../images/search.png" id="searchImg"></button>
</div>
</form>
</div>
<div class="clear"></div>
<%

int pageBlock=2;

int startPage=((currentPage-1) /pageBlock)*pageBlock + 1;

int endPage=startPage+pageBlock-1;

int pageCount=count/pageSize+(count%pageSize==0?0:1);

if(endPage > pageCount){
	endPage=pageCount;
}
%>
<div id="page_control">
<% 
if(startPage > pageBlock){
%>

<a href="etc.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="etc.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="etc.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
	<%
}
%>
</div>
</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>



    