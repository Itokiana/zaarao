
/*====================================================*/
/* FILE /sedlex/inline_scripts/ac1b4327660055f1e37cf842b0f79f08096b13f8.js*/
/*====================================================*/
			function checkIfFormattingCorrecterNeeded() {
				
				var arguments = {
					action: 'checkIfFormattingCorrecterNeeded'
				} 
				var ajaxurl2 = "https://www.botreetechnologies.com/blog/wp-admin/admin-ajax.php" ; 
				jQuery.post(ajaxurl2, arguments, function(response) {
					// We do nothing as the process should be as silent as possible
				});    
			}
			
			// We launch the callback
			if (window.attachEvent) {window.attachEvent('onload', checkIfFormattingCorrecterNeeded);}
			else if (window.addEventListener) {window.addEventListener('load', checkIfFormattingCorrecterNeeded, false);}
			else {document.addEventListener('load', checkIfFormattingCorrecterNeeded, false);} 
						
		
