<%@page import="board.FoundBoardBean"%>
<%@page import="board.FoundBoardDAO"%>
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
<link href="../css/comment.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">찾았어요</div>
<hr id="texthr">
<div id="text2">따뜻한 가족의 품으로 돌아간 아이들</div>
<jsp:include page="../inc/catfindSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

String search=request.getParameter("search");

FoundBoardDAO fbdao=new FoundBoardDAO();

int count=fbdao.getBoardCount(search);

int pageSize=10;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<FoundBoardBean> fbbList=fbdao.getBoardList(startRow, pageSize, search);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h1>찾았어요</h1>
<hr>
<table id="comment">
<% for(int i=0; i<fbbList.size(); i++) { 
	FoundBoardBean fbb = fbbList.get(i); %>
<tr onclick="location.href='foundContent.jsp?num=<%=fbb.getNum()%>'" id="ctr">
<td rowspan="2" id="itd">
<%if(fbb.getFile()!=null) { %>
<img src="../images/uploadImage/<%=fbb.getFile()%>" width="80" height="80">
<% } else { %>
<img src="../images/user.png" width="60" height="60">
<% } %>
</td>
<td class="std" colspan="2"><%=fbb.getSubject() %></td>
<td rowspan="2" > <%=sdf.format(fbb.getDate()) %></td></tr>
<tr onclick="location.href='foundContent.jsp?num=<%=fbb.getNum()%>'" id="ntr">
<td class="sntd">작성자 <%=fbb.getName() %> | 조회수 <%=fbb.getReadcount() %></td>
</tr>
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
<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='foundWriteForm.jsp'">
</div>
<div class="clear"></div>
<div id="table_search">
<form action="catFoundSearch.jsp" method="get">
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

<a href="catFoundSearch.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="catFoundSearch.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="catFoundSearch.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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