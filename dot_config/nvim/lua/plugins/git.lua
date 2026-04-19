return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',
  {
    'ruifm/gitlinker.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitlinker').setup({
        opts = {
          remote = 'origin',
        },
        callbacks = {
          ["github.com"] = function(url_data)
            -- Check if this is the Mozilla Firefox repo
            if url_data.repo == "mozilla-firefox/firefox" then
              -- Use searchfox.org for Firefox
              local url = "https://searchfox.org/firefox-main/rev/"
                .. url_data.rev .. "/"
                .. url_data.file
              if url_data.lstart then
                url = url .. "#" .. url_data.lstart
                if url_data.lend and url_data.lend ~= url_data.lstart then
                  url = url .. "-" .. url_data.lend
                end
              end
              return url
            else
              -- Use the built-in GitHub callback
              local hosts = require('gitlinker.hosts')
              return hosts.get_github_type_url(url_data)
            end
          end
        }
      })
    end
  },
}
