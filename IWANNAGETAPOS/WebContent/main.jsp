<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <jsp:include page="session.jsp">
		<jsp:param name="isadmin" value="0"/>
	</jsp:include>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>IWANNAGETAPOSSYSTEM</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style type="text/css">
input[type=text], input[type=textbox] {
	background-color:transparent;
	border:none;
}
table {
	border: 1px solid ;
	border-collapse: collapse;
}
.noborder {
	background:url("mainBgGround.png");
	background-attachment: fixed;
	background-repeat: repeat-x;
	border: 0px solid ;
	border-collapse: collapse;
}

.noborder2 {
	background:url("mainBgGround.png");
	background-attachment: fixed;
	background-repeat: repeat-x;
	background-position: bottom right;
	border: 0px solid ;
	border-collapse: collapse;
}
</style>
<script type="text/javascript" src="sql.js"></script>
<script type="text/javascript" src=inc.js></script>
<script type="text/javascript" src="jquery-3.2.1.min.js"></script>

<script type="text/javascript">
$(init);

function confirmOrder() {
	if(m_ListLen == 0) {
		alert("저장 할 주문이 없습니다.");
		return;
	}
	
	sqlQuery("INSERT INTO `order`(`totalprice`) VALUES('" + $('#obj_viewTotal').val() + "')");
	var queryResult = sqlQuery("SELECT `no` FROM `order` ORDER BY `no` DESC LIMIT 0,1");
	var newOrderNo = (queryResult.Count == 0) ? 0 : queryResult.Data[0].c0;
	
	$('.orderDetail').each(function() {
		if($(this).find('#obj_itemChk').is(":checked") == true) {
			sqlQuery("INSERT INTO `orderitem`(`orderNo`,`barcode`,`quantity`) VALUES('" + newOrderNo + "', '" + 
					$(this).find('#obj_itemBarcode').val() + "', '" + 
					$(this).find('#obj_itemQuan').val() + "')");
		}
	});
	
	clearList();
}

function clearList() {
	$('.orderDetail').each(function() {
		if($(this).index() == 1) {
			$(this).find('[type=text],[type=hidden]').each(function() {
				$(this).val("");
			});
			$(this).find('[type=checkbox]').prop('checked',false);
			return true;
		}
		$(this).remove();
	});
	
	m_ListLen = 0;
	calcOrderTotal();
}

function showOrderHistory() {
	window.open('orderHistory.jsp',"","width=1280,height=600");
}

function showAdminPage() {
	window.open('AdminMain.jsp',"","width=500,height=600");
}

function showItemSearch() {
	window.open('itemSearch.jsp',"","width=400,height=300");
}

function logout() {
	document.location.href = 'login.jsp';
}

</script>
<table width="80%" height="597" border="0" class="noborder">
  <tr>
    <th colspan="2" valign="top" scope="col">
    <table width="100%" height="569" border="0">
      <tr valign=top>
        <td width="69%" height="381">
        	<div class=item style="width:100%; height:400px; overflow:auto">
				<table border=0 id=divList width=100%>
					<tr align=center>
						<th>확인</th>
						<th>품명</th>
						<th>수량</th>
						<th>가격</th>
					</tr>
					<tr class=orderDetail>
						<td><input type=checkbox id=obj_itemChk name=obj_itemChk readonly></td>
						<td><input type=text id=obj_itemName name=obj_itemName readonly></td>
						<td><input type=text id=obj_itemQuan name=obj_itemQuan readonly style='text-align:right'> 개</td>
						<td><input type=text id=obj_itemTotal name=obj_itemTotal readonly  style='text-align:right'> 원</td>
						<input type=hidden id=obj_itemBarcode name=obj_itemBarcode>
					</tr>
				</table>
			</div>
        </td>
        <td width="31%">
        <div class=others style="width:100%; height:400px; overflow:auto">
        	<table width="100%" border="0">
			  <tr>
			    <td>일반</td>
			  </tr>
			  <tr>
			    <td>
			    <table width=100% id=divNormal border="0">
			    <tr>
				    <th>확인</th>
				    <th>이름</th>
				    <th>가격</th>
				</tr>
				<tr class=othersNormalDetail>
					<td><input type=radio id=obj_othersNormalSelect name=obj_othersNormalSelect></td>
					<td><span id=obj_othersNormalNameSpan name=obj_othersNormalNameSpan></span></td>
					<td><span id=obj_othersNormalPriceSpan name=obj_othersNormalPriceSpan></span></td>
					<input type=hidden id=obj_othersNormalBarcode name=obj_othersNormalBarcode>
				</tr>
			    </table>
			    </td>
			  </tr>
			  <tr><td>
			  		　
			  </td></tr>
			  <tr>
			  <td>쓰레기봉투</td>
			  </tr>
			  <tr>
			  <td>
			  	<table width=100% id=divTrash border="0">
			    <tr>
				    <th>확인</th>
				    <th>이름</th>
				    <th>가격</th>
				</tr>
				<tr class=othersTrashDetail>
					<td><input type=radio id=obj_othersTrashSelect name=obj_othersTrashSelect></td>
					<td><span id=obj_othersTrashNameSpan name=obj_othersTrashNameSpan></span></td>
					<td><span id=obj_othersTrashPriceSpan name=obj_othersTrashPriceSpan></span></td>
					<input type=hidden id=obj_othersTrashBarcode name=obj_othersTrashBarcode>
				</tr>
			    </table>
			    </td>
			    </tr>
			  
			</table>
        </div>
      </td>
      </tr>
      <tr>
        <td valign=top align=center colspan=1>	
	        <table border=0>
			<tr>
				<td>
				<table border=0>
					<tr>
						<td>상품코드 : 
						<td><input type=text id=obj_viewBarcode name=obj_viewBarcode onkeydown="javascript:if(event.keyCode==13){addList(this.value); this.value='';}" style="border:1px;background-color:White;">
					</tr>
					<tr>
						<td>상품명 : 
						<td><input type=text id=obj_viewName name=obj_viewName disabled>
					</tr>
					<tr>
						<td>판매단가 :
						<td><input type=text id=obj_viewPrice name=obj_viewPrice disabled>
					</tr>
					<tr>
						<td>총 금액 : 
						<td><font size=10><span id=obj_viewTotalSpan name=obj_viewTotalSpan>0</span> 원</font>
						<input type=hidden id=obj_viewTotal name=obj_viewTotal value=0 disabled>
					</tr>
					<tr>
						<td colspan=2 align=center><input type=button onclick="confirmOrder()" value=계산>
					</tr>
				</table>
				</td>
			</tr>
			</table>
					<td valign=top >
					<table width=100% border=0  class=noborder2>
					<tr>
			        <td valign=top><input type=image onclick="javascript:showItemSearch()" src=searchproduct.png width=119.25 height=70.875></td>
			        <td valign=top><input type=image onclick="javascript:showOrderHistory()" src=orderhistory.png width=119.25 height=70.875></td></tr>
			        <tr>
			        <td valign=top><input type=image onclick="javascript:showAdminPage()" src=adminpage.png width=119.25 height=70.875></td>
			        <td valign=top><input type=image onclick="javascript:logout()" src=Logout.png width=111.375 height=70.575></td></tr>
			        </table>
			    </td>
			</td>
		</td>
      </tr>
    </table>
    </th>
  </tr>
</table>

</body>
</html>