<%@page import="board.NoticeBean"%>
<%@page import="board.NoticeDAO"%>
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
<link rel="preconnect" href="https://fonts.gstatic.com">
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">공지사항</div>
<hr id="texthr">
<div id="text2">고양이의 하루의 공지사항입니다.</div>
<jsp:include page="../inc/companySubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

NoticeDAO ndao=new NoticeDAO();

int count=ndao.getBoardCount();

int pageSize=10;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<NoticeBean> nbList=ndao.getBoardList(startRow,pageSize);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h1>공지사항</h1>
<hr>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">제목</th>
    <th class="twrite">작성자</th>
    <th class="tdate">작성날짜</th>
    <th class="tread">조회수</th></tr>
<% for(int i=0; i<nbList.size(); i++) { 
	NoticeBean nb = nbList.get(i); %>
<tr onclick="location.href='noticeContent.jsp?num=<%=nb.getNum()%>'" id="atr"><td><%=nb.getNum() %></td><td class="left"><%=nb.getSubject() %></td>
<td><%=nb.getName() %></td><td><%=sdf.format(nb.getDate()) %></td><td><%=nb.getReadcount() %></td></tr>
<% } %> 
</table>
<div class="clear"></div>
<div id="wbtn">
<%String id=(String)session.getAttribute("id");

if(id!=null) {
	if(id.equals("admin")) {
		%>		
<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='noticeWriteForm.jsp'">
		<%
	}
}
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

<a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="notice.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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