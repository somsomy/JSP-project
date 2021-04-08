<%@page import="board.FindBoardBean"%>
<%@page import="board.FindBoardDAO"%>
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
<link href="../css/findUpdate.css" rel="stylesheet" type="text/css">

 <script defer src="../script/reward.js"></script>
 <script defer src="../script/imageUpload.js"></script>
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
FindBoardBean fbb=fbdao.getBoard(num);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd hh:mm");
%>
<article>
<h1>찾습니다 글수정</h1>
<form action="findUpdatePro.jsp" method="post" enctype="multipart/form-data" >
<input type="hidden" name="num" value="<%=num%>">
<table id="catUpdateTab">
<tr><td class="sub">제목</td><td colspan="3" class="sub"><input type="text" name="subject" value="<%=fbb.getSubject()%>" class="ttd"></td></tr>
<tr><td colspan="4" id="writer">작성자 <%=fbb.getName() %></td></tr>
<tr><td class="line" id="ph">연락처</td><td class="line"><input type="text" name="phone" value="<%if(fbb.getPhone()!=null){ out.print(fbb.getPhone()); }%>" class="input_ch" readonly></td>
<td class="line" id="do">사례금</td><td class="line"><input type="text" name="reward" id="reward" value="<%=fbb.getReward()%>">
<select name="customSelect" id="customSelect" onchange="setSelect();">
 <option>직접입력</option>
 <option>협의</option>
 <option>10만원</option>
 <option>20만원</option>
 <option>30만원</option>
</select></td>
</tr>
<tr><td class="subsub">고양이종</td><td><input type="text" name="cat" value="<%=fbb.getCat()%>" class="input_ch" ></td>
<td class="subsub">나이</td><td><input type="text" name="catAge" value="<%=fbb.getCatAge()%>" class="input_ch" ></td>
</tr>
<tr><td class="subsub">고양이 이름</td><td><input type="text" name="catName" value="<%=fbb.getCatName()%>" class="input_ch" ></td>
<td class="subsub">성별</td><td><input type="radio" name="catGender" value="male" checked>수컷<input type="radio" name="catGender" value="female">암컷</td></tr>
<tr><td class="subsub">실종 장소</td><td><input type="text" name="catPlace" value="<%=fbb.getCatPlace()%>" class="input_ch" ></td>
<td class="subsub">실종 날짜</td><td><input type="text" name="catDate" value="<%=fbb.getCatDate()%>" class="input_ch" ></td></tr>
<tr><td class="subsub">상세내용</td><td colspan="3" id="previewId"><textarea name="content"><%=fbb.getContent()%></textarea></td></tr>
 <tr id="abtd"><td class="subsub">이미지</td><td colspan="3">
  <label class="file">이미지등록
  <input type="file" name="file" id="file" onchange="previewImage(this,'previewId')"></label>
  <input type="hidden" name="oldfile" value="<%=fbb.getFile()%>"> 기존이미지 <%=fbb.getFile()%>
  </td></tr>
</table>
<div id="wbtn">
<input type="submit" value="수정하기" class="writeBtn" >
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