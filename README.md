# emoji-kitchen-data

A smaller version of [emojikitchen.dev](https://github.com/xsalazar/emoji-kitchen) data.

## Spec

Quick script to 

1. curl https://emojikitchen.dev/metadata.json (98MB)
2. compress the data using jq from

```
{
  "data":{
    "2615":{
      "alt":"coffee",
      "emoji":"☕",
      "combinations":{
        "2648":[
          {
            "gStaticUrl":"https://www.gstatic.com/android/keyboard/emojikitchen/20260128/u2615/u2615_u2648.png",
            "alt":"coffee-aries",
            "leftEmoji":"☕",
            "leftEmojiCodepoint":"2615",
            "rightEmoji":"♈",
            "rightEmojiCodepoint":"2648",
            "date":"20260128",
            "isLatest":true,
            "gBoardOrder":579
          }
        ],
      }
```

down to 

```
{
  "2615": {
    emoji: "☕",
    combinations: [
      "2648": {
        "gStaticUrl":"https://www.gstatic.com/android/keyboard/emojikitchen/20260128/u2615/u2615_u2648.png",
        "leftEmoji":"☕",
        "leftEmojiCodepoint":"2615",
        "rightEmoji":"♈",
        "rightEmojiCodepoint":"2648",
      }
    ]
  }
}
```

The combination chosen should be the one with `"isLatest":true`, or the first.

3. Write ./dist/emoji-kitchen-data.json (pretty print) and ./dist/emoji-kitchen-data.json.gz
4. Print the input and output sizes

## Run

```
chmod +x ./compress-data.sh
```

```
./compress-data.sh
```

Output 2026-03-30:

```
Input size:  98867964 bytes
Output JSON: 82577255 bytes
Output GZ:   5008789 bytes
```

## Uses

* https://observablehq.com/@forresto/emoji-kitchen-graph
