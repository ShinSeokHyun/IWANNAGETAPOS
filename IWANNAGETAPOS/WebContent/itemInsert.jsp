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
	홈 > 관리자페이지 > 물품 추가
</div>
<div class=divPageName>
	물품추가
</div>
<form method=post id=frmData name=frmData>
<table width="100%" border="0">
  <tr>
    <td colspan="3"><table width="100%" border="0">
  <tr>
    <td width="30%">바코드</td>
    <td width="70%"><input type="text" name="m_barcode" id="m_barcode"></td>
  </tr>
  <tr>
    <td>이름</td>
    <td><input type="text" name="m_name" id="m_name"></td>
  </tr>
  <tr>
    <td>가격</td>
    <td><input type="text" name="m_price" id="m_price"></td>
  </tr>
  <tr>
    <td>재고</td>
    <td><input type="text" name="m_stock" id="m_stock"></td>
  </tr>
  <tr>
    <td>타입</td>
    <td>
    <select name="m_type2" id="m_type2">
      <option value="0">일반</option>
      <option value="1">기타</option>
      <option value="2">쓰레기봉투</option>
    </select>
    </td>
  </tr>
  <tr>
  	<td colspan=2><input type="button" onclick="javascript:document.frmData.submit();" value="추가"></td>
  </tr>
</table>
&nbsp;</td>
  </tr>
</table>
</form>

<%
if(request.getMethod().equals("POST")) {
	String barcode = request.getParameter("m_barcode");
	String name = request.getParameter("m_name");
	String price = request.getParameter("m_price");
	String stock = request.getParameter("m_stock");
	String type2 = request.getParameter("m_type2");
	
	if(!(barcode.equals("") && name.equals("") && price.equals("") && stock.equals("") && type2.equals(""))) {
		new dbcontroller().sqlQuery("INSERT INTO item VALUES('" + barcode + "', '" + name + "', '" + price + "', '" + stock + "', '" + type2 + "')");
		out.println("<script>alert('추가 완료');</script>");
	}
}
%>
</body>
</html>
</body>
</html>