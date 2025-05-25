return {
  ft = 'rust',
  mappings = {
    { 'o', group = 'open' },
    {
      'oc',
      '<Cmd>RustLsp openCargo<Cr>',
      desc = 'Open Cargo.toml',
    },
    {
      'od',
      '<Cmd>RustLsp openDocs<Cr>',
      desc = 'Open on docs.rs',
    },
    {
      'm',
      '<Cmd>RustLsp expandMacro<Cr>',
      desc = 'Expand macros recursively',
    },
  },
}
