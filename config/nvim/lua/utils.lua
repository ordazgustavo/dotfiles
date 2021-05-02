local u = {}

function u.remap(mode, lhs, rhs, ops)
	ops = ops or { noremap = true, silent = true }
	vim.api.nvim_set_keymap(mode, lhs, rhs, ops)
end

return u
