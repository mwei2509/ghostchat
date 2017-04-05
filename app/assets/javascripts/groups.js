$(document).ready(function() {
  submitNewMessage();
});

function submitNewMessage(){
  $('textarea#message_body').keydown(function(event) {
    if (event.keyCode == 13) {
        $('input[type=submit]').submit();
        $('#message_body').val(" ")
        return false;
     }
  });
}
