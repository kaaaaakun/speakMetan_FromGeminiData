#!/bin/bash
# This script is used to get data from Gemini

export GOOGLE_API_KEY="AIzaSyBQ_JdKSkedRu2GI4tp2vPuTfbAeimK4UI"

# プロンプトの設定
txt=${1}」を100文字くらいでまとめて

# geminiからデータを取得
curl -H 'Content-Type: application/json' \
  -d "{\"contents\":[{\"parts\":[{\"text\":\"$txt\"}]}]}" \
  -X POST 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key='$GOOGLE_API_KEY \
  >geminidata.json

#分割して保存
cat geminidata.json |
	sed -n 's/.*"text": "\([^"]*\)".*/\1/p'|
	sed 's/\\n/\n/g' |
	sed 's/。/。\n/g' |
	sed '/^$/d' \
	> geminidata.txt

cat geminidata.json geminidata.txt
# 行数の確認
total_lines=$(wc -l < geminidata.txt)

# ファイルを作成して1行ずつ入れる
for (( i=1; i<=$total_lines; i++ )); do
    line_content=$(sed -n "${i}p" geminidata.txt)
    echo "$line_content" > "output_$i.txt"

    curl -s \
        -X POST \
        "127.0.0.1:50021/audio_query?speaker=2"\
        --get --data-urlencode "text@output_$i.txt" \
        > query_$i.json
    
    curl -s \
        -H "Content-Type: application/json" \
        -X POST \
        -d @query_$i.json \
        "127.0.0.1:50021/synthesis?speaker=2" \
        > audio_$i.wav

    mplayer audio_$i.wav
	rm audio_$i.wav
	rm query_$i.json
	rm output_$i.txt
done

