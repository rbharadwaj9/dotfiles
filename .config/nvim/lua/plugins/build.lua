return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "cpp", "c", "cmake" },
    config = function ()
      local osys = require("cmake-tools.osys")
      require('cmake-tools').setup {
        cmake_build_directory = function()
          if osys.iswin32 then
            return "build\\${variant:buildType}"
          end
          return "build/${variant:buildType}"
        end
      }

      local function cmd(command)
        return function() vim.cmd(command) end
      end

      require('util.snacks_menu').register('cmake_actions', {
        { text = "generate",              desc = "Configure the project and generate the native build system",             action = cmd("CMakeGenerate") },
        { text = "build",                 desc = "Build the selected target",                                              action = cmd("CMakeBuild") },
        { text = "build-current-file",    desc = "Build targets related to the current file",                              action = cmd("CMakeBuildCurrentFile") },
        { text = "run",                   desc = "Run the selected launch target",                                        action = cmd("CMakeRun") },
        { text = "run-current-file",      desc = "Run targets related to the current file",                               action = cmd("CMakeRunCurrentFile") },
        { text = "debug",                 desc = "Debug the selected launch target via nvim-dap",                         action = cmd("CMakeDebug") },
        { text = "debug-current-file",    desc = "Debug targets related to the current file",                             action = cmd("CMakeDebugCurrentFile") },
        { text = "run-tests",             desc = "Run tests via ctest",                                                    action = cmd("CMakeRunTest") },
        { text = "install",               desc = "Install CMake targets",                                                  action = cmd("CMakeInstall") },
        { text = "clean",                 desc = "Clean all targets, intermediates and deps",                              action = cmd("CMakeClean") },
        { text = "quick-build",           desc = "Build a target without changing the currently selected target",         action = cmd("CMakeQuickBuild") },
        { text = "quick-run",             desc = "Run a target without changing the currently selected target",           action = cmd("CMakeQuickRun") },
        { text = "quick-debug",           desc = "Debug a target without changing the currently selected target",         action = cmd("CMakeQuickDebug") },
        { text = "select-build-type",     desc = "Select build type (Debug, Release, RelWithDebInfo, MinSizeRel, ...)",   action = cmd("CMakeSelectBuildType") },
        { text = "select-build-target",   desc = "Select the target to be built",                                         action = cmd("CMakeSelectBuildTarget") },
        { text = "select-launch-target",  desc = "Select the executable target to be launched",                           action = cmd("CMakeSelectLaunchTarget") },
        { text = "select-kit",            desc = "Select a kit from CMakeKits.json / cmake-kits.json",                    action = cmd("CMakeSelectKit") },
        { text = "select-configure-preset", desc = "Select a configure preset from CMakePresets.json",                    action = cmd("CMakeSelectConfigurePreset") },
        { text = "select-build-preset",   desc = "Select a build preset from CMakePresets.json",                         action = cmd("CMakeSelectBuildPreset") },
        { text = "select-test-preset",    desc = "Select a test preset from CMakePresets.json",                          action = cmd("CMakeSelectTestPreset") },
        { text = "select-cwd",            desc = "Select the directory containing the main CMakeLists.txt",              action = cmd("CMakeSelectCwd") },
        { text = "select-build-dir",      desc = "Select the directory the build files go into",                        action = cmd("CMakeSelectBuildDir") },
        { text = "launch-args",           desc = "Set command line arguments for the selected launch target",            action = cmd("CMakeLaunchArgs") },
        { text = "open-executor",         desc = "Open the CMake executor/runner window",                                action = cmd("CMakeOpenExecutor") },
        { text = "open-cache",            desc = "Open CMakeCache.txt",                                                   action = cmd("CMakeOpenCache") },
        { text = "close-executor",        desc = "Close the CMake executor/runner window",                                action = cmd("CMakeCloseExecutor") },
        { text = "settings",              desc = "Open project-wide CMake settings",                                     action = cmd("CMakeSettings") },
        { text = "target-settings",       desc = "Open settings for a single target",                                    action = cmd("CMakeTargetSettings") },
      })
    end,
    keys = {
      { "<leader><leader>", "<cmd>CMakeBuild<CR>", nowait = true, silent = true, desc = "Build" },
      { "<leader>dd", "<cmd>CMakeDebug<CR>", nowait = true, silent = true, desc = "CMake Debug" },
      { "<leader>c", function() Snacks.picker.cmake_actions() end, desc = "CMake Actions" },
    }
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
