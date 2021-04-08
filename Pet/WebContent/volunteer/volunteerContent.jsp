<%@page import="board.ReplyBean"%>
<%@page import="board.ReplyDAO"%>
<%@page import="board.VolunteerBean"%>
<%@page import="board.VolunteerDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
<link href="../css/content.css" rel="stylesheet" type="text/css">
<link href="../css/reply.css" rel="stylesheet" type="text/css">

 <script defer src="../script/reply.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>

<div class="clear"></div>
<div id="divSub">
<div id="text">자원봉사</div>
<hr id="texthr">
<div id="text2">사랑의 손길을 내어주세요. </div>
<div id="sub_img"></div>
</div>

<%
int num=Integer.parseInt(request.getParameter("num"));

VolunteerDAO vdao=new VolunteerDAO();
vdao.updateReadcount(num);
VolunteerBean vb=vdao.getBoard(num);

String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
MemberBean mb=mdao.getMember(id);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd HH:mm");

%>
<div id="divArticle">
<article>
<h1>자원봉사 모집</h1>
<hr>
<table id="cnotice">
<tr id="sub"><td colspan="2"><%=vb.getSubject() %></td></tr>
<tr><td colspan="2" id="write"><%=vb.getName() %></td></tr>
<tr><td class="tdtd">  작성일 <%=sdf.format(vb.getDate()) %></td><td id="readtd">조회수 <%=vb.getReadcount() %></td></tr>
<tr id="cbtr"><td colspan="2" id="con"><%=vb.getContent() %></td></tr>
<tr><td id="down" colspan="2">파일 
<%if(vb.getFile()!=null) { %>
<a href="../images/uploadImage/<%=vb.getFile()%>" download><%=vb.getFile() %>다운로드</a>
<%} else {
	%>
	첨부파일없음
	<%
}
%>
</td></tr>
</table>
<%
ReplyDAO rdao=new ReplyDAO();

int count=rdao.getReplyCount(num);

int pageSize=20;

String pageNum=request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;

int endRow = currentPage*pageSize;

List<ReplyBean> rbList=rdao.getReplyList(startRow, pageSize, num);

for(int i=0; i<rbList.size(); i++) { 
		ReplyBean rb=rbList.get(i);
		
		int hide=i;

%>
<table id="reply">
<%
int wid=0;

if(rb.getRe_lev()>0) {
	wid=rb.getRe_lev()*4;
%>
<tr><td rowspan="4">
<img src="../images/blank.png" width="<%=wid%>" > 
</td></tr>
<% } %>
<tr><td class="rep" colspan="2"><%=rb.getName() %></td></tr>
<tr><td class="rep" colspan="2"><%=sdf.format(rb.getDate()) %></td></tr>
<tr><td class="recon" ><%=rb.getContent() %></td>
<td>
<%
if(mb.getNick()!=null) {
if(mb.getNick().equals(rb.getName())) { %>
<a onclick="location.href='replyDelete.jsp?num=<%=rb.getNum()%>&boardNum=<%=rb.getBoardNum()%>&re_lev=<%=rb.getRe_lev()%>&re_ref=<%=rb.getRe_ref()%>'">삭제</a>
<a onclick="updateOpen<%=i%>()">수정</a>
<%} }

if(id!=null) {
%>
<a onclick="open<%=i%>()" >답글</a>
<%}%>
</td>
</tr>
</table>

<form action="replyUpdatePro.jsp" method="post" name="fr">
<div id="hideReplyUpdate<%=hide %>" class="hideRep">
<input type="hidden" name="num" value="<%=rb.getNum()%>">
<input type="hidden" name="boardNum" value="<%=rb.getBoardNum()%>">
<textarea id="hidecont" name="recontent" onkeyup="resize(this)"><%=rb.getContent() %></textarea>
<input type="submit" value="수정" id="rebtn">
<input type="button" value="취소" onclick="updateClose<%=i%>()" id="recancelBtn">
</div>
</form>

<form action="replyRegPro2.jsp" method="post" name="fr">
<div id="hideReply<%=hide %>" class="hideRep">
<input type="hidden" name="boardNum" value="<%=num%>">
<input type="hidden" name="re_ref" value="<%=rb.getRe_ref()%>">
<input type="hidden" name="re_lev" value="<%=rb.getRe_lev() %>">
<input type="hidden" name="re_seq" value="<%=rb.getRe_seq() %>">
<input type="hidden" name="name" value="<%=mb.getNick() %>">
<textarea id="hidecont" name="recontent" onkeyup="resize(this)"></textarea>
<input type="submit" value="등록" id="rebtn">
<input type="button" value="취소" onclick="close<%=i%>()" id="recancelBtn">
</div>
</form>
<script>
function open<%=i%>() {
	document.getElementById('hideReply'+<%=i%>).style.display='block';
	
}
function updateOpen<%=i%>() {
	document.getElementById('hideReplyUpdate'+<%=i%>).style.display='block';
}

function close<%=i%>() {
	document.getElementById('hideReply'+<%=i%>).style.display='none';
}

function updateClose<%=i%>() {
	document.getElementById('hideReplyUpdate'+<%=i%>).style.display='none';
}
</script>
<%} %>

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

<a href="volunteerContent.jsp?pageNum=<%=startPage-pageBlock%>&num=<%=num%>">이전</a>
<%} 
for(int i=startPage;i<=endPage;i++){
	%>
	<a href="volunteerContent.jsp?pageNum=<%=i%>&num=<%=num%>"><%=i %></a>
	<%
}
%>
<%
if(endPage < pageCount){
	%>
	<a href="volunteerContent.jsp?pageNum=<%=startPage+pageBlock%>&num=<%=num%>">다음</a>
	<%
}
%>
</div>


<div id="comdiv">
<span id="com">댓글작성</span>
<form action="replyRegPro.jsp" method="post">
<input type="hidden" name="boardNum" value="<%=num%>">
<input type="hidden" name="name" value="<%=mb.getNick()%>">
<textarea name="content" id="comtext" onkeyup="resize(this)" 
placeholder="<%if(id==null){out.print("로그인이 필요합니다.");} else{out.print("댓글을 남겨주세요."); }%>"
<%if(id==null){out.print("readonly");} %>
></textarea>
<%if(id!=null) { %>
<input type="submit" class="combtn" value="작성">
<% } %>
</form>
</div>
<div id="wbtn">
<input type="button" value="목록" class="writeBtn" onclick="location.href='volunteer.jsp'">
<%
if(id!=null) {
if(id.equals("admin")) { %>
<input type="button" value="수정" class="writeBtn" onclick="location.href='volUpdateForm.jsp?num=<%=vb.getNum() %>'">
<input type="button" value="삭제" class="writeBtn" onclick="location.href='volDelete.jsp?num=<%=vb.getNum()%>'">
<% } }%>
</div>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>