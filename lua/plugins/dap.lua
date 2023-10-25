return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")
    dap.adapters.firefox = {
      type = "executable",
      command = "node",
      args = { "~/vscode-firefox-debug/dist/adapter.bundle.js" },
      options = {
        initialize_timeout_sec = 10,
      },
    }

    for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            name = "Debug with Firefox",
            type = "firefox",
            request = "launch",
            reAttach = true,
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            firefoxExecutable = "/usr/bin/firefox",
          },
        }
      end
    end
  end,
}
