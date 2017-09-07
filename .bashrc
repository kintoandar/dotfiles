source_scripts(){
  for script in "$@"; do
    # skip non-executable snippets
    [ -x "$script" ] || continue
      # execute $script in the context of the current shell
      source $script
  done
}

source_scripts ~/.bashrc.d/{paths,env,colors,prompt,aliases,functions,ansible,aws,chef,docker,fzf,hashicorp,kubernetes,_*,completion}
