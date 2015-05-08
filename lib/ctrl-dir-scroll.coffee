module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-up", => @scrollUp()
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-down", => @scrollDown()

  scrollUp: ->
    editor = atom.workspace.getActiveEditor()
    paneView = atom.workspaceView.getActivePaneView()
    if (editor)
      editorView = paneView.activeView

      # editorView.getLastVisibleScreenRow() ignores the blank line on the end which causes cursor correction to behave in an
      # undesirable manner.
      calculatedLastRow = Math.ceil(editorView.scrollBottom() / editorView.lineHeight) - 1

      # Check if the cursor is beyond the end of the page. If it is then move it up one line
      # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
      while ((editor.getCursorScreenRow() + 2) >= calculatedLastRow)
        editor.moveCursorUp(1)

      # Scroll the editor by one lines worth of pixels
      editorView.scrollTop(editorView.scrollTop() - editorView.lineHeight)

  scrollDown: ->
    editor = atom.workspace.getActiveEditor()
    paneView = atom.workspaceView.getActivePaneView()
    if (editor)
      editorView = paneView.activeView

      # Check if the cursor is beyond the end of the page. If it is then move it up one line
      # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
      prevRow = editor.getCursorScreenRow() - 1
      while (((editor.getCursorScreenRow() - 2) <= editorView.getFirstVisibleScreenRow()) && (editor.getCursorScreenRow() != prevRow))
        prevRow = editor.getCursorScreenRow()
        editor.moveCursorDown(1)

      # Scroll the editor by one lines worth of pixels
      editorView.scrollTop(editorView.scrollTop() + editorView.lineHeight)
