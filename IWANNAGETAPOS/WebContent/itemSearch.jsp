<%@page import="Java.dbcontroller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="session.jsp">
		<jsp:param name="isadmin" value="0"/>
	</jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class=divHeader>
	홈 > 물품검색
</div>
<div class=divPageName>
	물품검색
</div>

<script type="text/javascript" src="sql.js"></script>
<script type="text/javascript" src="jquery-3.2.1.min.js"></script>

<script>
function showData() {
	var queryResult;
	var itemSearchType = $('#obj_searchtype').val();
	var itemWord = $('#obj_word').val();
	
	if(itemWord == '')
		return; 
	alert(itemWord);
	if(itemSearchType == 0)
		queryResult = sqlQuery("SELECT * FROM item WHERE barcode='" + itemWord + "'");
	else if(itemSearchType == 1)
		queryResult = sqlQuery("SELECT * FROM item WHERE name='*" + itemWord + "*'");
	
	if(queryResult.Count == 0) {
		alert("검색결과가 없습니다.");
		return;
	}
	
	$('#obj_barcode').val(queryResult.Data[0].c0);
	$('#obj_name').val(queryResult.Data[0].c1);
	$('#obj_price').val(queryResult.Data[0].c2);
	$('#obj_stock').val(queryResult.Data[0].c3);
	
	var type = queryResult.Data[0].c4;
	if(type == 0) {
		type = "일반";
	} else if(type == 1) {
		type = "기타";
	} else {
		type = "쓰레기봉투";
	}
	
	$('#obj_type').val(type);
}
</script>

<table width="100%" border="0">
  <tr>
    <td width="19%"><select name="obj_searchtype" id="obj_searchtype">
      <option value="0">바코드로 검색</option>
      <option value="1">이름으로 검색</option>
    </select></td>
    <td width="59%">
    <input type="text" name="obj_word" id="obj_word"></td>
    <td width="22%">
	<input type="button" id=obj_search name=obj_search onclick="showData()" value="검색">
      </td>
  </tr>
  <tr>
    <td colspan="3"><table width="100%" border="0">
  <tr>
    <td width="30%">바코드</td>
    <td width="70%"><input type="text" name="obj_barcode" id="obj_barcode" readonly></td>
  </tr>
  <tr>
    <td>이름</td>
    <td><input type="text" name="obj_name" id="obj_name" readonly></td>
  </tr>
  <tr>
    <td>가격</td>
    <td><input type="text" name="obj_price" id="obj_price" readonly></td>
  </tr>
  <tr>
    <td>재고</td>
    <td><input type="text" name="obj_stock" id="obj_stock" readonly></td>
  </tr>
  <tr>
    <td>타입</td>
    <td><input type="text" name="obj_type" id="obj_type" readonly></td>
  </tr>
</table>
&nbsp;</td>
  </tr>
</table>


</body>
</html>
</body>
</html>