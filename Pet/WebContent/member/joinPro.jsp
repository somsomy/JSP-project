<%@page import="email.JoinEmail"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id=request.getParameter("id");
String pass=request.getParameter("pass");
String confirmPassword=request.getParameter("confirmPassword");
String name=request.getParameter("name");
String nick=request.getParameter("nick");
String emailId=request.getParameter("emailId");
String email=request.getParameter("email");
String phone1=request.getParameter("phone1");
String phone2=request.getParameter("phone2");
String phone3=request.getParameter("phone3");
String postCode=request.getParameter("postCode");
String extraAddress=request.getParameter("extraAddress");
String address=request.getParameter("address");
String detailAddress=request.getParameter("detailAddress");
Timestamp date=new Timestamp(System.currentTimeMillis());

MemberBean mb=new MemberBean();

mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setNick(nick);
mb.setEmailId(emailId);
mb.setEmail(email);
mb.setPhone1(phone1);
mb.setPhone2(phone2);
mb.setPhone3(phone3);
mb.setPostCode(postCode);
mb.setExtraAddress(extraAddress);
mb.setAddress(address);
mb.setDetailAddress(detailAddress);
mb.setDate(date);

String to=emailId+"@"+email;

MemberDAO mdao=new MemberDAO();
int passCheck=mdao.passCheck(pass);
int idCheck=mdao.idCheck(id);
int idDup=mdao.idDupCheck(id);
int nickCheck=mdao.nickCheck(nick);
int nickDup=mdao.nickDupCheck(nick);

if(pass.equals(confirmPassword) && passCheck >= 2 && idCheck >=2 && idDup==-1 && nickCheck>=1 && nickDup==-1) {
	mdao.insertMember(mb);
	JoinEmail.naverMailSend(to);
	%> 
	<script>
		alert("가입되었습니다.");
		location.href="../main/main.jsp";
	</script>
	<%
} else {
	%>
	<script>
		alert("정보를 알맞게 입력해주세요.");
		history.back();
	</script>
	<%
}
%>
