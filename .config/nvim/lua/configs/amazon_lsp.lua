local jdtls = require("jdtls")
local on_attach = require("configs.lsp").on_attach -- change to yours

local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
 local file = io.open(root_dir .. "/.bemol/ws_root_folders")
 if file then
  for line in file:lines() do
   table.insert(ws_folders_jdtls, "file://" .. line)
  end
  file:close()
 end
end

local config = {
 on_attach = on_attach,
 cmd = {
  "jdtls", -- need to be on your PATH
  "--jvm-arg=-javaagent:" .. home .. "/Developer/lombok.jar", -- need for lombok magic
  "-data",
  eclipse_workspace,
 },
 root_dir = root_dir,
 init_options = {
  workspaceFolders = ws_folders_jdtls,
 },
}

jdtls.start_or_attach(config)

function M.bemol()
 local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory'})[1]
 local ws_folders_lsp = {}
 if bemol_dir then
  local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
  if file then

   for line in file:lines() do
    table.insert(ws_folders_lsp, line)
   end
   file:close()
  end
 end

 for _, line in ipairs(ws_folders_lsp) do
  vim.lsp.buf.add_workspace_folder(line)
 end

end
