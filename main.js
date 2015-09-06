(function() {
  var activeClass, cycleChooseMessage, detectIE, eligibleLangs, processLangs;

  eligibleLangs = [
    {
      name: "english",
      chooseMessage: "Choose a language",
      heading: "Václav's story"
    }, {
      name: "swedish",
      chooseMessage: "Välj ett språk",
      heading: "Václavs historia"
    }, {
      name: "czech",
      chooseMessage: "Vyberte jazyk",
      heading: "O mně"
    }
  ];

  activeClass = "active";

  processLangs = function(langsArray) {
    var eligibleLang, flagAppend, i, len, slidePrepend;
    flagAppend = "_flag";
    slidePrepend = "slide_";
    window.slidesClasses = [];
    for (i = 0, len = eligibleLangs.length; i < len; i++) {
      eligibleLang = eligibleLangs[i];
      window.slidesClasses.push({
        parent: eligibleLang,
        flagClass: eligibleLang.name + flagAppend,
        slideId: slidePrepend + eligibleLang.name
      });
    }
  };

  cycleChooseMessage = function(delay) {
    var chooseMessages, eligibleLang, i, len, messageElement, messagesQueue, nextMessage;
    chooseMessages = new Array();
    for (i = 0, len = eligibleLangs.length; i < len; i++) {
      eligibleLang = eligibleLangs[i];
      chooseMessages.push(eligibleLang.chooseMessage);
    }
    messagesQueue = chooseMessages.slice();
    messageElement = $(".language_chooser .choose_message div");
    nextMessage = function() {
      var nextMessageText;
      nextMessageText = messagesQueue.shift();
      messagesQueue.push(nextMessageText);
      messageElement.fadeOut({
        complete: function() {
          messageElement.text(nextMessageText).fadeIn();
        }
      });
    };
    nextMessage();
    setInterval(function() {
      nextMessage();
    }, delay);
  };

  detectIE = function() {
    var edge, msie, rv, trident, ua;
    ua = window.navigator.userAgent;
    msie = ua.indexOf('MSIE ');
    if (msie > 0) {
      return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
    }
    trident = ua.indexOf('Trident/');
    if (trident > 0) {
      rv = ua.indexOf('rv:');
      return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
    }
    edge = ua.indexOf('Edge/');
    if (edge > 0) {
      return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
    }
    return false;
  };

  jQuery(function($) {
    $(document).ready(function() {
      if (detectIE()) {
        $('head').append('<link rel="stylesheet" href="ie.css" type="text/css" />');
      }
      processLangs();
      cycleChooseMessage(4000);
    });
    $(".language_chooser > li").click(function() {
      var activisedElement, activisedElements, i, j, len, len1, ref, slideElement, slideSelector, slidesClass;
      ref = window.slidesClasses;
      for (i = 0, len = ref.length; i < len; i++) {
        slidesClass = ref[i];
        if ($(this).hasClass(slidesClass.flagClass) && !$(this).hasClass(activeClass)) {
          slideSelector = "#" + slidesClass.slideId;
          slideElement = $(slideSelector);
          activisedElements = [$(this), slideElement];
          for (j = 0, len1 = activisedElements.length; j < len1; j++) {
            activisedElement = activisedElements[j];
            activisedElement.siblings().removeClass(activeClass);
            activisedElement.addClass(activeClass);
          }
          $("h1#slide_heading").text(slidesClass.parent.heading);
          break;
        }
      }
    });
  });

}).call(this);

