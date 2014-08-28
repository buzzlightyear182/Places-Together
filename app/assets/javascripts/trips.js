// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {
    var urlJsonBuilder = location.pathname;
    urlJsonBuilder = urlJsonBuilder + '.json';
    // page is now ready, initialize the calendar...
    $('#calendar').fullCalendar({
        header: {
              left: 'prev, today',
              center: 'title',
              // right: 'month,agendaWeek, agendaDay'
              right: 'next'
            },
        allDayDefault: false,
        defaultView: 'month',
        height: 450,
        // slotMinutes: 30,
        selectable: true,
        // timeFormat: 'H(:mm)',
        select: function (start, end) {

          $('#side-event').addClass('sidebar-left-active').removeClass('sr-only');

          var startDay = start.getDate();
          var startMonth = start.getMonth()+1;
          var startYear = start.getFullYear();
          // var startHour = start.getHours();
          // if (startHour<10){
          //   var startHourString = '0' + startHour.toString();
          // }else{;
          //   var startHourString = startHour;
          // }
          // if (startHour<9){
          //   var endHourString = '0' + (startHour+1).toString();
          // }else{
          //   var endHourString = startHour+1;

          // }

          $('#event_start_1i').val(startYear);
          $('#event_start_2i').val(startMonth);
          $('#event_start_3i').val(startDay);
          // $('#event_start_4i').val(startHourString);
          // $('#event_start_5i').val('00');

          $('#event_end_1i').val(startYear);
          $('#event_end_2i').val(startMonth);
          $('#event_end_3i').val(startDay);
          // $('#event_end_4i').val(endHourString);
          // $('#event_end_5i').val('00');

          $('#calendar').fullCalendar('unselect');
        },
        // editable: true,
        eventSources: [{
        url: urlJsonBuilder,
        }]

    })

    $('#calendar').addClass('table-responsive');

  var closeForm = function(){
      $('#side-event').addClass('sr-only').removeClass('sidebar-left-active');
  };

  $(document).ajaxComplete(function() {
  });


  $('#category').change(function(event){
    resetList();
    getActivities(event.target.value);
  })

  var getActivities = function(category){
    var request = new XMLHttpRequest();
    var url = '/filter_activities/' + category;
    request.open("GET", url, false);

    request.setRequestHeader("Accept","application/json");

    request.onload = function() {
      if (this.status === 200) {
        var response = JSON.parse(this.response);
        displayActivities(response);
      }
    };
    request.send();
  };

  function displayActivities(response) {
    for (i=0; i < response.activities.length; i++) {
    console.log(response.activities[i]);
    var activity_name = response.activities[i].activity_name;

    var list_item = document.createElement('li');

    var input = createInput(activity_name);
    var label = createLabel(activity_name);
    var image = createImage(activity_name);

    label.appendChild(image);
    list_item.appendChild(input);
    list_item.appendChild(label);

    var activity_list = document.getElementById('activity_list');
    activity_list.appendChild(list_item);
    };
  };

  function createInput(activity_name) {
    input = document.createElement('input');
    input.id = "trip_activity_" + activity_name;
    input.value = activity_name;
    input.setAttribute('type', 'radio');
    input.setAttribute('name', 'trip[activity]');
    return input;
  }

  function createLabel(activity_name) {
    label = document.createElement('label');
    label.setAttribute('for', "trip_activity_" + activity_name);
    label.textContent = activity_name;
    return label;
  }

  function createImage(activity_name){
    image = document.createElement('img');
    image.setAttribute("alt",activity_name);
    image.id = "listed "+ activity_name;
    image.setAttribute("src","/assets/" + activity_name + ".png");
    return image;
  }

  function resetList(){
    $('#activity_list li').remove();
  };

});

