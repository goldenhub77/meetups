
$('#date-time-form .time').timepicker({
        'showDuration': true,
        'timeFormat': 'g:ia',
        'step': 15
    });

$('#date-time-form .date').datepicker({
        'format': 'm/d/yyyy',
        'autoclose': true,
        'disableTextInput': true
    });
//initializes date/time fields to todays date and time

// let today = new Date();
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
    let len = $(this).val().length;
    let char = max - len;
    $('#charNum').show();
    $('#charNum').text(char + ' characters left');
      if (event.keyCode === 8) {

      }else if (char <= 0) {
        event.preventDefault();
      }
    });

  $('#meetupDesc').on('blur', () => {
    $('#charNum').hide();
  });

  let signOut = $(".top-bar-section li a[href='/sign_out']");
  let signIn = $(".top-bar-section li a[href='/auth/github']");
  let flash = $(".flash");
  // flash.click(() => {
  //   flash.fadeOut();
  // });
  if (signIn.length === 1) {
    if (flash.length === 1) {
      flash.delay(2000).fadeOut();
    }
  }else if (signOut.length === 1) {
    if (flash.length === 1) {
      flash.delay(2000).fadeOut();
      signOut.click((event) => {
        event.preventDefault();

        flash.delay(2000).fadeOut(() => {

          document.location.href = '/sign_out';
        });
      });
    }
  }
});
