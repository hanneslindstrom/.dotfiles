--------------------------------------------------------------------------------
-- Tasks Extension for Telescope
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Generator Functions

local generate_compilation_database = function(buf)

  -- Generate this task only for files in the GSDK.
  local cwd = vim.fn.getcwd()
  if string.find(cwd, "/gsdk") == nil then
    return nil
  end
  local gsdk_path = os.getenv("GSDK_REPO")
  if (gsdk_path == nil) then
    return nil
  end

  local relative_script_path = 'platform/security/script/compilation_database.sh'

  return {
    {
      "Generate Compilation Database: All",
      cwd = gsdk_path,
      cmd = ("%s all"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Panther",
      cwd = gsdk_path,
      cmd = ("%s panther"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Lynx",
      cwd = gsdk_path,
      cmd = ("%s lynx"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Dumbo",
      cwd = gsdk_path,
      cmd = ("%s dumbo"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Sol",
      cwd = gsdk_path,
      cmd = ("%s sol"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Ocelot",
      cwd = gsdk_path,
      cmd = ("%s ocelot"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Bobcat",
      cwd = gsdk_path,
      cmd = ("%s bobcat"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Leopard",
      cwd = gsdk_path,
      cmd = ("%s leopard"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Rainier",
      cwd = gsdk_path,
      cmd = ("%s rainier"):format(relative_script_path),
    },
    {
      "Generate Compilation Database: Custom Board",
      cwd = gsdk_path,
      cmd = ("%s "):format(relative_script_path),
    },
  }
end

--------------------------------------------------------------------------------
-- External Functions

local M = {}

M.add_tasks_generators = function(tasks)
  tasks.generators.custom.add(generate_compilation_database)
end

return M
