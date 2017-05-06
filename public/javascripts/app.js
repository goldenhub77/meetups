let today = new Date();

$('#date-time-form input').attr('type', 'text');
$('#date-time-form .time').timepicker({
        'showDuration': true,
        'timeFormat': 'g:ia',
        'step': 15
    });

$('#date-time-form .date').datepicker({
        'format': 'yyyy-m-d',
        'autoclose': true,
        'startDate': today,
        'disableTextInput': true
    });
// initializes date/time fields to todays date and time
// let tomorrow = new Date();
// new Date(tomorrow.setDate(today.getDate() + 1));
//
// $('#date-time-form .date:first').datepicker('setDate', today);
// $('#date-time-form .time').timepicker('setTime', today);
// $('#date-time-form .date:last').datepicker('setDate', tomorrow);

// initialize datepair
$('#date-time-form').datepair({
});

$(document).foundation();

$('document').ready(() => {

  $('#meetupDesc').on('focus keydown keyup', (event) => {
    let max = 400;
    let len = $('#meetupDesc').val().length;
    let char = max - len;
    $('#charNum').css('visibility', 'visible');
    $('#charNum').text(char);
      if (event.keyCode === 8) {

      }else if (char <= 0 || event.keyCode === 13) {
        event.preventDefault();
      }
    });

  $('#meetupDesc').on('blur', () => {
    $('#charNum').css('visibility', 'hidden');
  });

  let signOut = $(".top-bar-section li a[href='/sign_out']");
  let signIn = $(".top-bar-section li a[href='/auth/github']");
  let flash = $(".flash");

  if (signIn.length === 1) {
    if (flash.length === 1) {
      flash.delay(2000).fadeOut();
    }
  }else if (signOut.length === 1) {
    if (flash.length === 1) {
      flash.delay(3000).fadeOut();
      signOut.click((event) => {
        event.preventDefault();

        flash.delay(3000).fadeOut(() => {

          document.location.href = '/sign_out';
        });
      });
    }
  }
});
