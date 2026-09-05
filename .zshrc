# Interactive zsh. Everything lives in ~/.zshrc.d -- this file only sets the
# order, which is load-bearing. The split follows the one constraint that
# matters, not taxonomy:
#
#   env          runs before anything defines a widget or binds a key
#   tools        autosuggestions, zoxide, fzf, mise -- these bind ^R, ^T, ^I
#   aliases      no ordering constraint
#   functions    no ordering constraint
#   interactive  bindkeys, syntax highlighting, prompt -- must follow tools
#
# A name with no matching file is skipped silently (see the -x test below).

source_scripts(){
  for script in "$@"; do
    # skip non-executable snippets
    [ -x "$script" ] || continue
      # execute $script in the context of the current shell
      source $script
  done
}

source_scripts ~/.zshrc.d/{env,tools,aliases,functions,interactive}
