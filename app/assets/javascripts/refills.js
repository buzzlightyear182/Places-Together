// $('.js-accordion-trigger').bind('click', function(){
//   jQuery(this).parent().find('.submenu').slideToggle('fast');
//  // apply the toggle to the ul
//   jQuery(this).parent().toggleClass('is-expanded');
//   event.preventDefault();
// });
$(document).ready(function() {
  var menu = $('#navigation-menu');
  var menuToggle = $('#js-mobile-menu');
  var signUp = $('.sign-up');

  $(menuToggle).on('click', function(e) {
    e.preventDefault();
    menu.slideToggle(function(){
      if(menu.is(':hidden')) {
        menu.removeAttr('style');
      }
    });
  });
