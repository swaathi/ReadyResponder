jQuery ->
  $("#event_title").focus();
  $("#event_category").change ->
    temp = $("#event_category option:selected").text();
    if temp is "Training"
      $(".training-controls").show()
    else
      $(".training-controls").hide()
  $("#event_status").change ->
    status = $("#event_status option:selected").text();
    start_time = $("#event_start_time").text();
    if status is "Completed"
      $("#XXevent_start_time").hide()

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    $.fn.dataTable.tables(
      visible: true
      api: true).columns.adjust()
    return

  $('#event_start_time').change ->
    eventStartTime = $('#event_start_time').datetimepicker('getValue')
    eventEndTime = $('#event_end_time').datetimepicker('getValue')
    if (not eventEndTime?) or (eventStartTime > eventEndTime)
      $('#event_end_time').datetimepicker('setOptions', {startDate: eventStartTime})
