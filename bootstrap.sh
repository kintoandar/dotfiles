#!/usr/bin/env bash
#
# Symlinks this repo's configs into place. Safe to re-run: it never overwrites
# and never deletes. Anything already sitting at a destination is reported and
# skipped, so resolving a conflict is always a deliberate `rm` by hand.
#
#   ./bootstrap.sh            link whatever is missing
#   ./bootstrap.sh --dry-run  report only, touch nothing
#
# Scope is the set of configs actually deployed on this machine. The dormant
# ones in the repo (.vimrc, .screenrc, .conkyrc, .muttrc, kitty.conf) are left
# out deliberately -- they are kept for reference, not installed.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

DRY_RUN=false
case "${1:-}" in
--dry-run | -n) DRY_RUN=true ;;
"") ;;
*)
  echo "usage: ${0##*/} [--dry-run]" >&2
  exit 64
  ;;
esac

# source (relative to repo) : destination (relative to $HOME)
LINKS=(
  ".bash_profile:.bash_profile"
  ".bashrc:.bashrc"
  ".bashrc.d:.bashrc.d"
  ".zshrc:.zshrc"
  ".zshrc.d:.zshrc.d"
  "starship.toml:.config/starship.toml"
  "ghostty.config:.config/ghostty/config"
)

ok=0 linked=0 conflicts=0 missing=0

say() { printf '%-7s %s\n' "$1" "$2"; }

for entry in "${LINKS[@]}"; do
  src="$REPO/${entry%%:*}"
  dest="$HOME/${entry##*:}"
  short="~/${entry##*:}"

  if [ ! -e "$src" ]; then
    say "SKIP" "$short  (${entry%%:*} not in repo)"
    missing=$((missing + 1))
    continue
  fi

  # -ef compares the inode after following links, so an already-correct link
  # counts as correct whether it was written relative (code/dotfiles/.bashrc,
  # the older style in this repo) or absolute.
  if [ -L "$dest" ] && [ "$dest" -ef "$src" ]; then
    say "ok" "$short"
    ok=$((ok + 1))
    continue
  fi

  if [ -L "$dest" ]; then
    say "WARN" "$short is a symlink to $(readlink "$dest") -- left alone"
    conflicts=$((conflicts + 1))
    continue
  fi

  if [ -e "$dest" ]; then
    say "WARN" "$short already exists -- left alone"
    conflicts=$((conflicts + 1))
    continue
  fi

  if $DRY_RUN; then
    say "would" "$short -> $src"
  else
    mkdir -p "$(dirname "$dest")"
    # Only reached when nothing at all is at $dest. That guard matters for the
    # two directory entries: `ln -s` onto an existing directory symlink would
    # silently create the new link *inside* it.
    ln -s "$src" "$dest"
    say "linked" "$short -> $src"
  fi
  linked=$((linked + 1))
done

printf '\n%d ok, %d linked, %d conflict(s), %d missing source(s)\n' \
  "$ok" "$linked" "$conflicts" "$missing"

# Non-zero when something was in the way, so a caller can tell "all set" from
# "needs a look".
[ "$conflicts" -eq 0 ]
