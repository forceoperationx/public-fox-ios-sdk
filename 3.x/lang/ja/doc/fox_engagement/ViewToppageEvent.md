#	View Home(アプリトップ訪問イベント)実装方法
　View Home（ホーム画面）イベントが発生する箇所に、下記に従ってアクセス解析のイベント計測機能を実装ください。

### 実装例

```objective-c
[ForceAnalyticsManager sendEvent:@"_view_toppage"
                          action:nil
                           label:nil
                           value:0　
                       eventInfo:@{
                                @"din":@"2016-01-02",
                               @"dout":@"2016-01-05",
                  @"criteo_partner_id":@"XXXXX",
                        @"fox_cvpoint":@"12345"
                                  }
];
```

### 引数詳細

| 引数 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventName|NSString|“\_view\_toppage”を指定してください。|
|<span style="color:grey">action|<span style="color:grey">NSString|<span style="color:grey">使用しません。|
|<span style="color:grey">label|<span style="color:grey">NSString|<span style="color:grey">使用しません。|
|<span style="color:grey">value|<span style="color:grey">NSUInteger|<span style="color:grey">使用しません。|
|eventInfo|NSDictionary|イベント情報詳細 (以下参照)|


#### イベント情報詳細

| 引数 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventInfo (din/dout)|NSDictionary|日付の指定がある場合は入力（任意）|
|eventInfo (criteo_partner_id)|NSDictionary|CriteoアカウントIDが同一アプリで異なる場合は入力(任意)|
|eventInfo (fox_cvpoint)|NSDictionary|F.O.Xの成果地点IDを設定します。(任意)|

---
[戻る](/lang/ja/doc/fox_engagement/README.md)

[TOPへ](/lang/ja/README.md)
