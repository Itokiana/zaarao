function submitForm(form_tag = 'form', loader = '<div class="pre-loader">Loading...</div>') {
    $forms = $(form_tag), $loader = loader;
    $forms.submit(function(event) {
        $form = $(this);
    	$form.addClass('disabled');
    	$initialContent = $form.find(`[type=submit]`).html();

        $form.find(`[type=submit]`).html($loader);

    	$url = $form.attr('action');
    	
        $method = "POST";

        if ($form.find('input[name="_method"]').length != 0) {
            $method = $form.find('input[name="_method"]').val();
        }

        $charset = $form.attr('accept-charset');

    	$dataType = $form.data('remote') == true ? 'script' : 'html';

        $data = $form.serialize();

        if ($dataType == 'script') {
    	    event.preventDefault();

        	$.ajax({
                // charset: $charset,
        		// url: $url,
        		// type: $method,
        		// dataType: $dataType,
        		// data: $data
        	})
        	.done(function() {
                console.log("success");
        	})
        	.fail(function() {
        		console.log("error");
        	})
        	.always(function() {
        		$form.removeClass('disabled');
            	$form.find(`[type=submit]`).html($initialContent);
        	});
        }
    });

}