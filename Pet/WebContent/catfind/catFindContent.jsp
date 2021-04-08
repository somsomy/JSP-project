<%@page import="board.FindBoardBean"%>
<%@page import="board.FindBoardDAO"%>
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
<link href="../css/FindContent.css" rel="stylesheet" type="text/css">

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
int num=Integer.parseInt(request.getParameter("num"));
FindBoardDAO fbdao=new FindBoardDAO();
fbdao.updateReadcount(num);
FindBoardBean fbb=fbdao.getBoard(num);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");

%>
<article>
<h1>찾습니다</h1>
<hr>
<table id="catFindTab">
<tr><td colspan="4" id="imgMargin"><img src="../images/uploadImage/<%=fbb.getFile()%>" width="300" height="300"></td></tr>
<tr id="pcolor"><td colspan="5" id="phone">연락처 : <%=fbb.getPhone() %></td></tr>
<tr><td class="bname">사례금</td><td colspan="1" class="cont"><%=fbb.getReward() %></td>
<td class="gender">작성자</td><td><%=fbb.getName() %></td>
</tr>
<tr><td class="bname">고양이종</td><td class="bcont"><%=fbb.getCat() %></td>
<td class="gender">성별</td><td class="bcont"><%=fbb.getCatGender() %></td></tr>
<tr><td class="bname">고양이 이름</td><td class="bcont"><%=fbb.getCatName() %></td>
<td class="gender">나이</td><td class="bcont"><%=fbb.getCatAge() %></td></tr>
<tr><td class="bname">실종 장소</td><td class="bcont"><%=fbb.getCatPlace() %></td>
<td class="gender">실종 날짜</td><td class="bcont"><%=fbb.getCatDate() %></td></tr>
<tr><td class="bname">글제목</td><td colspan="3" class="cont"><%=fbb.getSubject() %></td></tr>
<tr><td class="bname">글내용</td><td colspan="3" class="cont">
<textarea readonly class="cont"><%=fbb.getContent()%></textarea></td></tr>
</table>
<%
String id=(String)session.getAttribute("id");
MemberDAO mdao=new MemberDAO();
if(id != null) {
MemberBean mb=mdao.getMember(id);

if(mb.getNick()!=null) {
if(mb.getNick().equals(fbb.getName())) {
	
%>
<div id="wbtn">
<input type="button" value="글수정" class="writeBtn" onclick="location.href='findUpdateForm.jsp?num=<%=fbb.getNum() %>'">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='findDelete.jsp?num=<%=fbb.getNum()%>'">
</div>
<%
}
	}
}
if(id!=null) {
	if(id.equals("admin")) {
%>
<div id="wbtn">
<input type="button" value="글삭제" class="writeBtn" onclick="location.href='findDelete.jsp?num=<%=fbb.getNum()%>'">
</div>
<%}} %>
<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>