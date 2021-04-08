function setSelect(){
	var target = document.getElementById('customSelect');
	var textBox = document.getElementById('reward');

	if(target.options[target.selectedIndex].text=='직접입력') {
		textBox.value = '';
	} else {
		textBox.value = target.options[target.selectedIndex].text;
	}
	
	
}
