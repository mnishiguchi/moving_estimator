# moving_items/new, moving_items/edit

class @Namespace.MovingItems

  constructor: ->
    # console.log "Namespace.MovingItems was called"

    setVolume = (volume) -> $("#moving_item_volume").val(volume)
    setSlider = (volume) -> $("#volume_slider").val(volume)

    # Slider

    document.getElementById('volume_slider').addEventListener 'change', ->
      setVolume(document.getElementById('volume_slider').value)

    # AutoComplete

    $('#moving_item_name').autocomplete
      source: Object.keys( $('#suggestions').data('items') )
      select: (e, ui) =>
        itemVolume = $('#suggestions').data('items')[ui.item.value]
        setVolume(itemVolume)
        setSlider(itemVolume)

    $('#moving_item_room').autocomplete
      source: $('#suggestions').data('rooms')

    $('#moving_item_category').autocomplete
      source: $('#suggestions').data('categories')
