window.initalizeFavoriteMarking = ->
  $('.marking-favorite').bind 'ajax:success', ->
    $this = $(this)
    $span = $this.find('span.favorite')
    if $span.hasClass('text-success')
      $span.removeClass('text-success').addClass 'text-muted'
    else
      $span.removeClass('text-muted').addClass 'text-success'
    return


$(document).ready initalizeFavoriteMarking
