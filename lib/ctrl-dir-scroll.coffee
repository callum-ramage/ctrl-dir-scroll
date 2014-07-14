module.exports =
  activate: (state) ->
    atom.workspaceView.command "ctrl-dir-scroll:scroll-up", => @scrollUp()
    atom.workspaceView.command "ctrl-dir-scroll:scroll-down", => @scrollDown()

  scrollUp: ->
    editor = atom.workspace.getActiveEditor()
    paneView = atom.workspaceView.getActivePane()
    if (editor)
      editorView = paneView.viewForItem(editor)

      # Check if the cursor is beyond the end of the page. If it is then move it up one line
      # The last visible row is a couple before the last row you can put the cursor on. I think it may have something to do with the find dialog
      if ((editor.getCursorScreenRow() + 2) >= editorView.getLastVisibleScreenRow())
        editor.moveCursorUp(1)

      # Scroll the editor by one lines worth of pixels
      editorView.scrollTop(editorView.scrollTop() - editorView.lineHeight)

  scrollDown: ->
    editor = atom.workspace.getActiveEditor()
    paneView = atom.workspaceView.getActivePane()
    if (editor)
      editorView = paneView.viewForItem(editor)

      # Check if the cursor is beyond the end of the page. If it is then move it up one line
      # The last visible row is a couple before the last row you can put the cursor on. I think it may have something to do with the find dialog
      if ((editor.getCursorScreenRow() - 2) <= editorView.getFirstVisibleScreenRow())
        editor.moveCursorDown(1)

      # Scroll the editor by one lines worth of pixels
      editorView.scrollTop(editorView.scrollTop() + editorView.lineHeight)
