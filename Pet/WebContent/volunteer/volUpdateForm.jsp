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
<div id="text2">사랑의 손길을 내어주세요.</div>
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
<form action="volUpdatePro.jsp" method="post" enctype="multipart/form-data" >
<input type="hidden" name="num" value="<%=vb.getNum()%>">
<table id="cnotice">
<tr id="sub"><td >제목</td><td id="tsub"><input type="text" name="subject" id="title" placeholder="제목을 입력해주세요." value="<%=vb.getSubject() %>" required></td>
<td>
<select name="state" id="volselect">
 <option value="모집중" <%if(vb.getState().equals("모집중")){out.print("selected");} %>>모집중</option>
 <option value="모집완료" <%if(vb.getState().equals("모집완료")){out.print("selected");} %>>모집완료</option>
</select>
</td>
</tr>
<tr><td class="tdtd">작성자</td><td class="tdtd" colspan="2"><input type="text" name="name" value="<%=vb.getName() %>" id="writer" readonly></td></tr>
<tr class="subsub"><td class="consub">내용</td><td class="consub" id="previewId" colspan="2">
<textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required><%=vb.getContent() %></textarea></td></tr>
  <tr class="subimg"><td>첨부파일</td><td colspan="2" colspan="2"> 
  <label class="file">첨부파일 업로드
  <input type="file" name="file" id="file" onchange="previewImage(this,'previewId')">
  <input type="hidden" name="oldfile" value="<%if(vb.getFile()!=null) {out.print(vb.getFile());}%>">
  </label> <%if(vb.getFile()!=null) {out.println("기존 파일 : " + vb.getFile());} %> 
  </td></tr>
  </table>
<div id="wbtn">
<input type="button" value="목록" class="writeBtn" onclick="location.href='volunteer.jsp'">
<input type="submit" value="글수정" class="writeBtn">
</div>
</form>

<div class="clear"></div>

</article>
</div>
<div class="clear"></div>
<jsp:include page="../inc/bottom.jsp"/>
</div>
</body>
</html>