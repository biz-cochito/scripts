#!/usr/bin/env bash

search_pattern="$1"
packages=$(yay -Qqd && yay -Qqe)

echo ""

matching=$(echo "$packages" | grep "$search_pattern")

if [ -z "$matching" ]; then
  echo "No packages matching pattern"
  exit 1
fi

selection=$(echo "$selection" |
  gum choose --no-limit --header "Matching packages:")

# echo "$selection" | gum pager
if [ -n "$selection" ]; then
  gum confirm && echo "$selection" | yay -Rns
else
  echo "No packages selected"
fi
