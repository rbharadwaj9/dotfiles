return {
    {
        "Shatur/neovim-tasks",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "cpp", "c", "rust", "make" },
        config = function()
            local Path = require('plenary.path')
            require("tasks").setup({
                default_params = {
                    cmake = {
                        cmd = 'cmake', -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
                        build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
                        build_type = 'Debug', -- Build type, can be changed using `:Task set_module_param cmake build_type`.
                        args = { -- Task default arguments.
                            configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
                        },
                    }
                }
            })
        end,
        enabled = false,
    },
    {
        "Civitasv/cmake-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "cpp", "c", "cmake" },
        opts = {},
        keys = {
            { "<leader><leader>", "<cmd>CMakeBuild<CR>", nowait = true, silent = true, desc = "Build"},
        }
    }
}
