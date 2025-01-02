local options = {
  ensure_installed = {
    "vim", "lua", "vimdoc",
    "html", "css"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { 'go' },
  },
}

return options
