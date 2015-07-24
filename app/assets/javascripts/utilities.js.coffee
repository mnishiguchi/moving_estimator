@isOnline = ->
  return true if navigator.onLine
  $.growl.error(title: "Offline", message: "")
  false

@capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)
