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

  $(".diff-group.same").css("cursor", "pointer").click ->
    group = $(this)
    lines = group.find(".lines")
    lineCount = group.find(".line-count")
    if lines.is(":hidden")
      lines.slideDown()
      lineCount.slideUp()
    else
      lines.slideUp()
      lineCount.slideDown()
  
  $(document).on "input change", "#text_title", ->
    input = $(this)
    slugInput = input.closest("form").find("#text_slug")
    unless slugInput.hasClass("user-changed")
      slugInput.val(URLify(input.val()))

  $(document).on "input change", "#text_slug", ->
    $(this).addClass("user-changed")