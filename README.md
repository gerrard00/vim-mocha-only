# vim-mocha-only

I use Vim for Javascript development. I use Mocha for testing my Javascript.

I don't run Mocha tests from inside Vim. I use a separate terminal which automatically re-runs my tests when files change. If you run your tests directly inside Vim this isn't the plugin for you. Check out [vim-mocha-special-blend](https://github.com/toranb/vim-mocha-special-blend) which is probably more up your alley.

I wanted a way to quickly run only certain tests, but without actually running the tests in Vim. Here's a simple plugin to help do that by automatically adding `.only` to the test under your cursor.

## Installation

I use [vim-plug](https://github.com/junegunn/vim-plug):

    Plug 'gerrard00/vim-mocha-only', { 'for': ['javascript'] }

## Usage

The plugin adds three commands:

`:MochaOnlyAdd` changes `describe` to `describe.only` or `it` to `it.only`. It also removes any other `.only` statements in the same buffer.

`:MochaOnlyRemove` changes `describe.only` to `describe` and `it.only` to `it`.

`:MochaOnlyToggle` calls add or remove as appropriate.

All three commands require that your cursor is placed on the line where the test function is declared.

I personally use toggle most of the time, so I added a mapping to my .vimrc file:

    nnoremap <Leader>mo :MochaOnlyToggle<CR>

That way I can just do `\mo` to toggle away.

