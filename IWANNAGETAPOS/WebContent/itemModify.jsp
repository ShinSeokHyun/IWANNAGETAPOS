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

<div class=divHeader>
	홈 > 관리자페이지 > 물품수정
</div>
<div class=divPageName>
	물품수정
</div>

<script>
function clear() {
	$(document).find('[type=text]').each(function() {
		$(this).val("");
	});
}

function ItemDel() {
	if($(document).find('#obj_barcode').val() != "") {
		var queryResult = sqlQuery("DELETE FROM item WHERE barcode='" + 
				$(document).find('#obj_originalBarcode').val() + "'");
		clear();
		alert("삭제 완료");
	}
}

function ItemSrch() {
	var columns = ($(document).find('#obj_type').val() == 0) ? "barcode" : "name";
	var queryResult = 
		sqlQuery("SELECT * FROM item WHERE " + columns + 
						" = " + $(document).find('#obj_word').val());
	clear();
	if(queryResult.Count == 0) {
		alert("검색결과가 없습니다");
		return false;
	}
	
	$(document).find('#obj_originalBarcode').val(queryResult.Data[0].c0);
	$(document).find('#obj_barcode').val(queryResult.Data[0].c0);
	$(document).find('#obj_name').val(queryResult.Data[0].c1);
	$(document).find('#obj_price').val(queryResult.Data[0].c2);
	$(document).find('#obj_stock').val(queryResult.Data[0].c3);
	$(document).find('#obj_type2').val(queryResult.Data[0].c4);
}

function ItemUdt() {
	sqlQuery("UPDATE item SET barcode='" + $(document).find('#obj_barcode').val() + 
			"', name='" + $(document).find('#obj_name').val() + 
			"', price='" + $(document).find('#obj_price').val() + 
			"', stock='" + $(document).find('#obj_stock').val() + 
			"', type='" + $(document).find('#obj_type2').val() + 
			"' WHERE barcode='" + $(document).find('#obj_originalBarcode').val() + "'");
	clear();
	alert('수정 완료');
}
</script>

<table width="100%" border="0">
  <tr>
    <td width="19%"><select name="obj_type" id="obj_type">
      <option value="0">바코드로 검색</option>
      <option value="1">이름으로 검색</option>
    </select></td>
    <td width="59%">
    <input type="text" name="obj_word" id="obj_word" onkeydown="javascript:if(event.keyCode==13){ItemSrch();}"></td>
    <td width="22%">
<input type="button" onclick='ItemSrch()' value="검색">
      </td>
  </tr>
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
  		<input type=button onclick='ItemUdt();' value=수정하기>
  		<input type=button onclick="ItemDel();" value=삭제하기>
  	</td>
</table>
&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>