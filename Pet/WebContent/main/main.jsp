<%@page import="java.text.SimpleDateFormat"%>
<%@page import="cats.CatsBean"%>
<%@page import="java.util.List"%>
<%@page import="cats.CatsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link href="../css/slidecss.css" rel="stylesheet" type="text/css">

<script defer src="../script/slidescript.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="main_img">
 <ul id="slider">
  <li> <img class="mySlides" src="../images/main00.jpg" ></li>
  <li> <img class="mySlides" src="../images/main01.jpg" ></li>
  <li> <img class="mySlides" src="../images/main02.png" ></li>
 </ul>
<div class="slider-btns" id="next"><span>》</span></div>
<div class="slider-btns" id="previous"><span>《</span></div>
 <div id="slider-pagination-wrap">
   <ul>
   </ul>
 </div>
</div>
<article id="front">
<h1>보호중인 아이들</h1>
<hr>
<%
request.setCharacterEncoding("utf-8");

CatsDAO cdao=new CatsDAO();

String ing="보호중";

int count=cdao.getBoardCount(ing);

int pageSize=10;

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
<div id="divTable">
<table>
<tr>
<%
for(int i = 0; i <cbList.size(); i++) {
	CatsBean cb=cbList.get(i);
	
	%>
	<td><table onclick="location.href='../center/catsContent.jsp?catId=<%=cb.getCatId()%>'" class="ctable">
	<tr><td><img src="../images/uploadImage/<%=cb.getFileRealName()%>"></td></tr>
	<tr><td><%=cb.getCatName() %></td></tr>
	</table></td>
	<%
	if((i+1)%5==0) {
		%>
		</tr>
		<%
	}
}

%>   
</table>
</div>
<div class="clear"></div>
<div id="table_search">
<form action="../center/catsSearch.jsp" method="get">
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

<a href="main.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="main.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="main.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
	<%
}
%>
</div>
</article>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>