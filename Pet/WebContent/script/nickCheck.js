/**
 * 
 */

var check4 = function() {
	var nick = document.getElementById('nick').value;
	var nickCheck = 0;
	
 	if(/^[A-Za-z0-9가-힣]{1,10}$/g.test(nick)) {
			nickCheck += /[A-Z]/.test(nick)?1:0;
			nickCheck += /[a-z]/.test(nick)?1:0;
			nickCheck += /[0-9]/.test(nick)?1:0;
			nickCheck += /[가-힣]/.test(nick)?1:0;
				if(nickCheck >=1) {
					document.getElementById('nickCheck').style.color = 'green';
        			document.getElementById('nickCheck').innerHTML = '중복확인 해주세요';
				} else {
					document.getElementById('nickCheck').style.color = 'red';
					document.getElementById('nickCheck').innerHTML = '영문 대소문자, 숫자, 한글(자음 또는 모음만 사용불가) 포함 10자리 이하 사용 가능';
				}
	
	} else {
			document.getElementById('nickCheck').style.color = 'red';
			document.getElementById('nickCheck').innerHTML = '영문 대소문자, 숫자, 한글(자음 또는 모음만 사용불가) 포함 10자리 이하 사용 가능';
	}

}