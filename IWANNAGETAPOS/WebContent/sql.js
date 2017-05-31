function sqlQuery(sQuery) {
	var xhr = new XMLHttpRequest();
	
	xhr.open("post", "dbControllerJSON.jsp", false);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhr.send("q=" + sQuery);
	
	if(sQuery.indexOf('SELECT') != -1) 
		return eval("(" + xhr.responseText + ")");
	else 
		return;
}