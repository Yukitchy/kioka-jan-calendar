#!/bin/bash
cd "$HOME/kioka-jan-calendar" || exit 1
exec > "$HOME/kioka-jan-calendar/update.log" 2>&1
export PATH="/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
echo "=== start $(date) ==="
git add -A
git status --short
git commit -m "Tour time 16:00-21:00; Jan 2 fully available (8 days)"
git push origin main
echo "=== UPDATE-DONE $(date) ==="
