<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%--
	사용법
	<jsp:include page="session.jsp">
		<jsp:param name="isadmin" value="1"/>
	</jsp:include>
--%>

<%
	Object m_isAdmin = session.getAttribute("isadmin");
	if(m_isAdmin == null) {
		out.print("<script>alert('로그인이 필요한 페이지입니다.'); location.href='login.jsp';</script>");
		out.close();
	}
	if(Integer.parseInt((String)m_isAdmin) > 
			Integer.parseInt((String)(session.getAttribute("isadmin")))) {
		out.print("<script>alert('접근권한이 없습니다'); history.back(-1);</script>");
		out.close();
	}
%>
</body>
</html>