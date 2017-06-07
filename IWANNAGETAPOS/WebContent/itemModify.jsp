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
<script type="text/javascript" src="js/sql.js"></script>
<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
<script>
function ItemIst() {
	var queryResult = sqlQuery("SELECT * FROM item WHERE barcode = '" + $(document).find('#obj_barcode').val() + "'");
	if(queryResult.Count == 1) {
		alert("이미 존재하는 바코드입니다.");
		return false;
	}
	
	sqlQuery("INSERT INTO item VALUES('" + $(document).find('#obj_barcode').val() + "', '" +
			$(document).find('#obj_name').val() + "', '" + $(document).find('#obj_price').val() + "', '" +
			$(document).find('#obj_stock').val() + "', '" + $(document).find('#obj_type').val() + "')");
	alert("추가 완료");
}
</script>

<div class=divHeader>
	홈 > 관리자페이지 > 물품수정
</div>
<div class=divPageName>
	물품수정
</div>
<%
if(request.getMethod().equals("POST")) {
	String isdel = request.getParameter("isdel");
	String type = request.getParameter("m_type");
	String oriprice = request.getParameter("oriprice");
	if (type != null) {
		String word = request.getParameter("m_word");
		String query = "";
		if(type.equals("0"))
			query = "barcode = '" + word + "'";
		else if(type.equals("1"))
			query = "name = '" + word + "'";
		
		String result[][] = new dbcontroller().sqlQuery("SELECT * FROM item WHERE " + query);
		if(result[0][0] == null) {
			out.println("<script>alert('검색결과가 없습니다');</script>");
		} else {
			out.println("<script>showData('" + result[0][0] + "', '" + result[0][1] + "', '" + result[0][2] + "', '" + result[0][3] + "', '" + result[0][4] + "');</script>");
		}
	} else {
		if(!isdel.equals("1")) {
			String barcode = request.getParameter("m_barcode");
			String name = request.getParameter("m_name");
			String price = request.getParameter("m_price");
			String stock = request.getParameter("m_stock");
			String type2 = request.getParameter("m_type2");
			
			
			new dbcontroller().sqlQuery("UPDATE item SET barcode='" + barcode + "', name='" + name + "', price='" + price + "', stock='" + stock + "', type='" + type2 + "' WHERE barcode='" + oriprice + "'");
			out.println("<script>alert('수정 완료!');</script>");
		} else {
			new dbcontroller().sqlQuery("DELETE FROM item WHERE barcode='" + oriprice + "'");
			out.println("<script>alert('삭제 완료!'); document.getElementById('isdel').value=0;</script>");
		}
	}
}
%>

<script>
function ItemSrch() {
	sqlQuery()
}

function ItemUdt() {
	sqlQuery("UPDATE item SET barcode='" + $(document).find('#obj_barcode').val() + 
			"', name='" + $(document).find('#obj_name').val() + 
			"', price='" + $(document).find('#obj_price').val() + 
			"', stock='" + $(document).find('#obj_stock').val() + 
			"', type='" + $(document).find('#obj_type2').val() + 
			"' WHERE barcode='" + $(document).find('#obj_originalBarcode').val() + "'");
	alert('수정 완료');
}
function showData(barcode, name, price, stock, type) {
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
	document.getElementById("m_type2").value = type;
}
</script>

<form id=frmItemSearch method=POST>
<table width="100%" border="0">
  <tr>
    <td width="19%"><select name="m_type" id="obj_type">
      <option value="0">바코드로 검색</option>
      <option value="1">이름으로 검색</option>
    </select></td>
    <td width="59%">
    <input type="text" name="m_word" id="obj_word"></td>
    <td width="22%">
<input type="submit" value="검색">
      </td>
  </tr>
  </form>
  <form id=frmItemInfo method=POST>
  <tr>
    <td colspan="3"><table width="100%" border="0">
  <tr>
    <td width="30%">바코드</td>
    <td width="70%"><input type="text" name="obj_barcode" id="obj_barcode"></td>
  </tr>
  <tr>
    <td>이름</td>
    <td><input type="text" name="obj_name" id="obj_name"></td>
  </tr>
  <tr>
    <td>가격</td>
    <td><input type="text" name="obj_price" id="obj_price"></td>
  </tr>
  <tr>
    <td>재고</td>
    <td><input type="text" name="obj_stock" id="obj_stock"></td>
  </tr>
  <tr>
    <td>타입</td>
    <td>
    <select name="obj_type2" id="obj_type2">
      <option value="0">일반</option>
      <option value="1">기타</option>
      <option value="2">쓰레기봉투</option>
    </select>
    </td>
  </tr>
  <tr>
  	<td colspan=2>
  		<input type=hidden id=obj_originalBarcode name=obj_originalBarcode>
  		<input type=hidden id=obj_isDel name=obj_isDel value=0>
  		<input type=submit value=수정하기>
  		<input type=button onclick="javascript:document.getElementById('isdel').value=1; frmItemInfo.submit();" value=삭제하기>
  	</td>
</table>
&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>