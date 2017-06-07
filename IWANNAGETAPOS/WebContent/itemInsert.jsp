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
	홈 > 관리자페이지 > 물품 추가
</div>
<div class=divPageName>
	물품추가
</div>
<table width="100%" border="0">
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
    <select name="obj_type" id="obj_type">
      <option value="0">일반</option>
      <option value="1">기타</option>
      <option value="2">쓰레기봉투</option>
    </select>
    </td>
  </tr>
  <tr>
  	<td colspan=2><input type="button" onclick="ItemIst();" value="추가"></td>
  </tr>
</table>
&nbsp;</td>
  </tr>
</table>
</body>
</html>