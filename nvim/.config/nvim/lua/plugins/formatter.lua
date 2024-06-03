return {
	"mhartington/formatter.nvim",
	lua = {
      -- sytlua
      function()
        return {
          exe = "stylua",
          args = {
            "--config-path "
              .. os.getenv "XDG_CONFIG_HOME"
              .. "/stylua/stylua.toml",
            "-",
          },
          stdin = true,
        }
      end,
    },
}
