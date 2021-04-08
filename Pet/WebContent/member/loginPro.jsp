<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id=request.getParameter("id");
String pass=request.getParameter("pass");

MemberBean mb=new MemberBean();
mb.setId(id);
mb.setPass(pass);

MemberDAO mdao=new MemberDAO();

int check=mdao.userCheck(id, pass);

if(check==1) {
	session.setAttribute("id", id);
	response.sendRedirect("../main/main.jsp");
}
%>
<script>
const check=<%=check%>
if(check==0) {
	alert("가입하지 않은 아이디거나 잘못된 비밀번호입니다.");
	history.back();
} else if(check==-1) {
	alert("아이디없음");
	history.back();
}
</script>