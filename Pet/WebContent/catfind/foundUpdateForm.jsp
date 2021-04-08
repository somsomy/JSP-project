<%@page import="board.FoundBoardBean"%>
<%@page import="board.FoundBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
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

 <script defer src="../script/imageUpload.js"></script>
  <script defer src="../script/uploadDel.js"></script>
</head>
<body>
<div id="wrap">
<jsp:include page="../inc/top.jsp"/>
<div class="clear"></div>
<div id="divSub">
<div id="text">찾았어요</div>
<jsp:include page="../inc/catfindSubMenu.jsp"></jsp:include>
</div>
<div id="divArticle">

<%
int num=Integer.parseInt(request.getParameter("num"));

FoundBoardDAO fbdao=new FoundBoardDAO();
FoundBoardBean fbb=fbdao.getBoard(num);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");

%>
<article>
<h1>찾았어요 수정</h1>
<form action="foundUpdatePro.jsp" method="post" enctype="multipart/form-data" >
<input type="hidden" name="num" value="<%=fbb.getNum()%>">
<table id="cnotice">
<tr id="sub"><td >제목</td><td id="tsub"><input type="text" name="subject" id="title" placeholder="제목을 입력해주세요." value="<%=fbb.getSubject() %>" required></td></tr>
<tr><td class="tdtd">작성자</td><td class="tdtd"><input type="text" name="name" value="<%=fbb.getName() %>" id="writer" readonly></td></tr>
<tr class="subsub"><td class="consub">내용</td><td class="consub" id="previewId">
<%if(fbb.getFile()!=null) { %>
<img src="../images/uploadImage/<%=fbb.getFile()%>" id="conimg">
<%} %>
<textarea name="content" placeholder="내용을 입력해주세요." id="conupdate" required><%=fbb.getContent() %></textarea></td></tr>
<%if(fbb.getFile()!=null) { %>
<tr><td>업로드된 이미지</td>
<td>
<input type="text" name="fileRealName" id="fileRealName" value="<%=fbb.getFile()%>" readonly>
<input type="button" name="uploadFile" value="삭제" id="fileDel" onclick="uploadDel()">
<input type="hidden" name="oldfile" value=<%=fbb.getFile() %>>
</td></tr>
<%} %>
<tr id="abtd"><td>이미지</td><td colspan="3">
  <label class="file">이미지등록
  <input type="file" name="file" id="file" onchange="previewImage(this,'previewId')"></label>
  </td></tr>
</table>
<div id="wbtn">
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