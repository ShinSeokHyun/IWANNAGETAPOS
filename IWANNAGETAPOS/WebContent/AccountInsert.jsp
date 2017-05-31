<%@page import="Java.dbcontroller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

    <jsp:include page="session.jsp">
		<jsp:param name="isadmin" value="1"/>
	</jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class=divHeader>
	홈 > 관리자페이지 > 계정추가
</div>
<div class=divPageName>
	계정추가
</div>
<form method=post>
<table width="100%" border="0">
  <tr>
    <td colspan="3"><table width="100%" border="0">
  <tr>
    <td width="30%">ID</td>
    <td width="70%"><input type="text" name="m_id" id="m_id"></td>
  </tr>
  <tr>
    <td>암호</td>
    <td><input type="password" name="m_pass" id="m_pass"></td>
  </tr>
  <tr>
    <td>이름</td>
    <td><input type="text" name="m_name" id="m_name"></td>
  </tr>
  <tr>
    <td>관리자 여부</td>
    <td><select name=m_admin id=m_admin>
	    <option value=1>예</option>
	    <option value=0>아니요</option>
	</select>
	</td>
  </tr>
  <tr>
  	<td colspan=2><input type="submit" value="추가"></td>
  </tr>
</table>
&nbsp;</td>
  </tr>
</table>
</form>

<%
if(request.getMethod().equals("POST")) {
	String m_id = request.getParameter("m_id");
	String m_pass = request.getParameter("m_pass");
	String m_name = request.getParameter("m_name");
	String m_admin = request.getParameter("m_admin");
	
	if(!(m_id.equals("") && m_pass.equals("") && m_name.equals("") && m_admin.equals(""))) {
		String result[][] = new dbcontroller().sqlQuery("SELECT * FROM user WHERE userid='" + m_id + "'");
		if( result[0][0] != null ) { 
			out.println("<script>alert('아이디 중복 입니다.');</script>");
		} else {
			new dbcontroller().sqlQuery("INSERT INTO user(userid, userpassword, username, isadmin) VALUES('" + m_id + "', '" + m_pass + "', '" + m_name + "', '" + m_admin + "')");
			out.println("<script>alert('추가 완료');</script>");
		}
	}
}
%>
</body>
</html>
</body>
</html>