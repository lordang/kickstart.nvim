return {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  lazy = false, -- This plugin is already lazy

  config = function()
    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb'
    local this_os = vim.uv.os_uname().sysname
    local cfg = require 'rustaceanvim.config'

    -- Update this path
    -- The path is different on Windows
    if this_os:find 'Windows' then
      codelldb_path = extension_path .. 'adapter\\codelldb.exe'
      liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
    else
      -- The liblldb extension is .so for Linux and .dylib for MacOS
      liblldb_path = liblldb_path .. (this_os == 'Linux' and '.so' or '.dylib')
    end

    vim.g.rustaceanvim = function()
      return {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end

    local dap = require 'dap'

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- Change this to your path!
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
    }

    dap.configurations.rust = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
}
