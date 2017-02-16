#	View Product（商品閲覧イベント）実装方法

　View Product（単一商品閲覧）イベントが発生する箇所に、下記に従ってアクセス解析のイベント計測機能を実装ください。

### 実装例

```java
[ForceAnalyticsManager sendEvent:@"_view_content"
                          action: nil
                           label: nil
                           value: 0
                       eventInfo:@{
                              @"fox_cvpoint":12345,
                                  @"product":@[{@"id": "111"}],
                                      @"din":@"2016-01-02",
                                     @"dout":@"2016-01-05",
                        @"criteo_partner_id":@"XXXXX"
                       }
];
```

### 引数詳細

| 引数 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventName|NSString|"\_view\_content" を指定してください。|
|<span style="color:grey">action|<span style="color:grey">NSString|<span style="color:grey">使用しません。|
|<span style="color:grey">label|<span style="color:grey">NSString|<span style="color:grey">使用しません。|
|<span style="color:grey">value|<span style="color:grey">NSUInteger|<span style="color:grey">使用しません。|
|eventInfo|NSDictionary|イベント情報詳細 (以下参照)|

#### イベント情報詳細

| 引数 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventInfo (fox_cvpoint)|NSDictionary|F.O.Xの成果地点IDを設定します。|
|eventInfo (product)|NSDictionary|Product をキーとして商品IDを配列で設定します。
|&nbsp;&nbsp;eventInfo (product[].id)|NSDictionary|閲覧した商品IDを設定します。|
|eventInfo (din/dout)|NSDictionary|⽇付の指定がある場合は⼊⼒してください。（任意）|
|eventInfo (criteo_partner_id)|NSDictionary|Criteo アカウントID が同⼀アプリで異なる場合は⼊⼒(任意)|
　　

---
[戻る](/lang/ja/doc/fox_engagement/README.md)

[TOPへ](/lang/ja/README.md)
