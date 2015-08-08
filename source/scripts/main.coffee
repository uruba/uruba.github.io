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

jQuery ($) ->
  $(document).ready ->
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
