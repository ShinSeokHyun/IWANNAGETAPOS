<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IWANNAGETAPOSSYSTEM</title>
</head>
<body>
<%
	if(request.getMethod().equals("POST")) {
		String userid, userpassword;
		userid = request.getParameter("userid");
		userpassword = request.getParameter("userpassword");
		
		String data[][] = new Java.dbcontroller().sqlQuery("SELECT isadmin FROM user WHERE userid='" + userid + "' AND userpassword='" + userpassword + "'");
		
		if(data[0][0] == null) 
			out.println("<script>alert('아이디 혹은 비밀번호가 올바르지 않습니다.')</script>"); 
		else {
			session.setAttribute("ID", userid);
			session.setAttribute("isadmin", data[0][0]);
			out.println("<script>location.href='main.jsp';</script>");
		}
	}
%>
<form method=post>
	<table align=center>
		<tr>
			<td> ID : </td>
			<td> <input type=text name=userid size=10> </td>
		</tr>
		<tr>
			<td> PW : </td>
			<td> <input type=password name=userpassword size=10> </td>
		</tr>
		<tr>
			<td> <input type=submit value=로그인></td>
			<td> <input type=reset value=취소> </td>
		</tr>
	</table>
</form>
</body>
</html>