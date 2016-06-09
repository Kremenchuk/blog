// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(function($) {

    $(".deleteAction").click( function() {
        var current_posts_tr = $(this).parents('tr')[0];
        if(confirm("Delete this post?")){
            $.ajax({
                url: '/posts/' + $(current_posts_tr).attr('data_posts_id'),
                type: 'POST',
                data: { _method: 'DELETE' },
                success: function(result) {$(current_posts_tr).fadeOut(200);
                    console.log(result);
                }
            });
        };
    });
});