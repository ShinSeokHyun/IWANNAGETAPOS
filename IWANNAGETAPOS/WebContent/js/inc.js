var m_ListLen = 0;
var m_ListData;
var data = new Array();

function number_fomrat(str){
    str = str + "";
    if(str == "" || /[^0-9,]/.test(str)) return str;
    str = str.replace(/,/g, "");
    for(var i=0; i<parseInt(str.length/3, 10); i++){
        str = str.replace(/([0-9])([0-9]{3})(,|$)/, "$1,$2$3");
    }
    return str;
}

function saveList() {
	m_ListData = [];
	
	for(var i = 0; i < m_ListLen; i++) {
		m_ListData[i] = [];
		m_ListData[i].push($('[name=obj_itemChk]')[i].checked);
		m_ListData[i].push($('[name=obj_itemName]')[i].value);
		m_ListData[i].push($('[name=obj_itemQuan]')[i].value);
		m_ListData[i].push($('[name=obj_itemTotal]')[i].value);
		m_ListData[i].push($('[name=obj_itemBarcode]')[i].value);
	}
}

function calcOrderTotal() {
	var orderTotal = 0;
	
	$('.orderDetail').each(function() {
		if($(this).find('#obj_itemChk').is(':checked') == true) {
			orderTotal += $(this).find('#obj_itemTotal').val()*1;
		}
	});
	
	$('#obj_viewTotal').val(orderTotal);
	$('#obj_viewTotalSpan').html(orderTotal);
}

function calcItemTotal(objOrderDetail) {
	var itemOldQuantity = objOrderDetail.find('#obj_itemQuan');
	var itemOldTotal = objOrderDetail.find('#obj_itemTotal');
	
	itemOldTotal.val(itemOldTotal.val()*1/itemOldQuantity.val()*1 + itemOldTotal.val()*1);
	itemOldQuantity.val(itemOldQuantity.val()*1 + 1);
}

function init() {
	loadOthers(1);
	loadOthers(2);
}

function addList(itemBarcode) {
	var defClone = $('.orderDetail:eq(0)');
	var isExist = false;
	var queryResult;
	var itemName;
	var itemPrice;

	$('.orderDetail').each(function() {
		if(itemBarcode == $(this).find('#obj_itemBarcode').val()) {
			calcItemTotal($(this));
			isExist = true;
		}
	});
	
	if(!isExist) { 
		queryResult = sqlQuery("SELECT name, price FROM item WHERE barcode='" + itemBarcode + "'");
		if(queryResult.Count == 0) {
			alert("등록되지 않은 상품입니다"); 
			return;
		}
		
		itemName = queryResult.Data[0].c0;
		itemPrice = queryResult.Data[0].c1;
		
		$('#obj_viewName').val(itemName);
		$('#obj_viewPrice').val(itemPrice);
		
		if(m_ListLen != 0) {
			$('#divList').append(defClone = defClone.clone());
		}
		
		defClone.find('#obj_itemChk').prop("checked",true);
		defClone.find('#obj_itemName').val(itemName);
		defClone.find('#obj_itemQuan').val(1);
		defClone.find('#obj_itemTotal').val(itemPrice);
		defClone.find('#obj_itemBarcode').val(itemBarcode);
		
		saveList();
		m_ListLen++;
	}
	
	calcOrderTotal();
}

function loadOthers(type) {
	var typeStr = (type == 1) ? "Normal" : "Trash"; 
	var defClone = $('.others' + typeStr + 'Detail:eq(0)');
	
	queryResult = sqlQuery("SELECT barcode, name, price FROM item WHERE type='" + type + "'");
	
	for(var i = 0; i < queryResult.Count; i++) {
		if(i != 0) $('#div' + typeStr).append(defClone = defClone.clone());
		
		defClone.find('#obj_others' + typeStr + 'Barcode').val(queryResult.Data[i].c0);
		defClone.find('#obj_others' + typeStr + 'NameSpan').html(queryResult.Data[i].c1);
		defClone.find('#obj_others' + typeStr + 'PriceSpan').html(queryResult.Data[i].c2);		
		
		defClone.find('#obj_others' + typeStr + 'Select').on('click', function() {
			addList($('.others').find('[type=hidden]').eq(
					$('.others').find('[type=radio]').index(this)).val());
		});
	}
}
