local m = Utils.map

m.map('vo', 'ae', [[:<C-u>silent! normal! ggVG<Cr>]], { desc = 'Entire buffer' })
m.map('vo', 'il', [[:<C-u>silent! normal! ^vg_<Cr>]], { desc = 'Line' })
