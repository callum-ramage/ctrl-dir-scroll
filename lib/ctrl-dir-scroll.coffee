module.exports =
  config:
    keepCursorInView:
      type: 'boolean'
      default: true
      description: 'Keep the cursor a few lines wihin the screen'
      order: 1
    bigScrollSize:
      type: 'integer'
      default: 10
      minimum: 1
      maximum: 1000
      description: 'Number of lines to move on a "big" scroll'
      order: 2

  activate: (state) ->
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-up", =>
      @scrollUp(1)
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-up-big", =>
      @scrollUp(atom.config.get 'ctrl-dir-scroll.bigScrollSize')
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-down", =>
      @scrollDown(1)
    atom.commands.add 'atom-workspace', "ctrl-dir-scroll:scroll-down-big", =>
      @scrollDown(atom.config.get 'ctrl-dir-scroll.bigScrollSize')

  scrollUp: (amount) ->
    editor = atom.workspace.getActiveTextEditor()
    if (editor)
      keepCursorInView = atom.config.get 'ctrl-dir-scroll.keepCursorInView'
      for i in [1..amount]
        # editor.getVisibleRowRange()[0] ignores the blank line on the end which causes cursor correction to behave in an
        # undesirable manner.
        calculatedLastRow = Math.ceil(editor.getScrollBottom() / editor.getLineHeightInPixels()) - 1

        if keepCursorInView
          # Check if the cursor is beyond the end of the page. If it is then move it up one line
          # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
          while ((editor.getCursorScreenPosition().row + 2) >= calculatedLastRow)
            editor.moveUp(1)

        # Scroll the editor by one lines worth of pixels
        editor.setScrollTop(editor.getScrollTop() - editor.getLineHeightInPixels())

  scrollDown: (amount) ->
    editor = atom.workspace.getActiveTextEditor()
    if (editor)
      keepCursorInView = atom.config.get 'ctrl-dir-scroll.keepCursorInView'
      for i in [1..amount]
        if keepCursorInView
          # Check if the cursor is beyond the end of the page. If it is then move it up one line
          # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
          prevRow = editor.getCursorScreenPosition().row - 1
          while (((editor.getCursorScreenPosition().row - 2) <= editor.getVisibleRowRange()[0]) && (editor.getCursorScreenPosition().row != prevRow))
            prevRow = editor.getCursorScreenPosition().row
            editor.moveDown(1)

        # Scroll the editor by one lines worth of pixels
        editor.setScrollTop(editor.getScrollTop() + editor.getLineHeightInPixels())

