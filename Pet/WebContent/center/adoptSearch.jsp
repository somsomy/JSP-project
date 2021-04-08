<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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
<link href="../css/cats.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">입양문의</div>
<hr id="texthr">
<div id="text2">아이들의 가족이 되어주세요.</div>

<jsp:include page="../inc/centerSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<article>
<h1>입양 문의</h1>
<hr>
<%
request.setCharacterEncoding("utf-8");

String search=request.getParameter("search");
BoardDAO bdao=new BoardDAO();

int count=bdao.getBoardCount(search);

int pageSize=8;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<BoardBean> bbList=bdao.getBoardList(startRow,pageSize,search);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");

%>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">제목</th>
    <th class="twrite">작성자</th>
    <th class="tdate">작성날짜</th>
    <th class="tread">조회수</th></tr>
<% for(int i=0; i<bbList.size(); i++) { 
    	BoardBean bb = bbList.get(i); %>
<tr onclick="location.href='adoptContent.jsp?num=<%=bb.getNum()%>'" id="atr"><td><%=bb.getNum() %></td><td class="left"><%=bb.getSubject() %></td>
<td><%=bb.getName() %></td><td><%=sdf.format(bb.getDate()) %></td><td><%=bb.getReadcount() %></td></tr>
<% } %>
</table>
<%
if(count==0) {
	%>
	<div id="mag"><img src="../images/mag.png" width="30"></div>
	<span id="nImg">검색 결과가 없습니다.</span>
	<%
} %>

<div class="clear"></div>
<div id="wbtn">
<%String id=(String)session.getAttribute("id");

if(id!=null) {
		%>		
<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='adoptWriteForm.jsp'">
		<%
}
%>
</div>
<div class="clear"></div>
<div id="table_search">
<form action="adoptSearch.jsp" method="get">
<div id="divSearch">
<input type="text" name="search" placeholder=" Search" class="input_box" >
<button><img src="../images/search.png" id="searchImg"></button>
</div>
</form>
</div>
<div class="clear"></div>

<%
int pageBlock=3;

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

<a href="adoptSearch.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="adoptSearch.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="adoptSearch.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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