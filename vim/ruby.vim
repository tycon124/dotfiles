autocmd FileType ruby :iabbrev <buffer> pry! require 'pry'; binding.pry;
autocmd FileType ruby :iabbrev <buffer> spec! require 'spec_helper'

function InitFile()
    if @% == ""
        " No filename for current buffer
        silent !$HOME/.dotfiles/ruby/snippets/init_file %
    elseif filereadable(@%) == 0
        " File doesn't exist yet
        silent !$HOME/.dotfiles/ruby/snippets/init_file %
    elseif line('$') == 1 && col('$') == 1
        " File is empty
        silent !$HOME/.dotfiles/ruby/snippets/init_file %
    endif
endfunction

au BufReadPost *.rb call InitFile()

autocmd BufWritePost Gemfile,*.gemspec AsyncRun bundle install

autocmd BufWritePost *.rb AsyncRun -post=checktime rubocop % --auto-correct --config $HOME/.dotfiles/ruby/rubocop.yml

autocmd FileType ruby setlocal colorcolumn=100

nmap <Leader>cc :! grep "module\\\|class\\\|private\\\|def " %<Enter>
