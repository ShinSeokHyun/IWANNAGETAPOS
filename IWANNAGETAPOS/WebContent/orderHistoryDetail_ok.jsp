<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="session.jsp">
		<jsp:param name="isadmin" value="0"/>
	</jsp:include>    
<%
	double orderno = Double.parseDouble(request.getParameter("orderno"));
	String result[][] = new Java.dbcontroller().sqlQuery("SELECT DISTINCT * FROM order_item JOIN item ON `order_item`.barcode = `item`.barcode WHERE orderno='" + orderno + "'");
	
	if(result[0][0] != null) {
		for (int i = 0; result[i][0] != null; i++) {
			out.println("<script>window.opener.addOrderHistoryDetail('" + result[i][4] + "', '" + result[i][2] + "', '" + result[i][5] + "');</script>");
		}
	}
%>

<script>
close();
</script>