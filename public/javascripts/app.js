//JAVASCRIPT CODE GOES HERE

$('document').ready(() => {
  let signOut = $(".top-bar-section li a[href='/sign_out']");
  let signIn = $(".top-bar-section li a[href='/auth/github']");
  let flash = $(".flash");

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
