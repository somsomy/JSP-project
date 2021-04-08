<%@page import="board.FindBoardBean"%>
<%@page import="board.FindBoardDAO"%>
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
<link href="../css/find.css" rel="stylesheet" type="text/css">
<link href="../css/hover.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">찾습니다</div>
<hr id="texthr">
<div id="text2">고양이가 따뜻한 가족의 품으로 돌아갈 수 있도록 도와주세요.</div>
<jsp:include page="../inc/catfindSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">
<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");

FindBoardDAO fbdao=new FindBoardDAO();

int count=fbdao.getBoardCount();

int pageSize=8;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<FindBoardBean> fbbList=fbdao.getBoardList(startRow,pageSize);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");


%>
<article>
<h1>찾습니다</h1>
<hr>
<table id="topTable">
<tr>
 <%

for(int i = 0; i <fbbList.size(); i++) {
	FindBoardBean fbb=fbbList.get(i);
	
	%>
	<td><table onclick="location.href='catFindContent.jsp?num=<%=fbb.getNum()%>'" class="findTab">
	<tr><td colspan="2">
	<figure class="snip1384">
  <img src="../images/uploadImage/<%=fbb.getFile()%>" width="290" height="270" alt="sample83" />
  <figcaption>
    <h3><%=fbb.getCatName() %></h3>
    <p>성별 <%=fbb.getCatGender() %> </p><i class="ion-ios-arrow-right"></i>
    <p>나이 <%=fbb.getCatAge() %> </p>
  </figcaption>
  <a href="#"></a>
</figure>
	</td></tr>
	<tr><td colspan="2" class="ttd"><%=fbb.getSubject() %></td></tr>
	<tr><td colspan="2" >장소 <%=fbb.getCatPlace() %></td></tr>
	<tr><td >등록날짜 <%=sdf.format(fbb.getDate()) %></td><td>조회수 <%=fbb.getReadcount() %></td></tr>
	</table></td>
	<%
	if((i+1)%4==0) {
		%>
		</tr>
		<%
	}
	
}

%>   
</table>
<div class="clear"></div>
<div id="wbtn">
<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='findWriteForm.jsp'">
</div>
<div class="clear"></div>
<div id="table_search">
<form action="catFindSearch.jsp" method="get">
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

<a href="catFind.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="catFind.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="catFind.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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