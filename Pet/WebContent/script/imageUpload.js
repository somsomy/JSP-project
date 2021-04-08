
function previewImage(targetObj, previewId) { 
	
	var preview = document.getElementById(previewId); 
	var ua = window.navigator.userAgent; 
	
	if (ua.indexOf("MSIE") > -1) { 
	
	targetObj.select(); 
	
	try { var src = document.selection.createRange().text;  
	var ie_preview_error = document 
	.getElementById("ie_preview_error_" + previewId); 
	
	if (ie_preview_error) { 
		preview.removeChild(ie_preview_error); 
		
	} 
		
	var img = document.getElementById(previewId); 
	
	img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='scale')"; 
	
	} catch (e) { 
		if (!document.getElementById("ie_preview_error_" + previewId)) { 
			
			var info = document.createElement("<p>"); 
			info.id = "ie_preview_error_" + previewId; 
			info.innerHTML = "a"; preview.insertBefore(info, null); 
			
		} } } else {
			var files = targetObj.files; 
			
			for ( var i = 0; i < files.length; i++) { 
				var file = files[i]; 
				
				var imageType = /image.*/; 
				if (!file.type.match(imageType)) 
					continue; 
				var prevImg = document.getElementById("prev_" + previewId); 
				
				if (prevImg) { 
					preview.removeChild(prevImg); 
				} 
				
				var img = document.createElement("img"); 
				img.id = "prev_" + previewId; 
				img.classList.add("obj"); 
				img.file = file; img.style.width = '200px'; 
				img.style.height = '200px';
				
				 preview.appendChild(img); 
			
			if (window.FileReader) {  
				var reader = new FileReader(); 
				reader.onloadend = (function(aImg) { 
					return function(e) {
						 aImg.src = e.target.result; };
					
					 })(img); 
				reader.readAsDataURL(file); 
				
			} else { 
				if (!document.getElementById("sfr_preview_error_" + previewId)) { 
					var info = document.createElement("p"); 
					info.id = "sfr_preview_error_" + previewId; 
					info.innerHTML = "not supported FileReader"; 
					preview.insertBefore(info, null); 
				} 
			} 
		} 
	} 
	
	
	
}










