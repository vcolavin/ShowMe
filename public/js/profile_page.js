$(document).ready(function() {
  $('.create-artist-form').submit(function(event) {
    event.preventDefault()
    var formData = $(this).serializeArray()

    $.ajax({
      type: "POST",
      url:  "/artists",
      data: formData
    }).done(function(data) {
      $(".artist-list").append("<li>" + data + "</li>")
    })
  })


  $('.delete-artist-form').submit(function(event) {
    event.preventDefault()
    var formData = $(this).serializeArray()

    $.ajax({
      type: "DELETE",
      url: "/artists/" + formData[0].value
    }).done(function(data) {
      $("#" + formData[0].value).remove()
    })
  })
})
