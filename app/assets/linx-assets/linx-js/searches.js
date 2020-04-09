function search(model_name="", keyword="", url="/searches") {
	$.ajax({
		url: url,
		type: 'GET',
		dataType: 'script',
		data: {
			model_name: model_name,
			keyword: keyword
		}
	});
}