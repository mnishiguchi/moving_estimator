setSliderVal = ->
  sliderVal = document.getElementById('slider').value
  $("#slider_value").val(sliderVal)

jQuery ->

  # Slider
  setSliderVal()
  document.getElementById('slider').addEventListener 'change', ->
    setSliderVal()

  # AutoComplete
  $('#moving_item_name').autocomplete
    source: $('#suggestions').data('items')

  $('#moving_item_room').autocomplete
    source: $('#suggestions').data('rooms')

  $('#moving_item_category').autocomplete
    source: $('#suggestions').data('categories')
