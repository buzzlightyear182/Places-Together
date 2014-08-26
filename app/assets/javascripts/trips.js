// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {
    var urlJsonBuilder = location.pathname;
    urlJsonBuilder = urlJsonBuilder + '.json';
    // page is now ready, initialize the calendar...
    $('#calendar').fullCalendar({
        header: {
              left: 'prev,next today',
              center: 'title',
              right: 'month,agendaWeek,agendaDay'
            },
        allDayDefault: false,
        defaultView: 'agendaDay',
        height: 450,
        slotMinutes: 30,
        selectable: true,
        timeFormat: 'H(:mm)',
        select: function (start, end) {

          $('#side-event').addClass('sidebar-left-active').removeClass('sr-only');

          var startDay = start.getDate();
          var startMonth = start.getMonth()+1;
          var startYear = start.getFullYear();
          var startHour = start.getHours();
          if (startHour<10){
            var startHourString = '0' + startHour.toString();
          }else{;
            var startHourString = startHour;
          }
          if (startHour<9){
            var endHourString = '0' + (startHour+1).toString();
          }else{
            var endHourString = startHour+1;

          }

          $('#event_start_1i').val(startYear);
          $('#event_start_2i').val(startMonth);
          $('#event_start_3i').val(startDay);
          $('#event_start_4i').val(startHourString);
          $('#event_start_5i').val('00');

          $('#event_end_1i').val(startYear);
          $('#event_end_2i').val(startMonth);
          $('#event_end_3i').val(startDay);
          $('#event_end_4i').val(endHourString);
          $('#event_end_5i').val('00');

          $('#calendar').fullCalendar('unselect');
        },
        editable: true,
        eventSources: [{
        url: urlJsonBuilder,
        }]

    })
    $('#calendar').addClass('table-responsive');

});
var closeForm = function(){
      $('#side-event').addClass('sr-only').removeClass('sidebar-left-active');
    };
