<%@page import="board.QnABean"%>
<%@page import="board.QnADAO"%>
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

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">Q&A</div>
<div id="sub_img_qna"></div>
<nav id="sub_menu">
</nav>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

QnADAO qdao=new QnADAO();

String search=request.getParameter("search");

int count=qdao.getBoardCount(search);

int pageSize=10;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<QnABean> qbList=qdao.getBoardList(startRow,pageSize,search);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h1>Q&A</h1>
<hr>
<table id="notice">
<tr><th class="tno">답변상태</th>
    <th class="ttitle">제목</th>
    <th class="twrite">작성자</th>
    <th class="tdate">작성날짜</th>
    <th class="tread">조회수</th></tr>
<% for(int i=0; i<qbList.size(); i++) { 
	QnABean qb = qbList.get(i); %>
<tr onclick="location.href='qnaContent.jsp?code=<%=qb.getCode()%>'" id="atr"><td ><%if(qb.getState()!=null){out.println(qb.getState());} %></td><td class="left"><%=qb.getSubject() %></td>
<td><%=qb.getName() %></td><td><%=sdf.format(qb.getDate()) %></td><td><%=qb.getReadcount() %></td></tr>
<% } %> 
</table>
<%if(count==0) {
	%>
	<div id="mag"><img src="../images/mag.png" width="30"></div>
	<span id="nImg">검색 결과가 없습니다.</span>
	<%
} %>

<div class="clear"></div>
<div id="wbtn">
<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='qnaWriteForm.jsp'">
</div>
<div class="clear"></div>
<div id="table_search">
<form action="qnaSearch.jsp" method="get">
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

<a href="qnaSearch.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="qnaSearch.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="qnaSearch.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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