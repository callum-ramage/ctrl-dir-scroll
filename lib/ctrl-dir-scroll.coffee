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
    editorElement = atom.views.getView(editor)
    if (editor && editor.getScreenLineCount() > 1 && (editor.getScreenLineCount() > editor.rowsPerPage || editor.scrollPastEnd))
      keepCursorInView = atom.config.get 'ctrl-dir-scroll.keepCursorInView'

      # editor.getVisibleRowRange()[0] ignores the blank line on the end which causes cursor correction to behave in an
      # undesirable manner.
      calculatedLastRow = Math.ceil(editorElement.getScrollBottom() / editor.getLineHeightInPixels()) - Math.min(amount, editor.getVisibleRowRange()[0])
      # Check if the cursor will be beyond the end of the page. If it will be then move it up the required number of lines to keep it on the page
      # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
      cursorOffset = editor.getCursorScreenPosition().row - calculatedLastRow + 2
      if keepCursorInView && (cursorOffset >= 0)
        editor.moveUp(cursorOffset + 1)

      # Scroll the editor by amount lines worth of pixels
      editorElement.setScrollTop(editorElement.getScrollTop() - editor.getLineHeightInPixels() * amount)

  scrollDown: (amount) ->
    editor = atom.workspace.getActiveTextEditor()
    editorElement = atom.views.getView(editor)
    if (editor && editor.getScreenLineCount() > 1 && (editor.getScreenLineCount() > editor.rowsPerPage || editor.scrollPastEnd))
      keepCursorInView = atom.config.get 'ctrl-dir-scroll.keepCursorInView'
      # Check if the cursor will be beyond the end of the page. If it will be then move it up the required number of lines to keep it on the page
      # The default behaviour of the editor is to keep the cursor a couple of lines within the screen. We are replicating that.
      cursorOffset = editor.getCursorScreenPosition().row - editor.getVisibleRowRange()[0] - 2
      if keepCursorInView && (cursorOffset <= amount)
        editor.moveDown(amount - cursorOffset)

      # Scroll the editor by amount lines worth of pixels
      editorElement.setScrollTop(editorElement.getScrollTop() + editor.getLineHeightInPixels() * amount)
