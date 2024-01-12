local status_ok, tmux_navigator = pcall(require, 'nvim-tmux-navigator')
if not status_ok then
  return
end
-- Force zooming out before navigating to alternative panes.
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_no_wrap = 1
