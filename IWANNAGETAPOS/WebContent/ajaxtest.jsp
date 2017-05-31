<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
var m_ListLen = 2;
var m_ListData;
var data = new Array();
var defaultlist;

function sqlQuery(sQuery) {
	var xhr = new XMLHttpRequest();
	
	xhr.open("post", "dbControllerJSON.jsp", false);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhr.send("q=" + sQuery);
	
	return eval("(" + xhr.responseText + ")");
}


function saveList() {

	var m_Clone = $('.orderDetail:eq(0)');
	$('#divlist').append(m_Clone = m_Clone.clone());
	
	m_Clone.find('#obj_itemChk').prop("checked",true);
}

function temp() {
	saveList();
}
</script>

	<td><input type=checkbox class=obj_itemChk readonly></td>
	<td><input type=text name=obj_itemName readonly value=21></td>
		<td><input type=text name=obj_itemName readonly value=22></td>
	<td><input type=text class=obj_itemQuan readonly style='text-align:right' value=150> 개</td>
		<td><input type=text class=obj_itemQuan readonly style='text-align:right' value=151> 개</td>
	<td><input type=text class=obj_itemTotal readonly  style='text-align:right'> 원</td>
	<input type=hidden class=obj_itemBarcode>

	<table border=0 id=divlist width=100%>
	<tr class=orderDetail>
		<td><input type=checkbox id=obj_itemChk name=obj_itemChk readonly></td>
		<td><input type=text id=obj_itemName name=obj_itemName readonly></td>
		<td><input type=text id=obj_itemQuan name=obj_itemQuan readonly style='text-align:right'> 개</td>
		<td><input type=text id=obj_itemTotal name=obj_itemTotal style='text-align:right'> 원</td>
		<input type=hidden id=obj_itemBarcode name=obj_itemBarcode>
	</tr>
	<tr class=orderDetail>
		<td><input type=checkbox id=obj_itemChk name=obj_itemChk readonly></td>
		<td><input type=text id=obj_itemName name=obj_itemName readonly></td>
		<td><input type=text id=obj_itemQuan name=obj_itemQuan readonly style='text-align:right'> 개</td>
		<td><input type=text id=obj_itemTotal name=obj_itemTotal style='text-align:right'> 원</td>
		<input type=hidden id=obj_itemBarcode name=obj_itemBarcode>
	</tr>
	</table>
						
	<input type=button value=submit onclick="temp()" />
	
	clone.find('[type=checkbox]').prop("checked",false);
				clone.find('[type=text]').val("");
	
						