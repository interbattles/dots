return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },

  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        css = { 'prettier' },
        html = { 'prettier' },
        jsonc = { 'prettier' },
        json = { 'prettier' },
      },
      ['_'] = { 'trim_whitespace' },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    })

    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
