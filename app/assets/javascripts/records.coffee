window.allowForRecordDeletion = ->
  $('.delete-record').bind 'ajax:success', ->
    $(this).closest('tr').fadeOut()
    url = '/records'
    url = "#{url}?#{location.search}" if location.search? isnt ""
    successCallback = (data) ->
      $('#records').replaceWith data
      allowForRecordDeletion()
      initalizeFavoriteMarking()
    $.get url, {format: 'js'}, successCallback, 'html'
    return

$(document).ready allowForRecordDeletion
