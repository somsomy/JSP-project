function type() {
	
	var accNum = document.getElementById('accNum');
	var accName = document.getElementById('accName');
	
	
	var payment = document.getElementsByName('payment');
	var a = null;

	for(var i=0; i<payment.length; i++) {
		if(payment[i].checked==true){
			a = payment[i].value;
		}
	}
	
	if(a=='account') {
		accNum.innerHTML='계좌번호';
		accName.innerHTML='예금주명';
	} else if(a=='creditCard') {
		accNum.innerHTML='카드번호';
		accName.innerHTML='카드주명';
	}
	
}