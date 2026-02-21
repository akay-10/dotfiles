return {
  "mini-snippets/mini.snippets",
  opts = function(_, opts)
    local ms = require("mini.snippets")

    local function cpp_loader(context)
      if context.lang ~= "cpp" then
        return nil
      end

      local path = vim.api.nvim_buf_get_name(context.buf_id)
      local base_ns = vim.fn.fnamemodify(path, ":h:h:h:t")
      local filename = vim.fn.fnamemodify(path, ":t:r")
      local dir = vim.fn.fnamemodify(path, ":h:t")

      if filename == "" then
        filename = "snippet"
      end
      if dir == "" or dir == "." then
        dir = "project"
      end

      local classname = filename:gsub("_(%a)", string.upper):gsub("^%a", string.upper)
      local guard = (base_ns .. "_" .. dir .. "_" .. filename .. "_H"):upper()
      local ns_open = "namespace " .. base_ns .. " { namespace " .. dir .. " {"
      local ns_close = "}} // namespace " .. base_ns .. "::" .. dir

      return {
        {
          prefix = "cch",
          desc   = "C++ class header",
          body   = "#ifndef " .. guard .. "\n"
                .. "#define " .. guard .. "\n"
                .. "\n"
                .. "#include <memory> // shared_ptr\n\n"
                .. "#include \"basic/basic.h\"\n"
                .. "\n"
                .. ns_open .. "\n"
                .. "\n"
                .. "class " .. classname .. " {\n"
                .. " public:\n"
                .. "  typedef std::shared_ptr<" .. classname .. "> Ptr;\n"
                .. "  typedef std::shared_ptr<const " .. classname .. "> PtrConst;\n"
                .. "\n"
                .. "  " .. classname .. "();\n"
                .. "  ~" .. classname .. "();\n"
                .. "\n"
                .. " private:\n"
                .. "  $1\n"
                .. " private:\n"
                .. "  DISALLOW_COPY_AND_ASSIGN(" .. classname .. ");\n"
                .. "  $2\n"
                .. "};\n"
                .. "\n"
                .. ns_close .. "\n"
                .. "\n"
                .. "#endif // " .. guard,
        },
        {
          prefix = "ccs",
          desc   = "C++ class source",
          body   = "#include \"" .. filename .. ".h\"\n"
                .. "\n"
                .. "using namespace std;\n"
                .. "\n"
                .. ns_open .. "\n"
                .. "\n"
                .. "//------------------------------------------------------------------------------\n"
                .. classname .. "::" .. classname .. "() {\n"
                .. "  $1\n"
                .. "}\n"
                .. "\n"
                .. "//------------------------------------------------------------------------------\n"
                .. classname .. "::~" .. classname .. "() {\n"
                .. "  $2\n"
                .. "}\n"
                .. "\n"
                .. "//------------------------------------------------------------------------------\n"
                .. "$3\n"
                .. "\n"
                .. ns_close,
        },
      }
    end

    opts.snippets = {
      cpp_loader,
      ms.gen_loader.from_lang(),
    }
  end,
}
