#!/bin/bash
cd "$HOME/kioka-jan-calendar" || exit 1
exec > "$HOME/kioka-jan-calendar/push.log" 2>&1
export PATH="/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
echo "=== start $(date) ==="
which git gh
git init -b main 2>/dev/null || git init
git add -A
git commit -m "Kioka January evening-tour availability board - 5 design variants" || echo "(commit skipped)"
if gh repo view Yukitchy/kioka-jan-calendar >/dev/null 2>&1; then
  echo "repo exists"
  git remote add origin https://github.com/Yukitchy/kioka-jan-calendar.git 2>/dev/null || git remote set-url origin https://github.com/Yukitchy/kioka-jan-calendar.git
  git push -u origin main
else
  echo "creating repo"
  gh repo create Yukitchy/kioka-jan-calendar --public --source=. --remote=origin --push
fi
echo "--- enable pages ---"
gh api -X POST repos/Yukitchy/kioka-jan-calendar/pages -f "source[branch]=main" -f "source[path]=/" 2>&1 || \
gh api -X PUT repos/Yukitchy/kioka-jan-calendar/pages -f "source[branch]=main" -f "source[path]=/" 2>&1
echo "=== PUSH-DONE $(date) ==="
