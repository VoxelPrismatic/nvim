return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    config = true,
    keys = {
        { "<leader>g", "<cmd>LazyGit<cr>", mode = "n", desc = "LazyGit" },
    },
}
