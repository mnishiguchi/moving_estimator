# movings/new, movings/edit

class @Namespace.Movings

  constructor: ->
    console.log "Namespace.Movings was called"

    # Countries suggestions

    $from = $('#moving_country_from')
    $from.change ->
      switch $from.children("option").filter(":selected").text()
        when "United States" then params = { source: $('#moving_suggestions').data('us-states') }
        else                      params = { source: [] }
      $('#moving_state_from').autocomplete(params)

    $to = $('#moving_country_to')
    $to.change ->
      switch $to.children("option").filter(":selected").text()
        when "United States" then params = { source: $('#moving_suggestions').data('us-states') }
        else                      params = { source: [] }
      $('#moving_state_to').autocomplete(params)
