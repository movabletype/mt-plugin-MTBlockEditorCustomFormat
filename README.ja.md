# MTBlockEditorCustomFormat

これはMovable Typeのプラグインです。
[MTBlockEditor](https://github.com/movabletype/mt-plugin-MTBlockEditor)の編集内容を、構造化されたデータとそして取得するためのプラグインの実装例です。

## インストール

1. [releases](https://github.com/movabletype/mt-plugin-MTBlockEditorCustomFormat/releases)からアーカイブをダウンロードしてください。
1. アーカイブを展開してください。
1. MTのインストールディレクトリへ、以下のような構成でアップロードしてください。

    $MT_HOME/
        plugins/
            MTBlockEditorCustomFormat/

## 使用例

### MTML

```mtml
<mt:ContentField content_field="a_block_editor_field">
<mt:ContentFieldValue convert_breaks="0" mtbe_custom_json="simple_with_meta","pretty" />
</mt:ContentField>
```

出力

```
[
   {
      "content" : "\u003cp\u003etest\u003c\u002fp\u003e",
      "type" : "core-text"
   },
   {
      "content" : "\u003cblockquote class=\"twitter-tweet\" data-width=\"550\"\u003e\u003cp lang=\"ja\" dir=\"ltr\"\u003e【オンラインミニセミナー本日開催👩‍💻】\u003cbr\u003eセキュリティやコンプライアンス管理の徹底を求められる企業サイト。でも高価なハイエンドCMSはコストが合わない…そんなケースにおすすめの「Movable Type SmartSync Pack」を徹底解説。短時間ですのでお気軽にご参加ください💁‍♀️\u003ca href=\"https:\u002f\u002ft.co\u002fYuBldvJmOY\"\u003ehttps:\u002f\u002ft.co\u002fYuBldvJmOY\u003c\u002fa\u003e\u003c\u002fp\u003e&mdash; シックス・アパート株式会社 (@sixapartkk) \u003ca href=\"https:\u002f\u002ftwitter.com\u002fsixapartkk\u002fstatus\u002f1349521164503171076?ref_src=twsrc%5Etfw\"\u003eJanuary 14, 2021\u003c\u002fa\u003e\u003c\u002fblockquote\u003e\u003cscript async src=\"https:\u002f\u002fplatform.twitter.com\u002fwidgets.js\" charset=\"utf-8\"\u003e\u003c\u002fscript\u003e",
      "type" : "sixapart-oembed",
      "meta" : {
         "providerName" : "Twitter",
         "maxwidth" : "640",
         "url" : "https:\u002f\u002ftwitter.com\u002fsixapartkk\u002fstatus\u002f1349521164503171076",
         "width" : 550
      }
   }
]
```

### Data API

#### Content Data

```
https://example.com/cgi-bin/mt/mt-data-api.cgi/v4/sites/1/contentTypes/1/data/1?fields=data_mtbe_custom&mtbe_custom=simple_with_meta
```

出力

```
{
  "data_mtbe_custom": [
    {
      "data": [
        {
          "content": "<p>test</p>",
          "type": "core-text"
        },
        {
          "content": "<blockquote class=\"twitter-tweet\" data-width=\"550\"><p lang=\"ja\" dir=\"ltr\">【オンラインミニセミナー本日開催👩‍💻】<br>セキュリティやコンプライアンス管理の徹底を求められる企業サイト。でも高価なハイエンドCMSはコストが合わない…そんなケースにおすすめの「Movable Type SmartSync Pack」を徹底解説。短時間ですのでお気軽にご参加ください💁‍♀️<a href=\"https://t.co/YuBldvJmOY\">https://t.co/YuBldvJmOY</a></p>&mdash; シックス・アパート株式会社 (@sixapartkk) <a href=\"https://twitter.com/sixapartkk/status/1349521164503171076?ref_src=twsrc%5Etfw\">January 14, 2021</a></blockquote><script async src=\"https://platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>",
          "meta": {
            "maxwidth": "640",
            "providerName": "Twitter",
            "url": "https://twitter.com/sixapartkk/status/1349521164503171076",
            "width": 550
          },
          "type": "sixapart-oembed"
        }
      ],
      "id": "7",
      "label": "a-mt-block-editor-field",
      "type": "multi_line_text"
    },
  ]
}
```

#### Entry / Page

```
https://example.com/cgi-bin/mt/mt-data-api.cgi/v4/sites/1/entries/1?fields=body_mtbe_custom,more_mtbe_custom&mtbe_custom=simple_with_meta
```

出力

```
{
  "body_mtbe_custom": [
    {
      "content": "<p>test block</p>",
      "type": "core-text"
    },
    {
      "content": "<blockquote class=\"twitter-tweet\"><p lang=\"ja\" dir=\"ltr\">【オンラインミニセミナー本日開催👩‍💻】<br>セキュリティやコンプライアンス管理の徹底を求められる企業サイト。でも高価なハイエンドCMSはコストが合わない...そんなケースにおすすめの「Movable Type SmartSync Pack」を徹底解説。短時間ですのでお気軽にご参加ください💁‍♀️<a href=\"https://t.co/YuBldvJmOY\">https://t.co/YuBldvJmOY</a></p>&mdash; シックス・アパート株式会社 (@sixapartkk) <a href=\"https://twitter.com/sixapartkk/status/1349521164503171076?ref_src=twsrc%5Etfw\">January 14, 2021</a></blockquote><script async src=\"https://platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>",
      "meta": {
        "providerName": "Twitter",
        "url": "https://twitter.com/sixapartkk/status/1349521164503171076",
        "width": 550
      },
      "type": "sixapart-oembed"
    }
  ],
  "more_mtbe_custom": [
    {
      "content": "<p><img src=\"https://example.com/2021-04-06-IMG_5565.jpg\" alt=\"\" width=\"3888\" height=\"2592\" class=\"asset asset-image mt-image-center\" style=\"max-width:100%;height:auto;display:block;margin-left:auto;margin-right:auto\"/></p>",
      "meta": {
        "alignment": "center",
        "assetId": "91",
        "useThumbnail": false
      },
      "type": "mt-image"
    }
  ]
}
```

### 指定可能なパラメータ

MTMLでは「mtbe_custom_json」に対して、Data APIでは「mtbe_custom」に対して、以下の値を指定することができます。

#### 詳細な値

<dl>

<dt>strip_meta_all</dt>
<dd>すべてのメタデータを削除します</dd>

<dt>strip_meta_setup</dt>
<dd>カスタムブロックで使われるラベルとヘルプとテキストのデータを削除します。</dd>

<dt>dedup_content</dt>
<dd>子ブロックがある場合には入力内容は子ブロックに含まれるため、親ブロックに入っている冗長な入力内容のデータを削除します</dd>

<dt>stringify_content</dt>
<dd>内部データでは配列ですが、一般的に使いやすいように単純な文字列に変換します</dd>

<dt>raw</dt>
<dd>変換を行わず、内部データをそのまま出力します</dd>

<dt>pretty</dt>
<dd>JSONのエンコーダーのオプションに「pretty」を指定します。MTMLの場合にのみ有効です。</dd>

<dt>ascii</dt>
<dd>JSONのエンコーダーのオプションに「ascii」を指定します。MTMLの場合にのみ有効です。</dd>

</dl>


#### プリセット

一般的なユースケースで簡単に指定するための、複数の指定を組み合わせたプリセットが用意されています。

<dl>

<dt>simple</dt>
<dd>
  <ul>
    <li>strip_meta_all</li>
    <li>dedup_content</li>
    <li>stringify_content</li>
  </ul>
</dd>

<dt>simple_with_meta</dt>
<dd>
  <ul>
    <li>strip_meta_setup</li>
    <li>dedup_content</li>
    <li>stringify_content</li>
  </ul>
</dd>

</dl>

## Requirements

* Movable Type 7
* MTBlockEditor plugin (1.0.6 or later)

## License

This library is free software released under the MIT. Please see LICENSE.txt

## Copyright

The following copyright notice applies to all the files provided in this
distribution, including binary files, unless explicitly noted otherwise.

Copyright 2021 Six Apart Ltd.
