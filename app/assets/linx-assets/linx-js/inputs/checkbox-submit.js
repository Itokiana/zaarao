function checkBox(form = 'form:first', checkboxes = "[type='checkbox']", parents = "label[href]"){
	$form = form;
	$checkboxes = $form.find(checkboxes);
	$parents = $(parents);


	$checkboxes.change(function(event) {
		
		for (let i = 0; i < $parents.length; i++) {
			$parent = $parents.eq(i);
			$parent.removeClass('active');
		}
		
		$his_parent = $(this).parent();

		$parents.removeClass('active');
		
		$his_parent.addClass('active');

		$form.find('[type=submit]').click();
	});
}