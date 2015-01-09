$(document).ready(function() {
  $('.create-artist-form').submit(function(event) {
    event.preventDefault()
    var formData = $(this).serializeArray()

    $.ajax({
      type: "POST",
      url:  "/artists",
      data: formData,
      dataType: "JSON"
    }).done(function(data) {
      $(".artist-list").append("<li id='" + data.id + "'" + ">" + data.name + "<form class='delete-artist-form'> <input type='hidden' name='artist_id' value='" + data.id + "'> <input type='submit' value='delete'> </form> </li>")
    })
  })


  $('ul').on('submit', 'li .delete-artist-form', function(event) {
    event.preventDefault()
    var formData = $(this).serializeArray()

    $.ajax({
      type: "DELETE",
      url: "/artists/" + formData[0].value
    }).done(function(data) {
      $("#" + formData[0].value).remove()
    })
  })

  navigator.geolocation.getCurrentPosition( function(position) {
    $("#latitude-field").val(position.coords.latitude)
    $("#longitude-field").val(position.coords.longitude)
  });
})
