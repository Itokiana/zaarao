function getQuestions() {
	$.ajax({
		url: '/questions',
		type: 'GET',
		dataType: 'script'
	});
}

function editInput(){
	$(`[data-editable="true"]`).keyup(function(event) {
		let id = $(this).attr('id'),
			url = $(this).attr('date-url');
		updateInput(id=id, url=url);
	});
}

function updateInput(id=null, url=""){
	$locale = $(`html`).attr('lang');
	$id = id, $url = url;
	$.ajax({
		url: `${$url}`,
		type: 'PATCH',
		dataType: 'script',
		data: {id: $id}
	})
	.done(function() {
		// console.log("success");
	})
	.fail(function() {
		// console.log("error");
	});
}