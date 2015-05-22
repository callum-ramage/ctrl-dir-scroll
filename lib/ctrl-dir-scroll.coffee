module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-up", => @scrollUp()
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-down", => @scrollDown()

  scrollUp: ->
    editor = atom.workspace.getActiveTextEditor()
    if (editor)
      # editor.getVisibleRowRange()[0] ignores the blank line on the end which causes cursor correction to behave in an
      # undesirable manner.
      calculatedLastRow = Math.ceil(editor.getScrollBottom() / editor.getLineHeightInPixels()) - 1

      # Check if the cursor is beyond the end of the page. If it is then move it up one line
      # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
      while ((editor.getCursorScreenPosition().row + 2) >= calculatedLastRow)
        editor.moveUp(1)

      # Scroll the editor by one lines worth of pixels
      editor.setScrollTop(editor.getScrollTop() - editor.getLineHeightInPixels())

  scrollDown: ->
    editor = atom.workspace.getActiveTextEditor()
    if (editor)
      # Check if the cursor is beyond the end of the page. If it is then move it up one line
      # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
      prevRow = editor.getCursorScreenPosition().row - 1
      while (((editor.getCursorScreenPosition().row - 2) <= editor.getVisibleRowRange()[0]) && (editor.getCursorScreenPosition().row != prevRow))
        prevRow = editor.getCursorScreenPosition().row
        editor.moveDown(1)

      # Scroll the editor by one lines worth of pixels
      editor.setScrollTop(editor.getScrollTop() + editor.getLineHeightInPixels())
