// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(function($) {

    $(".deleteCommentAction").click( function() {
        var current_comments_tr = $(this).parents('tr')[0];
        if(confirm("Delete this comment?")){
            $.ajax({
                url: '/comments/' + $(current_comments_tr).attr('data_comments_id'),
                type: 'POST',
                data: { _method: 'DELETE' },
                success: function(result) {$(current_comments_tr).fadeOut(200);
                    console.log(result);
                }
            });
        };
    });
});