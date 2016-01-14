# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#assignment_run_script").length > 0
    editor = ace.edit("assignment_run_script")
    editor.getSession().setMode("ace/mode/sh")
    editor.getSession().on 'change', ->
      $("#assignment_run_script").val(editor.getValue())
