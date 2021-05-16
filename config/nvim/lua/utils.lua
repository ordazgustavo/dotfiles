local function map(mode, lhs, rhs, ops)
  ops = ops or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, ops)
end

return {map = map}
