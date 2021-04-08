<%@page import="board.ComBoardBean"%>
<%@page import="board.ComBoardDAO"%>
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
<div id="text">입양후기</div>
<hr id="texthr">
<div id="text2">가족을 만나 행복한 하루를 보내는 아이들.</div>
<jsp:include page="../inc/centerSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

ComBoardDAO cbdao=new ComBoardDAO();

int count=cbdao.getBoardCount();

int pageSize=10;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<ComBoardBean> cbbList=cbdao.getBoardList(startRow,pageSize);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h1>입양 후기</h1>
<hr>
<table id="comment">
<% for(int i=0; i<cbbList.size(); i++) { 
	ComBoardBean cbb = cbbList.get(i); %>
<tr onclick="location.href='commentContent.jsp?num=<%=cbb.getNum()%>'" id="ctr">
<td rowspan="2" id="itd">
<%if(cbb.getFileRealName()!=null) { %>
<img src="../images/uploadImage/<%=cbb.getFileRealName()%>" width="60" height="60">
<% } else { %>
<img src="../images/image.png" width="60" height="60">
<% } %>
</td>
<td class="std" colspan="2"><%=cbb.getSubject() %></td>
<td rowspan="2" > <%=sdf.format(cbb.getDate()) %></td></tr>
<tr onclick="location.href='commentContent.jsp?num=<%=cbb.getNum()%>'" id="ntr">
<td class="sntd">작성자 <%=cbb.getName() %> | 조회수 <%=cbb.getReadcount() %></td>
</tr>
<% } %> 
</table>
<div class="clear"></div>
<div id="wbtn">
<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='commentWriteForm.jsp'">
</div>
<div class="clear"></div>
<div id="table_search">
<form action="commentSearch.jsp" method="get">
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

<a href="comment.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="comment.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="comment.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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