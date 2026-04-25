return {
  "saghen/blink.cmp",
  opts = {
    -- Fixes the clash of TAB key b/w supermaven-nvim and blink.cmp
    -- keymap = {
    --   preset = "default",
    --   ["<Tab>"] = {
    --     function(cmp)
    --       local ok, preview = pcall(require, "supermaven-nvim.completion_preview")
    --       if ok and preview.has_suggestion() then
    --         vim.schedule(function()
    --           preview.on_accept_suggestion()
    --         end)
    --         return true
    --       end
    --       return cmp.select_next()
    --     end,
    --     "fallback",
    --   },
    -- },
    snippets = { preset = "mini_snippets" },
  },
}
