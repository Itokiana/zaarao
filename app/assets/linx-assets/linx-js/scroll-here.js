function scrollHere(where_id = '.scroll-here:first') {
	$where = $(where_id);
	$height = $where.offset().top - Number($where.attr('scroll-to'));

    $('html, body').animate({ scrollTop: $height }, 1000, function() {});
}