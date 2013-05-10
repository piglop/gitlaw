# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(".affix-action-bar").each ->
    bar = $(this)
    
    setupAffix = ->
      bar.css
        width: bar.width()
      .affix
        offset: bar.position()
    
    $(window).resize ->
      if bar.hasClass("affix")
        wasAffix = true
        bar.removeClass("affix")
        
      bar.css
        width: "auto"
      
      setupAffix()
        
      bar.addClass("affix") if wasAffix
