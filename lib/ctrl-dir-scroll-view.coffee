{View} = require 'atom'

module.exports =
class CtrlDirScrollView extends View
  @content: ->
    @div class: 'ctrl-dir-scroll overlay from-top', =>
      @div "The CtrlDirScroll package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "ctrl-dir-scroll:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "CtrlDirScrollView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
