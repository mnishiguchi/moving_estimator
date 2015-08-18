# For new and edit forms of moving items

Namespace.Movings = ->
  console.log "Namespace.Movings was called"
  # Countries

  $from = $('#moving_country_from')
  $from.change ->
    switch $from.children("option").filter(":selected").text()
      when "United States" then params = { source: $('#moving_suggestions').data('usstates') }
      else                      params = { source: [] }
    $('#moving_state_from').autocomplete(params)

  $to = $('#moving_country_to')
  $to.change ->
    switch $to.children("option").filter(":selected").text()
      when "United States" then params = { source: $('#moving_suggestions').data('usstates') }
      else                      params = { source: [] }
    $('#moving_state_to').autocomplete(params)
