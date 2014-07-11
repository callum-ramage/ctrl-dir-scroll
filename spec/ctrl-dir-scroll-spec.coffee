{WorkspaceView} = require 'atom'
CtrlDirScroll = require '../lib/ctrl-dir-scroll'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "CtrlDirScroll", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('ctrl-dir-scroll')

  describe "when the ctrl-dir-scroll:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.ctrl-dir-scroll')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'ctrl-dir-scroll:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.ctrl-dir-scroll')).toExist()
        atom.workspaceView.trigger 'ctrl-dir-scroll:toggle'
        expect(atom.workspaceView.find('.ctrl-dir-scroll')).not.toExist()
