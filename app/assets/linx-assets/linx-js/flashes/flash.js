jQuery(document).ready(function($) {
	setTimeout(function(){
		$('#flashes').fadeOut('1000', function() {
			$(this).remove();
		});
	}, 7000)
});