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
	홈 > 관리자페이지 > 계정수정
</div>
<div class=divPageName>
	계정수정
</div>

<script>
function showData(barcode, name, price, stock) {
	var s = "";
	
	if(barcode == null) {
		alert("검색결과가 없습니다.");
		return;
	}
	
	document.getElementById("m_barcode").value = barcode;
	document.getElementById("oriprice").value = barcode;
	document.getElementById("m_name").value = name;
	document.getElementById("m_price").value = price;
	document.getElementById("m_stock").value = stock;
}
</script>

<form id=frmItemSearch method=POST>
<table width="100%" border="0">
  <tr>
    <td width="19%"><select name="m_type" id="m_type">
      <option value="0">아이디로 검색</option>
      <option value="1">이름으로 검색</option>
    </select></td>
    <td width="59%">
    <input type="text" name="m_word" id="m_word"></td>
    <td width="22%">
<input type="submit" value="검색">
      </td>
  </tr>
  </form>
  <form id=frmItemInfo method=POST>
  <tr>
    <td colspan="3"><table width="100%" border="0">
  <tr>
    <td width="30%">ID</td>
    <td width="70%"><input type="text" name="m_barcode" id="m_barcode"></td>
  </tr>
  <tr>
    <td>암호</td>
    <td><input type="text" name="m_name" id="m_name"></td>
  </tr>
  <tr>
    <td>이름</td>
    <td><input type="text" name="m_price" id="m_price"></td>
  </tr>
  <tr>
    <td>관리자 여부</td>
    <td><input type="text" name="m_stock" id="m_stock"></td>
  </tr>
  <tr>
  	<td colspan=2>
  		<input type=hidden id=oriprice name=oriprice>
  		<input type=hidden id=isdel name=isdel value=0>
  		<input type=submit value=수정하기>
  		<input type=button onclick="javascript:document.getElementById('isdel').value=1; frmItemInfo.submit();" value=삭제하기>
  	</td>
</table>
&nbsp;</td>
  </tr>
</table>
</form>

<%
if(request.getMethod().equals("POST")) {
	String isdel = request.getParameter("isdel");
	String type = request.getParameter("m_type");
	String oriprice = request.getParameter("oriprice");
	if (type != null) {
		String word = request.getParameter("m_word");
		String query = "";
		if(type.equals("0"))
			query = "userid = '" + word + "'";
		else if(type.equals("1"))
			query = "username = '" + word + "'";
		
		String result[][] = new dbcontroller().sqlQuery("SELECT * FROM user WHERE " + query);
		if(result[0][0] == null) {
			out.println("<script>alert('검색결과가 없습니다');</script>");
		} else {
			out.println("<script>showData('" + result[0][1] + "', '" + result[0][2] + "', '" + result[0][3] + "', '" + result[0][4] + "');</script>");
		}
	} else {
		if(!isdel.equals("1")) {
			String barcode = request.getParameter("m_barcode");
			String name = request.getParameter("m_name");
			String price = request.getParameter("m_price");
			String stock = request.getParameter("m_stock");
			
			String result[][] = new dbcontroller().sqlQuery("SELECT * FROM user WHERE userid='" + barcode + "'");
			if(!barcode.equals(oriprice) && result[0][0] != null ) { 
				out.println("<script>alert('아이디 중복 입니다.');</script>");
			} else {
				new dbcontroller().sqlQuery("UPDATE user SET userid='" + barcode + "', userpassword='" + name + "', username='" + price + "', isadmin='" + stock + "' WHERE userid='" + oriprice + "'");
				out.println("<script>alert('수정 완료!');</script>");
			}
		} else {
			new dbcontroller().sqlQuery("DELETE FROM user WHERE userid='" + oriprice + "'");
			out.println("<script>alert('삭제 완료!'); document.getElementById('isdel').value=0;</script>");
		}
	}
}
%>
</body>
</html>