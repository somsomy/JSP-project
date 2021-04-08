<%@page import="cats.CatsBean"%>
<%@page import="cats.CatsDAO"%>
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

<script defer src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="../script/mypostcode.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">관리자 고양이 등록</div>
<hr id="texthr">
<div id="text2">고양이 등록 / 취소 관리</div>
<jsp:include page="../inc/myPageSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<article>
<h1>고양이 목록</h1>
<hr>
<%
request.setCharacterEncoding("utf-8");

CatsDAO cdao=new CatsDAO();

int count=cdao.getBoardCount();

int pageSize=9;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<CatsBean> cbList=cdao.getCatList(startRow,pageSize);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");

%>
<table class="tTab">
<tr>
<%
for(int i = 0; i <cbList.size(); i++) {
	CatsBean cb=cbList.get(i);
	
	%>
	<td><table onclick="location.href='catRegContent.jsp?catId=<%=cb.getCatId()%>'" class="ctable">
	<tr><td colspan="2"><img src="../images/uploadImage/<%=cb.getFileRealName()%>" class="ctd"></td></tr>
	<tr><td colspan="2"><%=cb.getCatName() %></td></tr>
	<tr><td colspan="2">등록날짜 <%=sdf.format(cb.getDate()) %></td></tr>
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
<div id="wbtn">
<input type="button" value="고양이등록" class="writeBtn" onclick="location.href='catReg.jsp'">
</div>
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

<a href="catList.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="catList.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="catList.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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