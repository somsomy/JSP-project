<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String phone=request.getParameter("phone");
String postcode=request.getParameter("postCode");
String address=request.getParameter("address");
String detailaddress=request.getParameter("detailAddress");
String nick=request.getParameter("nick");

MemberBean mb=new MemberBean();
mb.setId(id);
mb.setName(name);
mb.setEmail(email);
mb.setPhone(phone);
mb.setPostCode(postcode);
mb.setAddress(address);
mb.setDetailAddress(detailaddress);
mb.setNick(nick);

MemberDAO mdao=new MemberDAO();
int check=mdao.userCheck(id, pass);
int check2=mdao.nickCheck(nick);
int check3=mdao.myPgaeNickDupCheck(nick, id);

if(check==1 && check2>=1) {
	mdao.updateMember(mb);
	response.sendRedirect("../mypage/myPage.jsp");
} else if(check!=1) {
	%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.back();
	</script>
	<%
} else if(check2==0){
	%>
	<script>
		alert("닉네임 중복확인 해주세요.");
		history.back();
	</script>
	<%
} else {
	%>
	<script>
		alert("정보를 올바르게 입력해주세요.");
		history.back();
	</script>
	<%
}
%>
