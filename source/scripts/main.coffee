eligibleLangs = [
  {
    name: "english",
    chooseMessage: "Choose a language",
    heading: "Václav's story"
    },
  {
    name: "swedish",
    chooseMessage: "Välj ett språk",
    heading: "Václavs historia"
    },
  {
    name: "czech",
    chooseMessage: "Vyberte jazyk",
    heading: "O mně"
    }]
activeClass = "active"

processLangs = (langsArray) ->
  flagAppend = "_flag"
  slidePrepend = "slide_"

  window.slidesClasses = []
  for eligibleLang in eligibleLangs
    window.slidesClasses.push {
      parent: eligibleLang,
      flagClass: eligibleLang.name + flagAppend,
      slideId: slidePrepend + eligibleLang.name
    }

  return

cycleChooseMessage = (delay) ->
  chooseMessages = new Array()

  for eligibleLang in eligibleLangs
    chooseMessages.push(eligibleLang.chooseMessage)

  messagesQueue = chooseMessages.slice()
  messageElement = $(".language_chooser .choose_message div")
  nextMessage = ->
    nextMessageText = messagesQueue.shift()
    messagesQueue.push(nextMessageText)

    messageElement.fadeOut({
      complete: ->
        messageElement.text(nextMessageText).fadeIn()
        return
      })
    return

  nextMessage()

  setInterval(->
    nextMessage()
    return
  , delay)

  return

detectIE = () ->
  ua = window.navigator.userAgent

  msie = ua.indexOf('MSIE ')
  if msie > 0
      # IE 10 or older => return version number
      return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10)

  trident = ua.indexOf('Trident/')
  if trident > 0
      # IE 11 => return version number
      rv = ua.indexOf('rv:');
      return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10)

  edge = ua.indexOf('Edge/')
  if edge > 0
     # IE 12 => return version number
     return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10)

  # other browser
  return false

jQuery ($) ->
  $(document).ready ->
    if detectIE()
      $('head').append('<link rel="stylesheet" href="ie.css" type="text/css" />')
    processLangs()
    cycleChooseMessage(4000)
    return

  $(".language_chooser > li").click ->
    for slidesClass in window.slidesClasses
        if $(this).hasClass(slidesClass.flagClass) && !$(this).hasClass(activeClass)
          slideSelector = "#" + slidesClass.slideId
          slideElement = $(slideSelector)

          activisedElements = [$(this), slideElement]

          for activisedElement in activisedElements
            activisedElement.siblings().removeClass(activeClass)
            activisedElement.addClass(activeClass)

          $("h1#slide_heading").text(slidesClass.parent.heading)
          break
    return

  return
