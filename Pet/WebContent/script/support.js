function check() {

var support = document.getElementsByName('supportType');
var a = null;

for(var i=0; i<support.length; i++) {
	if(support[i].checked==true){
		a = support[i].value;
	}
}



 var ychk = false;
 var yearCheck = document.getElementsByName("yearCheck");
        for(var i=0;i<yearCheck.length;i++){
            if(yearCheck[i].checked == true) {
                ychk = true;
                break;
            }
        }


if(a!='year') {
	if(ychk==true) {
		document.getElementById('message').textContent='년 단위 정기후원 유형을 선택 후 선택해주세요';
		document.getElementById('message').style.color='red';
			for(var i=0;i<yearCheck.length;i++){
            	yearCheck[i].checked=false;
   			 }
		return false;
	} else {
		document.getElementById('message').textContent='';
	}
}
if(a=='year') {
	document.getElementById('message').textContent='';
	if(chk==true) {
	document.getElementById('message').textContent='';
	return false;
	}
}



}





