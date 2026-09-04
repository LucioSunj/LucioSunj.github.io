#!/usr/bin/env bash
# Download the institution / venue logos that are still placeholders.
#
# Run this from your own machine — it needs normal internet access:
#
#     bash scripts/fetch-logos.sh
#
# Already in place (supplied by hand, nothing to fetch):
#   xjtlu.png       XJTLU crest
#   iros.webp       IROS 2026 Pittsburgh logo
#   westlake.webp   Westlake Robotics
#
# Each file is only replaced if the download actually succeeds, so a failed
# fetch leaves the current placeholder alone. Re-run it any time.

set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
DEST="assets/img/logos"
mkdir -p "$DEST"

fetch() {                       # fetch <filename> <url> <description>
  local out="$DEST/$1" url="$2" desc="$3" tmp
  tmp="$(mktemp)"
  printf '  %-14s %s\n' "$1" "$desc"
  if curl -fsSL --max-time 30 -o "$tmp" "$url" && [ -s "$tmp" ]; then
    mv "$tmp" "$out"
    printf '  %-14s ✓ %s bytes\n' "" "$(wc -c < "$out" | tr -d ' ')"
  else
    rm -f "$tmp"
    printf '  %-14s ✗ download failed — keeping the current file\n' ""
  fi
}

echo "Fetching logos into $DEST"

fetch nju.png \
  "https://ra.nju.edu.cn/DFS/template/4639/images/logo.png" \
  "NJU School of Robotics and Automation (ra.nju.edu.cn)"

# indin.svg — INDIN has no stable logo URL across years. Optional; the
#             placeholder wordmark reads fine on its own.

cat <<'NOTE'

Done. One note:

  The NJU school lockup is white-on-transparent and very wide (569x62), so its
  card sets `logo_dark: true` in _data/research.yml to put it on a dark plate.
  If you would rather use the square purple NJU emblem, drop it in as nju.png
  and delete that line.
NOTE
