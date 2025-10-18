return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  init_options = {
    enabledFeatures = {
      "codeActions",
      "codeLens",
      "completion",
      "definition",
      "diagnostics",
      -- "documentHighlights",
      "documentLink",
      "documentSymbols",
      "foldingRanges",
      "formatting",
      "hover",
      "inlayHint",
      "onTypeFormatting",
      "selectionRanges",
      -- "semanticHighlighting",
      "signatureHelp",
      "typeHierarchy",
      "workspaceSymbol",
    },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
  root_markers = { "Gemfile", ".git" },
}
