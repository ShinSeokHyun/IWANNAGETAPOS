<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="session.jsp">
		<jsp:param name="isadmin" value="1"/>
	</jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class=divHeader>
	홈 > 관리자페이지
</div>
<div class=divPageName>
	관리자페이지
</div>


<table width="80%" height="597" border="0">
  <tr>
    <th colspan="2" valign="top" scope="col"><table width="100%" height="275" border="0">
      <tr>
        <td>상품 관리</td>
        <td>계정관리</td>
      </tr>
      <tr><td><input type=image onclick="javascript:window.open('itemModify.jsp','','width=400,height=400');" src=ItemModify.png width=148 height=98>
			 <td><input type=image onclick="javascript:window.open('AccountInsert.jsp','','width=400,height=400');" src=AccountAdd.png width=148 height=98>
        <tr><td><input type=image onclick="javascript:window.open('itemInsert.jsp','','width=400,height=400');" src=ItemAdd.png width=148 height=98>
        <td><input type=image onclick="javascript:window.open('AccountModify.jsp','','width=400,height=400');" src=AccountModify.png width=148 height=98></tr>
    
    </table></th>
  </tr>
</table>
</body>
</html>