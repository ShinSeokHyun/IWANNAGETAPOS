<%@page import="Java.dbcontroller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="session.jsp">
		<jsp:param name="isadmin" value="0"/>
	</jsp:include>
<%
	int type = Integer.parseInt(request.getParameter("type"));
	String result[][] = new dbcontroller().sqlQuery("SELECT * FROM item WHERE type='" + type + "'");
	
	
	if(result != null) {
		for (int i = 0; result[i][0] != null; i++) {
			out.println("<script>window.opener.addNormalItem('" + type + "', '" + result[i][1] + "', '" + result[i][2] + "', '" + result[i][0] + "');</script>");
		}
	}
%>

<script>
close();
</script>