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

<script type="text/javascript" src="sql.js"></script>
<script type="text/javascript" src="jquery-3.2.1.min.js"></script>
<script>
var m_ListLen = 0;
var m_DetailLen = 0;
var Limit = 20;

function init() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; 
	var yyyy = today.getFullYear();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = yyyy + '-' + mm + '-' + dd;
	
	$('#obj_dateStart').val(today);
	$('#obj_dateEnd').val(today);
	
	search();
}

function addOrderHistoryDetail(orderNo) {
	var defClone = $('.detailList:eq(0)');
	var queryResult;
	var orderName;
	var orderQuantity;
	var orderPrice;
	
	clearOrderDetail();
	
	queryResult = sqlQuery("SELECT `name`, `quantity`, `price` FROM `orderitem` JOIN `item` ON `item`.`barcode` = `orderitem`.`barcode` WHERE `orderNo` = '" + orderNo + "'");
	if(queryResult.Count == 0) {
		return;
	}
	
	for(var i = 0; i < queryResult.Count; i++) {
		orderName = queryResult.Data[i].c0;
		orderQuantity = queryResult.Data[i].c1;
		orderPrice = queryResult.Data[i].c2;
		
		if(m_DetailLen != 0) {
			$('#divDetail').append(defClone = defClone.clone());
		}
		
		defClone.find('#obj_detailName').val(orderName);
		defClone.find('#obj_detailQuan').val(orderQuantity);
		defClone.find('#obj_detailTotal').val((orderPrice*1) * (orderQuantity*1));
		
		m_DetailLen++;
	}	
}

function clearOrderHistory() {
	$('.historyList').each(function() {
		if($(this).index() == 1) {
			$(this).find('[type=text]').each(function() {
				$(this).val("");
			});
			return true;
		}
		$(this).remove();
	});
	m_ListLen = 0;
}

function clearOrderDetail() {
	$('.detailList').each(function() {
		if($(this).index() == 1) {
			$(this).find('[type=text]').each(function() {
				$(this).val("");
			});
			return true;
		}
		$(this).remove();
	});
	
	m_DetailLen = 0;
	$('#obj_Total').val(0);
}

function search() {
	addOrderHistory($('#obj_dateStart').val(), $('#obj_dateEnd').val());
}

function addOrderHistory(dateStart, dateEnd) {
	var defClone = $('.historyList:eq(0)');
	var queryResult;
	var orderNo;
	var orderTotalPrice;
	var orderDate;
	
	clearOrderHistory();
	
	queryResult = sqlQuery("SELECT * FROM `order` WHERE date >= '" + dateStart + "' AND date <= '" + dateEnd + " 23:59:59'");
	if(queryResult.Count == 0) {
		return;
	}
	
	for(var i = 0; i < queryResult.Count; i++) {
		orderNo = queryResult.Data[i].c0;
		orderTotalPrice = queryResult.Data[i].c1;
		orderDate = queryResult.Data[i].c2;
		
		if(m_ListLen != 0) {
			$('#divList').append(defClone = defClone.clone());
		}
		
		defClone.find('#obj_orderNo').val(orderNo);
		defClone.find('#obj_orderTotalPrice').val(orderTotalPrice);
		defClone.find('#obj_orderDate').val(orderDate);
		defClone.find('.obj_viewOrder').on('click',function() {
			addOrderHistoryDetail(
					$('.historyList').eq($('.obj_viewOrder').index(this)).find('#obj_orderNo').val());
		});
		defClone.find('.obj_cancelOrder').on('click',function() {
			doOrderCancel(
					$('.historyList').eq($('.obj_cancelOrder').index(this)).find('#obj_orderNo').val());
		});
		
		m_ListLen++;
		
		$('#obj_Total').val($('#obj_Total').val()*1 + orderTotalPrice*1);
	}
}

function doOrderCancel(orderNo) {
	if(confirm("정말로 삭제하시겠습니까?")) {
		sqlQuery("DELETE FROM `order` WHERE no='" + orderNo + "'");
		sqlQuery("DELETE FROM `orderitem` WHERE orderno='" + orderNo + "'");
	}
	search();
}

</script>
<body onload="init();">
<div class=divHeader>

</div>
<div class=divPageName>

</div>
<div class=divContents>
<table width="100%" height="597" border="1" >
  <tr>
    <th width="80%" height="556" scope="col" valign="top">
    	<table width="100%" border="1">
      <tr>
        <td>시간 지정</td>
        <td>
        <input type=text name=obj_dateStart id=obj_dateStart> ~ 
        <input type=text name=obj_dateEnd id=obj_dateEnd>
        </td>
        <td><input type=button onclick="javascript:Limit = 20; search();" value="검색"></td>
      </tr>
    </table>
    <div style="width:100%; height:500px; overflow:auto">
	   	<table id=divList>
		<tr>
			<th>번호</th>
			<th>거래시간</th>
			<th>금액</th>
			<th>상세내역</th>
			<th>취소</th>
		</tr>
		<tr class=historyList>
			<td><input type=text id=obj_orderNo name=obj_orderNo readonly></td>
			<td><input type=text id=obj_orderDate name=obj_orderDate readonly></td>
			<td><input type=text id=obj_orderTotalPrice name=obj_orderTotalPrice readonly></td>
			<td><a href="#" class=obj_viewOrder>보기</a></td>
			<td><a href="#" class=obj_cancelOrder>취소</a></td>
		</tr>
		</table>
	</div>
    </th>
    <th width="20%" scope="col" valign="top">
    <div style="overflow:auto">
		<table border=0 id=divDetail>
			<tr align=center>
				<th>품명</th>
				<th>수량</th>
				<th>가격</th>
			</tr>
			<tr class=detailList>
				<td><input type=text id=obj_detailName name=obj_detailName readonly></td>
				<td><input type=text id=obj_detailQuan name=obj_detailQuan readonly></td>
				<td><input type=text id=obj_detailTotal name=obj_detailTotal readonly></td>
			</tr>
		</table>
	</div>
	</th>
	
  </tr>
  <tr>
    <td>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;총액 : <input type=text id=obj_Total name=obj_Total value=0 disabled>
    </td>
    <td>&nbsp;</td>
  </tr>
</table>

</div>
</body>
</html>