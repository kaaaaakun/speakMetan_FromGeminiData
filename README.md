# Gemini音声生成スクリプト

## 概要

このスクリプトは、Geminiという生成言語モデルを使用してテキストから音声ファイルを生成するためのものです。

## 前提条件

- `curl`と`mplayer`がインストールされていることを確認してください。
- Google Cloud PlatformからGemini APIキーを取得し、環境変数 `GOOGLE_API_KEY` に設定してください。

## 使い方

1. スクリプトを実行する際に、変換したいテキストを引数として渡します。  
   例: `./getFromGemini.sh "これはテストの文章です。"`

## 詳細

- スクリプトは提供されたテキストをGoogle Cloud APIを介してGeminiモデルに送信し、連続した内容を生成します。
- 生成されたテキストを行ごとに分割し、それぞれの行をローカルのTTS（テキスト読み上げ）サーバーに送信します。
- TTSサーバーは、テキストの各行に対応する音声ファイルを生成します。
- 最後に、スクリプトは`mplayer`を使用して音声ファイルを再生します。

## 手順

1. Google APIキーを `GOOGLE_API_KEY` としてエクスポートします。
2. ローカルのTTSサーバーが `127.0.0.1:50021` で実行されていることを確認してください。
3. スクリプトを使用して、必要なテキスト入力を実行します。

## 例

```bash
./getFromGemini.sh "これはテストの文章です。"
```
