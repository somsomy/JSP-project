/**
 * 
 */


 var check = function() {
		
	 if(document.getElementById('pass').value=='') {
		 document.getElementById('message').style.color = 'red';
		 document.getElementById('message').innerHTML = '비밀번호를 입력해주세요';
		 
	 } else if (document.getElementById('pass').value ==

	    document.getElementById('confirmPassword').value) {

	    document.getElementById('message').style.color = 'green';

	    document.getElementById('message').innerHTML = '일치합니다';

	  }
	  else {

	    document.getElementById('message').style.color = 'red';

	    document.getElementById('message').innerHTML = '일치하지 않습니다';

	  }

	}
