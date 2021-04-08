<%@page import="cats.CatsDAO"%>
<%@page import="cats.CatsBean"%>
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
<div id="text">입양완료</div>
<hr id="texthr">
<div id="text2">새로운 가족을 맞이한 아이들.</div>
<jsp:include page="../inc/centerSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<article>
<h1>입양완료</h1>
<hr>
<%
request.setCharacterEncoding("utf-8");

CatsDAO cdao=new CatsDAO();

String ing = "입양완료";

int count=cdao.getBoardCount(ing);

int pageSize=9;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<CatsBean> cbList=cdao.getProtectList(startRow,pageSize,ing);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>
<table id="topTab">
<tr>
<%
for(int i = 0; i <cbList.size(); i++) {
	CatsBean cb=cbList.get(i);
	
	%>
	<td><table onclick="location.href='catsCompContent.jsp?catId=<%=cb.getCatId()%>'" class="ctable">
	<tr><td colspan="2"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" class="ctd"></td></tr>
	<tr><td colspan="2"><%=cb.getCatName() %></td></tr>
	<tr><td>입소날짜 <%=cb.getCatDate() %></td><td id="readCount">조회수 <%=cb.getReadcount() %></td></tr>
	</table></td>
	<%
	if((i+1)%3==0) {
		%>
		</tr>
		<%
	}
}
%>   
</table>
<div class="clear"></div>
<div id="table_search">
<form action="catsCompSearch.jsp" method="get">
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

<a href="catsAdoptComp.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="catsAdoptComp.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="catsAdoptComp.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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