@isOnline = ->
  return true if navigator.onLine
  $.growl.error(title: "Offline", message: "")
  false
