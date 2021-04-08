/**
 * 
 */

var check2 = function() {
	var pass = document.getElementById('pass').value;
	var check = 0;
	
    if(/^[a-zA-Z0-9!@#]{8,16}$/g.test(pass)){
		check += /[A-Z]/.test(pass)?1:0;
		check += /[a-z]/.test(pass)?1:0;
		check += /[0-9]/.test(pass)?1:0;
		check += /[!@#]/.test(pass)?1:0;
		if(check >=3) {
		document.getElementById('passCheck').style.color = 'green';
        document.getElementById('passCheck').innerHTML = '안전';
			
		} else if(check ==2) {
			document.getElementById('passCheck').style.color = 'orange';
			document.getElementById('passCheck').innerHTML = '보통';
		} else {
			document.getElementById('passCheck').style.color = 'red';
			document.getElementById('passCheck').innerHTML = '사용불가';
		}
    } else {
	document.getElementById('passCheck').style.color = 'red';
	document.getElementById('passCheck').innerHTML = '영문 대소문자, 숫자, 특수문자(!,@,#) 중 2가지 이상 포함한 8~16자리 입력';
	
	}

}