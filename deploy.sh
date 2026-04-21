#!/bin/bash
cd "$(dirname "$0")"

# Auto-increment version
V=$(date +%s)

# Update iframe version in demo.html
sed -i '' "s/index.html?v=[^#]*/index.html?v=$V/" demo.html

# Stage, commit, push
git add -A
git commit -m "${1:-update} [v=$V]"
git push

# Purge GitHub Pages cache
curl -s -X POST \
  -H "Authorization: token $(gh auth token)" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/vishal-affirm/ai-prototype/pages/builds" > /dev/null 2>&1

echo ""
echo "Deployed: https://vishal-affirm.github.io/ai-prototype/demo.html?v=$V"
echo "Standalone: https://vishal-affirm.github.io/ai-prototype/?v=$V"
