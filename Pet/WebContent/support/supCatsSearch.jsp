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
<link href="../css/supportCats.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">1:1후원</div>
<jsp:include page="../inc/supportSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<article>
<h1>1:1 후원</h1>
<%
request.setCharacterEncoding("utf-8");

CatsDAO cdao=new CatsDAO();

String search=request.getParameter("search");

String ing="보호중";

int count=cdao.getBoardCount(search, ing);

int pageSize=4;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;
List<CatsBean> cbList=cdao.getBoardList(startRow,pageSize,search,ing);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");

for(int i = 0; i <cbList.size(); i++) {
	CatsBean cb=cbList.get(i);
	%>
	<table>
	<tr><td rowspan="2"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" width="300" height="300"></td>
	<td>안녕하새오! 나는 <span id="catName"><%=cb.getCatName() %></span> 이에오.</td>
	<td><input type="button" value="고양이 정보" class="supBtn" onclick="location.href='supportCatsContent.jsp?catId=<%=cb.getCatId() %>'" ></td></tr>
	<tr><td>입소날짜 : <%=cb.getCatDate() %> | 나이 : <%=cb.getCatAge() %></td>
	<td><input type="button" value="후원하기" class="supBtn" onclick="location.href='support.jsp?catId=<%=cb.getCatId() %>'" ></td></tr>
	</table>
<% } if(count==0) {
	%>
	<img src="../images/nothing.png" width="730">
	<%
}%>
<div class="clear"></div>
<div id="table_search">
<form action="supCatsSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="button" value="찾기" class="btn" >
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

<a href="supportCats.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="supportCats.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="supportCats.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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