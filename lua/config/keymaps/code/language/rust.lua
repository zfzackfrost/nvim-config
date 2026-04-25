local function select_target()
  local targets = {
    ['Default'] = '',
    ['WebASM'] = 'wasm32-unknown-unknown',
  }
  local function apply_target(item)
    if item == nil then
      return
    end
    vim.cmd(("RustAnalyzer config { cargo = { target = '%s' } }"):format(targets[item]))
  end
  local labels = vim.tbl_keys(targets)
  vim.ui.select(labels, {
    prompt = 'rust-analyzer target',
  }, apply_target)
end

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
    {
      't',
      select_target,
      desc = 'Select LSP target',
    },
  },
}
