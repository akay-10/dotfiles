-- OpenCode.nvim (sudo-tee version) configuration for LazyVim
-- Full Neovim frontend for opencode AI coding agent
-- Place this file in: ~/.config/nvim/lua/plugins/opencode.lua

-- PREREQUISITES:
-- 1. Install opencode CLI (v0.6.3+): npm install -g @opencodehq/opencode
-- 2. Run: opencode auth login (to authenticate with your AI provider)
-- 3. Configure: ~/.config/opencode/config.json with your preferred LLM

return {
  "sudo-tee/opencode.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",

    -- Markdown rendering for AI responses
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },

    -- Completion support (using blink.cmp for LazyVim)
    -- Provides @ file mentions and # context items completion
    "saghen/blink.cmp",

    -- Picker for file selection (snacks is default in LazyVim)
    "folke/snacks.nvim",
  },

  opts = {
    -- Use snacks picker (LazyVim default)
    preferred_picker = "snacks",

    -- Use blink.cmp for completion (LazyVim default)
    preferred_completion = "blink",

    -- Enable default global keymaps
    default_global_keymaps = true,

    -- Default agent mode (build = full access, plan = read-only analysis)
    default_mode = "build",

    -- Keymap prefix (using <leader>o to avoid conflicts)
    keymap_prefix = "<leader>o",

    keymap = {
      -- Global editor keymaps (available everywhere)
      editor = {
        ["<leader>oo"] = { "toggle" }, -- Toggle opencode UI
        ["<leader>oi"] = { "open_input" }, -- Open input window (current session)
        ["<leader>oI"] = { "open_input_new_session" }, -- Open input (new session)
        ["<leader>oO"] = { "open_output" }, -- Open output window
        ["<leader>ot"] = { "toggle_focus" }, -- Toggle focus opencode/editor
        ["<leader>oq"] = { "close" }, -- Close opencode windows

        -- Session management
        ["<leader>os"] = { "select_session" }, -- Select session
        ["<leader>oS"] = { "select_child_session" }, -- Select child session
        ["<leader>oR"] = { "rename_session" }, -- Rename session
        ["<leader>oT"] = { "timeline" }, -- Timeline picker (undo/redo/fork)

        -- Configuration
        ["<leader>op"] = { "configure_provider" }, -- Switch provider/model
        ["<leader>oz"] = { "toggle_zoom" }, -- Zoom opencode windows
        ["<leader>ox"] = { "swap_position" }, -- Swap left/right position
        ["<leader>ov"] = { "paste_image" }, -- Paste image from clipboard

        -- Diff and revert operations
        ["<leader>od"] = { "diff_open" }, -- Open diff view
        ["<leader>o]"] = { "diff_next" }, -- Next file diff
        ["<leader>o["] = { "diff_prev" }, -- Previous file diff
        ["<leader>oc"] = { "diff_close" }, -- Close diff view

        -- Revert changes (last prompt)
        ["<leader>ora"] = { "diff_revert_all_last_prompt" }, -- Revert all files (last prompt)
        ["<leader>ort"] = { "diff_revert_this_last_prompt" }, -- Revert current file (last prompt)

        -- Revert changes (entire session)
        ["<leader>orA"] = { "diff_revert_all" }, -- Revert all files (session)
        ["<leader>orT"] = { "diff_revert_this" }, -- Revert current file (session)

        -- Restore from snapshots
        ["<leader>orr"] = { "diff_restore_snapshot_file" }, -- Restore file from snapshot
        ["<leader>orR"] = { "diff_restore_snapshot_all" }, -- Restore all from snapshot

        -- Permissions (when permission request is pending)
        ["<leader>opa"] = { "permission_accept" }, -- Accept permission once
        ["<leader>opA"] = { "permission_accept_all" }, -- Accept all permissions
        ["<leader>opd"] = { "permission_deny" }, -- Deny permission
      },

      -- Input window specific keymaps
      input_window = {
        ["<cr>"] = { "submit_input_prompt", mode = { "n", "i" } }, -- Submit prompt
        ["<esc>"] = { "close" }, -- Close windows
        ["<C-c>"] = { "cancel" }, -- Cancel running request

        -- Context and mentions
        ["@"] = { "mention", mode = "i" }, -- Insert mention (file/agent)
        ["~"] = { "mention_file", mode = "i" }, -- Pick file to mention
        ["#"] = { "context_items", mode = "i" }, -- Context items menu
        ["/"] = { "slash_commands", mode = "i" }, -- Slash commands menu

        -- Navigation and utilities
        ["<M-v>"] = { "paste_image", mode = "i" }, -- Paste image
        ["<C-i>"] = { "focus_input", mode = { "n", "i" } }, -- Focus input
        ["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle input/output
        ["<up>"] = { "prev_prompt_history", mode = { "n", "i" } }, -- Previous prompt
        ["<down>"] = { "next_prompt_history", mode = { "n", "i" } }, -- Next prompt
        ["<M-m>"] = { "switch_mode" }, -- Switch agent (build/plan)
      },

      -- Output window specific keymaps
      output_window = {
        ["<esc>"] = { "close" }, -- Close windows
        ["<C-c>"] = { "cancel" }, -- Cancel running request
        ["]]"] = { "next_message" }, -- Next message
        ["[["] = { "prev_message" }, -- Previous message
        ["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle panes
        ["i"] = { "focus_input", "n" }, -- Focus input (insert mode)

        -- Debug commands
        ["<leader>oD"] = { "debug_message" }, -- Debug raw message
        ["<leader>oOO"] = { "debug_output" }, -- Debug raw output
        ["<leader>ods"] = { "debug_session" }, -- Debug session data
      },

      -- Permission responses (available when permission pending)
      permission = {
        accept = "a", -- Accept once
        accept_all = "A", -- Accept all (persistent)
        deny = "d", -- Deny
      },

      -- Session picker keymaps
      session_picker = {
        rename_session = { "<C-r>" }, -- Rename session
        delete_session = { "<C-d>" }, -- Delete session
        new_session = { "<C-n>" }, -- New session
      },

      -- Timeline picker keymaps
      timeline_picker = {
        undo = { "<C-u>", mode = { "i", "n" } }, -- Undo to message
        fork = { "<C-f>", mode = { "i", "n" } }, -- Fork from message
      },

      -- History picker keymaps
      history_picker = {
        delete_entry = { "<C-d>", mode = { "i", "n" } }, -- Delete entry
        clear_all = { "<C-X>", mode = { "i", "n" } }, -- Clear all
      },
    },

    -- UI Configuration
    ui = {
      position = "right", -- Position: 'right' or 'left'
      input_position = "bottom", -- Input position: 'bottom' or 'top'
      window_width = 0.30, -- 30% of screen width (as requested)
      zoom_width = 0.8, -- Zoomed width (80%)
      input_height = 0.15, -- Input height (15% of window)

      -- Display options
      display_model = true, -- Show model name in winbar
      display_context_size = true, -- Show context size in footer
      display_cost = true, -- Show API cost in footer

      -- Window styling
      window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder",

      -- Icons (use nerdfonts, or 'text' for plain icons)
      icons = {
        preset = "nerdfonts", -- or 'text' to disable emojis
        overrides = {}, -- Custom icon overrides
      },

      -- Output window settings
      output = {
        tools = {
          show_output = true, -- Show tool outputs (diffs, cmd results)
        },
        rendering = {
          markdown_debounce_ms = 250, -- Debounce for markdown rendering
          on_data_rendered = nil, -- Custom render callback
        },
      },

      -- Input window settings
      input = {
        text = {
          wrap = false, -- Text wrapping in input
        },
      },

      -- Completion settings
      completion = {
        file_sources = {
          enabled = true,
          preferred_cli_tool = "server", -- 'fd', 'rg', 'git', 'server'
          ignore_patterns = {
            "^%.git/",
            "node_modules/",
            "%.pyc$",
            "%.o$",
            "build/",
            "dist/",
            "%.log$",
          },
          max_files = 10,
          max_display_length = 50,
        },
      },
    },

    -- Context configuration
    context = {
      enabled = true, -- Enable automatic context capture

      cursor_data = {
        enabled = false, -- Include cursor position/line
      },

      diagnostics = {
        info = false, -- Include info diagnostics
        warn = true, -- Include warning diagnostics
        error = true, -- Include error diagnostics
      },

      current_file = {
        enabled = true, -- Include current file
      },

      selection = {
        enabled = true, -- Include visual selection
      },
    },

    -- Debug options
    debug = {
      enabled = false, -- Enable debug messages
    },

    -- Prompt guard (optional function to control when prompts can be sent)
    prompt_guard = nil,

    -- Custom hooks
    hooks = {
      on_file_edited = nil, -- Called after file edit
      on_session_loaded = nil, -- Called after session load
      on_done_thinking = nil, -- Called when AI finishes
      on_permission_requested = nil, -- Called on permission request
    },
  },

  -- Load the plugin on these events/commands
  event = "VeryLazy", -- Load after Neovim startup
  cmd = "Opencode", -- Load when :Opencode command is used

  config = function(_, opts)
    -- Check if opencode module is available before setup
    local ok, opencode = pcall(require, "opencode")
    if not ok then
      vim.notify("opencode.nvim failed to load. Make sure the plugin is installed.", vim.log.levels.ERROR)
      return
    end

    opencode.setup(opts)

    -- Register with which-key
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add({
        { "<leader>o", group = "opencode" },
        { "<leader>oi", desc = "Open input" },
        { "<leader>oI", desc = "Open input (new session)" },
        { "<leader>oO", desc = "Open output" },
        { "<leader>oo", desc = "Toggle opencode" },
        { "<leader>ot", desc = "Toggle focus" },
        { "<leader>oq", desc = "Close" },
        { "<leader>os", desc = "Select session" },
        { "<leader>oS", desc = "Select child session" },
        { "<leader>oR", desc = "Rename session" },
        { "<leader>oT", desc = "Timeline" },
        { "<leader>op", desc = "Configure provider" },
        { "<leader>oz", desc = "Zoom" },
        { "<leader>ox", desc = "Swap position" },
        { "<leader>ov", desc = "Paste image" },
        { "<leader>od", desc = "Open diff" },
        { "<leader>o]", desc = "Next diff" },
        { "<leader>o[", desc = "Previous diff" },
        { "<leader>oc", desc = "Close diff" },
        { "<leader>or", group = "revert" },
        { "<leader>ora", desc = "Revert all (last prompt)" },
        { "<leader>ort", desc = "Revert this (last prompt)" },
        { "<leader>orA", desc = "Revert all (session)" },
        { "<leader>orT", desc = "Revert this (session)" },
        { "<leader>orr", desc = "Restore file" },
        { "<leader>orR", desc = "Restore all" },
        { "<leader>op", group = "permissions" },
        { "<leader>opa", desc = "Accept once" },
        { "<leader>opA", desc = "Accept all" },
        { "<leader>opd", desc = "Deny" },
      })
    end
  end,
}
