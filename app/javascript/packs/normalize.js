jQuery(document).ready(function($) {
    $(`body`).on('keyup keydown', 'body', function(event) {
        event.preventDefault();
    });
});