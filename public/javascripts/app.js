//JAVASCRIPT CODE GOES HERE

$('document').ready(() => {
  let signOut = $(".top-bar-section li a[href='/sign_out']");
  let signIn = $(".top-bar-section li a[href='/auth/github']");
  let flash = $(".flash");
  let meetupBlock = $(".meetup-block");

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

  meetupBlock.on('click', (event) => {
    event.preventDefault();
    let meetupHTML = $(event.delegateTarget.innerHTML);
    let currentMeetup = meetupHTML[0].innerHTML;

    document.location.href = `/meetups/show/${currentMeetup}`;
  });
});
