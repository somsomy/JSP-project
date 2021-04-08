<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="../css/dropdown.css"/>
 <link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet"><header>
<%
String id=(String)session.getAttribute("id");

if(id==null) {
	%> 
	<div id="login"><a href="../main/main.jsp">홈 | </a> <a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a></div>
	<%
} else {
	%>
	<div id="login"><%=id %>님 | <a href="../member/logout.jsp">로그아웃</a> | <a href="../mypage/myPage.jsp">마이페이지</a></div>
	<%
}
%>

<div id="catcenter">고양이보호센터</div>

<div class="clear"></div>
<hr color="#EAEAEA">
<div id="logo"><a href="../main/main.jsp"><img src="../images/logo.png" width="280" height="75" alt="Fun Web"></a></div>

<nav id="top_menu">
<ul class="tmenu">
	<li class="tl"><a href="../company/welcome.jsp" class="ta">고양이의 하루</a>
	 <ul class="submenu">
	 	<li><a href="../company/welcome.jsp" >보호센터 소개</a></li>
	 	<li><a href="../company/notice.jsp" >공지사항</a></li>
	 	<li><a href="../company/map.jsp" >센터 위치</a></li>
	 </ul>
	</li>
	<li class="tl"><a href="../catfind/catFind.jsp" class="ta">고양이를 찾습니다</a>
	 <ul class="submenu">
	 	<li><a href="../catfind/catFind.jsp" >찾습니다</a></li>
	 	<li><a href="../catfind/catFound.jsp" >찾았어요</a></li>
	 </ul>
	</li>
	<li class="tl"><a href="../center/adoptInfo.jsp" class="ta">고양이를 입양합니다</a>
	 <ul class="submenu">
	 	<li><a href="../center/adoptInfo.jsp" >입양 안내</a></li>
	 	<li><a href="../center/cats.jsp" >보호중인 아이들</a></li>
	 	<li><a href="../center/adopt.jsp" >입양문의</a></li>
	 	<li><a href="../center/catsAdoptComp.jsp" >입양 완료</a></li>
	 	<li><a href="../center/comment.jsp" >입양 후기</a></li>
	 </ul>
	</li>
	<li class="tl"><a href="../support/supportCats.jsp" class="ta">고양이에게 후원합니다</a>
	 <ul class="submenu">
	 	<li><a href="#" >후원 안내</a></li>
	 	<li><a href="../support/supportCats.jsp" >1:1 후원</a></li>
	 </ul>
	</li>
	<li class="tl"><a href="../volunteer/volunteer.jsp" class="ta">자원봉사</a></li>
    <li class="tl"><a href="../qna/qna.jsp" class="ta">문의합니다</a></li>
</ul>
</nav>
</header>