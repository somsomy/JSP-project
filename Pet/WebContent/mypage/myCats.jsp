<%@page import="cats.CatsDAO"%>
<%@page import="cats.CatsBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="supporter.SupporterBean"%>
<%@page import="supporter.SupporterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/myCats.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">나의 고양이들</div>
<hr id="texthr">
<div id="text2">회원님께서 후원하고 있는 고양이들.</div>
<jsp:include page="../inc/myPageSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<article>
<%
String id=(String)session.getAttribute("id");

SupporterDAO sdao=new SupporterDAO();

int count=sdao.getCatsCount(id);

int pageSize=3;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;
List<SupporterBean> sbList=sdao.getCatsList(startRow,pageSize,id);
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");

CatsDAO cdao=new CatsDAO();
%> 
<h1>나의 고양이</h1>
<hr>
<div id="hinfo">회원님께서 후원하고 있는 고양이</div>
<form action="updatePro.jsp"  id="join" method="post">
<table class="mycatsTable">
<tr>
<%
for(int i = 0; i <sbList.size(); i++) {
	SupporterBean sb=sbList.get(i);
	CatsBean cb=cdao.getCats(sb.getCatId());
	%>
	<td><table onclick="location.href='myCatsContent.jsp?num=<%=sb.getNum()%>'" class="mycats">
	<tr><td><img src="../images/uploadImage/<%=cb.getFileRealName()%>" class="mycatsImg"></td></tr>
	<tr><td class="mycatsName"><%=cb.getCatName() %> 는(은) 행복해요.</td></tr>
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
<div id="buttons">
</div>
</form>
</article>
</div>
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

<a href="myCats.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="myCats.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="myCats.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
	<%
}
%>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>