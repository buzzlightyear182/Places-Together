// show the html5 input type range values
function show_ranges() {
  // selector and classname on the range value
  var selector = "input[type=range]",
    class_name = "range-value";

  // get the range values with jquery
  var ranges = $(selector);

  // check for support for the html5 range input and then show the value from the range
  if (ranges[0] && ranges[0].type == "range") {
    for (k in ranges) {
      // show the value on init
      show_value_from_range(ranges[k]);
      // change the value on change
      ranges[k].onchange = function(e) {
        show_value_from_range(this);
      };
    }
  }
  // show the values in the label
  function show_value_from_range(el) {
    //  get the elements label
    var label = $('label[for='+el.id+']');
    // check if the element exists - if it does: remove it
    if ($("span."+class_name, label).is("*") != false) {
      $("span."+class_name, label).remove();
    }
    // create the range element ...
    var range_val_el = $('<span class="'+class_name+'">'+el.value+'</span>');
    // ... and append it to the label
    range_val_el.appendTo(label);
  };
};
