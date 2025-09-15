vim.cmd([[
    hi DiagnosticError guifg=#E47D75
    hi DiagnosticWarn  guifg=#DB794A
    hi DiagnosticInfo  guifg=#4AA7DB
    hi DiagnosticHint  guifg=#4ADBA0
    hi DiagnosticErrorSign guifg=#DB4A6A
    hi DiagnosticWarnSign  guifg=#DB794A
    hi DiagnosticInfoSign  guifg=#4AA7DB
    hi DiagnosticHintSign  guifg=#4ADBA0
]])

vim.cmd([[
    if exists('+termguicolors')
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
]])

