#!/usr/bin/env bash
set -euo pipefail

mkdir -p dist

TMP=$(mktemp)
curl -s https://emojikitchen.dev/metadata.json -o "$TMP"
echo "Input size:  $(wc -c < "$TMP" | xargs) bytes"

jq '
  .data | to_entries | map({
    key: .key,
    value: {
      emoji: .value.emoji,
      combinations: (
        .value.combinations | to_entries | map({
          key: .key,
          value: (
            (.value | (map(select(.isLatest == true)) + .) | first)
            | {gStaticUrl, leftEmoji, leftEmojiCodepoint, rightEmoji, rightEmojiCodepoint}
          )
        }) | from_entries
      )
    }
  }) | from_entries
' "$TMP" > dist/emoji-kitchen-data.json
rm "$TMP"

gzip -kf dist/emoji-kitchen-data.json

echo "Output JSON: $(wc -c < dist/emoji-kitchen-data.json | xargs) bytes"
echo "Output GZ:   $(wc -c < dist/emoji-kitchen-data.json.gz | xargs) bytes"
