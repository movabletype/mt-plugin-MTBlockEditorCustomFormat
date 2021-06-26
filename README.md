# MTBlockEditorCustomFormat

This is a plugin for the Movable Type.
This plugin provides unitities to export MTBlockEditor data as a data structure.

## Installation

1. Download an archive file from [releases](https://github.com/usualoma/mt-plugin-MTBlockEditorCustomFormat/releases).
1. Unpack the archive file.
1. Upload the unpacked files to your MT directory.

Should look like this when installed:

    $MT_HOME/
        plugins/
            MTBlockEditorCustomFormat/

## Usage

### MTML

```mtml
<mt:ContentField content_field="a_block_editor_field">
<mt:ContentFieldValue convert_breaks="0" mtbe_custom_json="simple_with_meta","pretty" />
</mt:ContentField>
```

Output

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

Output

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

Output

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

### Specifiable parameters

You can specify the following values for the "mtbe_custom_json" parameter in MTML and "mtbe_custom" in Data API.

#### Subdivided designation

<dl>

<dt>strip_meta_all</dt>
<dd>Remove all metadata.</dd>

<dt>strip_meta_setup</dt>
<dd>Remove metadata (label and help text) for setup.</dd>

<dt>dedup_content</dt>
<dd>Removes the content contained in the child's blocks from the parent block in order to removes duplicates.</dd>

<dt>stringify_content</dt>
<dd>The content data saved as an array (internal data structrue) is converted to a character string.</dd>

<dt>raw</dt>
<dd>Outputs the internal data structure as it is</dd>

<dt>pretty</dt>
<dd>Specify the "pretty" flag for the JSON encoder.</dd>

<dt>ascii</dt>
<dd>Specify the "ascii" flag for the JSON encoder.</dd>

</dl>


#### Presets

Presets that combines multiple specifications.

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
* MTBlockEditor plugin

## LICENSE

The MIT License (MIT)

Copyright (c) 2021 Taku Amano

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
