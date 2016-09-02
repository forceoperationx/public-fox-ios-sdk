# Track Transaction（商品購入イベント）実装方法

Track Transaction（商品購入）イベントが発生する箇所に、下記に従ってアクセス解析のイベント計測機能を実装ください。

### 実装例

```objective-c
[ForceAnalyticsManager sendEvent:@"_purchase"
		                      action:nil
		                       label:nil
		                     orderID:nil
		                         sku:nil
		                    itemName:nil
		                       price:2750
		                    quantity:6
		                    currency: "JPY"
		                   eventInfo: @{
                              @"fox_cvpoint":12348,
                           @"transaction_id":@"ABC",
                                  @"product":@[
                                          {@"id ":@"1234",@"price":550,@"quantity":@1},
                                          {@"id ":@"1235",@"price":550,@"quantity":@2},
                                          {@"id ":@"1236",@"price":550,@"quantity":@2}
                                  ],
                                      @"din":@"2016-01-02",
                                     @"dout":@"2016-01-05",
                        @"criteo_partner_id":@"XXXXX",
                        @"datafeed":@{
                                @"version":@"v1.0"
                                @"product":@[
                                          {
                                                   @"id":12345,
                                               @"action":@"U",
                                                 @"name":@"icecreame",
                                               @"expire":@"2016-10-31",
                                            @"effective":@"2016-04-01",
                                                  @"img":@"http://pngimg.com/upload/ice_cream_PNG5099.png",
                                            @"category1":@"food",
                                                @"price":@"2750",
                                             @"currency":@"JPY"
                                          }
                                ]
                        }
                       }
];
```

### 引数詳細

| 引数 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventName|NSString|任意の名前を指定してください。特に指定がない場は、"_purchase" を指定してください。|
|<span style="color:grey">action|<span style="color:grey">NSString|<span style="color:grey">使用しません。|
|<span style="color:grey">label|<span style="color:grey">NSString|<span style="color:grey">使用しません。|
|orderID|NSString|（任意）注⽂番号等を指定します。|
|sku|NSString|（任意）商品コード等を指定します。|
|<span style="color:grey">itemName|<span style="color:grey">NSString|<span style="color:grey">使用しません。|
|price|double|商品総額を指定します。<br><span style="color:red">※必ず price * quantity の値が商品総額となるよう指定ください|
|quantity|NSUInteger|1を指定してください。|
|currency|NSUInteger|通貨コードを指定します。<br>nilの場合は”JPY”が指定されます。|
|eventInfo|NSDictionary|イベント情報詳細 (以下参照)|

#### イベント情報詳細

| 引数 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventInfo (fox_cvpoint)|NSDictionary|F.O.Xの成果地点IDを設定します。|
|eventInfo (transaction.id)|NSDictionary|注文番号、問い合わせ番号などのトランザクションID|
|eventInfo (product)|JSONArray|Product をキーとして商品IDを配列で設定します。
|&nbsp;&nbsp;eventInfo (product[].id)|NSDictionary|商品IDデータフィードと同じ商品IDを使用してください。|
|&nbsp;&nbsp;eventInfo (product[].price)|NSDictionary|該当商品の価格を設定します。|
|&nbsp;&nbsp;eventInfo (product[].quantity)|NSDictionary|該当商品を買った個数を設定します。|
|eventInfo (din/dout)|NSDictionary|⽇付の指定がある場合は⼊⼒してください。（任意）|
|eventInfo (criteo_partner_id)|NSDictionary|Criteo アカウントID が同⼀アプリで異なる場合は⼊⼒(任意)<br>以下、このアクションによってデータフィードが変動する場合に設定します。|
|eventInfo (datafeed)|NSDictionary|リアルタイムデータフィード (以下参照)|

#### データフィード詳細

| 引数 | 型 | 概要 |
|:----------|:-----------:|:------------|
|datafeed (version)|NSDictionary|データフィードのバージョンを指定します。|
|datafeed (product)|JSONArray|変動するデータフィードを設定します。|
|&nbsp;&nbsp;datafeed (product[].id)|NSDictionary|データフィードのアイテムを一意に識別するIDです。|
|&nbsp;&nbsp;datafeed (product[].action)|NSDictionary|データフィードをどのように変更するかを入力します。<br>U:追加もしくは編集　D:削除|
|&nbsp;&nbsp;datafeed (product[].name)|NSDictionary|アイテム名です。<br>以下全て、削除の際はnilで構いません。|
|&nbsp;&nbsp;datafeed (product[].expire)|NSDictionary|アイテムの有効期限です。<br>「yyyy-MM-dd HH:mm:ss」もしくは「yyyy-MM-dd」の書式で日付を入力してください。nilでも構いません。|
|&nbsp;&nbsp;datafeed (product[].effective)|NSDictionary|アイテムの公開日時です。<br>これが設定された場合、公開日時になるまで商品はでません表示されません。<br>「yyyy-MM-dd HH:mm:ss」もしくは「yyyy-MM-dd」の書式で日付を入力してください。nilでも構いません。|
|&nbsp;&nbsp;datafeed (product[].img)|NSDictionary|アイテムの画像URLです。<br>nilでも構いません。|
|&nbsp;&nbsp;datafeed (product[].category1)|NSDictionary|第一階層のカテゴリを指定します。<br>nilでも構いません。|
|&nbsp;&nbsp;datafeed (product[].category2)|NSDictionary|第二階層のカテゴリを指定します。<br>nilでも構いません。|
|&nbsp;&nbsp;datafeed (product[].category3)|NSDictionary|第三階層のカテゴリを指定します。<br>nilでも構いません。|
|&nbsp;&nbsp;datafeed (product[].price)|NSDictionary|アイテムの価格を指定します。<br>nilでも構いません。|
|&nbsp;&nbsp;datafeed (product[].currency)|NSDictionary|アイテムの通貨コードを指定します。<br>nilの場合、JPYが適用されます。|
|&nbsp;&nbsp;datafeed (product[].{任意})|NSDictionary|その他配信、分析に使用する項目を指定します。|

> ※ 商品購⼊イベントの price に⼊⼒する⾦額は必ず、Json データに指定した商品の総額 (price * quantity)となるよう指定してください。指定されていない場合、集計が正しく⾏われません。


---
[戻る](/lang/ja/doc/fox_engagement/README.md)

[TOPへ](/lang/ja/README.md)
