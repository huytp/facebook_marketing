(->
  $(document).on 'ready', ->
    init()
    return

  init = ->
    tabs()
    return

  tabs = ->
    $('.nav-tabs a').click ->
      $(this).tab 'show'
      return
    return

  return
).call this