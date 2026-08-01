#!/usr/bin/env bash
set -e

# Shared deck assets that embedded resource pages link directly (not part of
# the compiled theme). Canonical source lives in slides/styles/; each deck
# that needs one gets a build-time copy into its resources/ dir (gitignored)
# so Quarto can ship it into that deck's _site. Symlinks don't work here:
# Quarto's resource copier chokes on them.
cp slides/styles/elastic-scroll.css slides/basics/resources/elastic-scroll.css

for d in slides/*/; do
  [ -f "${d}_quarto.yml" ] || continue
  echo "Rendering ${d}"
  quarto render "${d}"
  mkdir -p "_site/${d}"
  cp -R "${d}_site/." "_site/${d}"
done
