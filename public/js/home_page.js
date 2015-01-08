$(document).ready(function() {
  navigator.geolocation.getCurrentPosition( function(position) {
    $("#latitude-field").val(position.coords.latitude)
    $("#longitude-field").val(position.coords.longitude)
  });
});
