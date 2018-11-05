$(document).on("turbolinks:load", function() {
  $(".UFIAddComment").on("keyup", function(event) {
    if (event.keyCode == 13 && event.shiftKey)
    {
        event.preventDefault();
    } else if(event.which == 13) {
      var id = $(this).attr('id');
      var array = id.split("-");
      var user = array[1];
      var review = array[3];
      var comment = document.getElementById(`${id}-add-comment`);
      var content = comment.textContent;
      var limit = $(`#paginate-${review}`).data("limit");
      if (content.trim() !="") {
        $.ajax({
          type: "POST",
          url: `/reviews/${review}/comments`,
          dataType: 'script',
          data: {
            user_id: user,
            review_id: review,
            content: content.trim(),
            limit: limit
          },
          success: function(res){
          },
          error: function(res) {
          }
        });
      }
      $(`#${id}-add-comment`).text("");
      $(`#${id}-add-comment`).blur();
    }
  });
});
