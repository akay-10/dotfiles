return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cmake = { "cmake_format" },
      cpp = { "clang_format" },
      c = { "clang_format" },
      lua = { "stylua" },
      sh = { "shfmt" },
      yaml = { "yamlfmt" },
      json = { "prettier" },
      markdown = { "markdownlint" },
    },
  },
}
