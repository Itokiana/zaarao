function getOptions(question_id) {
	$.ajax({
		url: '/options',
		type: 'GET',
		dataType: 'script',
		data: {question_id: question_id}
	});
}

function createOption(question_id, name) {
	$auth_token = $(`input[name="authenticity_token"]`).val();
	$.ajax({
		url: '/options',
		type: 'POST',
		dataType: 'script',
		data: {
			authenticity_token: $auth_token,
			'option[question_id]': question_id,
			'option[name]': name
		}
	});
}