module.exports =
  activate: (state) ->
    atom.workspaceView.command "ctrl-dir-scroll:scroll-up", => @scrollUp()
    atom.workspaceView.command "ctrl-dir-scroll:scroll-down", => @scrollDown()

  scrollUp: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    #editor.setScrollTop(editor.getScrollTop() - editor.getLineHeightInPixels())
    editor.setScrollTop(editor.getScrollTop() - 20)
    #editor.insertText('' + editor.getCursorScreenRow() + "\n")
    #editor.insertText('' + editor.getRowsPerPage())
    #if editor.getCursor() #getCursorScreenRow #getLastScreenRow
    editor.moveCursorUp(1)

  scrollDown: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    #editor.setScrollTop(editor.getScrollTop() + editor.getLineHeightInPixels())
    editor.setScrollTop(editor.getScrollTop() + 20)
    editor.moveCursorDown(1)
