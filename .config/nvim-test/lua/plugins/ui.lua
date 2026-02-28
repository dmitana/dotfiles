return {
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
          },
          {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 1,
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" }
          },
          -- {
          --   gps.get_location,
          --   condition = gps.is_available
          -- },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    },
  }
}
