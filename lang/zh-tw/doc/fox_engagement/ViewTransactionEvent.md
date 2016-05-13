# Track Transaction（商品購入事件）実装方法

在Track Transaction（商品購入）事件發生的地點、請按照下面的例子來安裝流量分析的事件計測功能。

### 安裝實例

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

### 参数详细

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventName|NSString|請指定為任意名稱。如果沒有特別指定，請指定為"_purchase"。|
|<span style="color:grey">action|<span style="color:grey">NSString|<span style="color:grey">不使用。|
|<span style="color:grey">label|<span style="color:grey">NSString|<span style="color:grey">不使用。|
|orderID|NSString|（任意）指定訂單號。|
|sku|NSString|（任意）指定商品代號sku。|
|<span style="color:grey">itemName|<span style="color:grey">NSString|<span style="color:grey">不使用。|
|price|double|指定商品總額。<br><span style="color:red">※請務必把price * quantity的結果作為商品總額來指定|
|quantity|NSUInteger|請指定為1。|
|currency|NSUInteger|指定貨幣代碼。<br>nil的場合默認指定為"JPY"。|
|eventInfo|NSDictionary|事件資訊詳細 (參考下面)|

#### 事件資訊詳細

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventInfo (fox_cvpoint)|NSDictionary|設定F.O.X的成果地點ID。|
|eventInfo (transaction.id)|NSDictionary|訂單號，諮詢號等處理事務ID|
|eventInfo (product)|JSONArray|把Product作為KEY，用數組形式設定商品ID。|
|&nbsp;&nbsp;eventInfo (product[].id)|NSDictionary|商品ID<br>請使用和數據字段相同的商品ID。|
|&nbsp;&nbsp;eventInfo (product[].price)|NSDictionary|設定該商品的價格。|
|&nbsp;&nbsp;eventInfo (product[].quantity)|NSDictionary|設定購入該商品的個數。|
|eventInfo (din/dout)|NSDictionary|如果希望指定日期請輸入。（任意）|
|eventInfo (criteo_partner_id)|NSDictionary|Criteo帳號ID在同一個APP裡不一樣的時候請設定。(任意)<br>在下方，根據這個Action的不同，在數據字段變動時做設定|
|eventInfo (datafeed)|NSDictionary|實時數據字段 (參考下方)|

#### 數據字段詳細

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|datafeed (version)|NSDictionary|指定數據字段的版本。|
|datafeed (product)|JSONArray|指定變動的數據字段。|
|&nbsp;&nbsp;datafeed (product[].id)|NSDictionary|能夠專門識別數據字段的商品的ID。|
|&nbsp;&nbsp;datafeed (product[].action)|NSDictionary|輸入對數據字段的操作。<br>U:添加或編輯　D:刪除|
|&nbsp;&nbsp;datafeed (product[].name)|NSDictionary|商品名。<br>下面的項目同樣，刪除時可以設定為nil。|
|&nbsp;&nbsp;datafeed (product[].expire)|NSDictionary|商品的有效期限。<br>請按照「yyyy-MM-dd HH:mm:ss」或者「yyyy-MM-dd」的格式來輸入日期。可以為nil。|
|&nbsp;&nbsp;datafeed (product[].effective)|NSDictionary|商品的公開日期和時間。<br>如果此項被設定，到公開日期和時間為止，商品不會被顯示出來。<br>請按照「yyyy-MM-dd HH:mm:ss」或「yyyy-MM-dd」的格式來輸入日期。可以為nil。|
|&nbsp;&nbsp;datafeed (product[].img)|NSDictionary|商品的圖像URL。<br>可以為nil。|
|&nbsp;&nbsp;datafeed (product[].category1)|NSDictionary|指定第一層次的種別。<br>可以為nil。|
|&nbsp;&nbsp;datafeed (product[].category2)|NSDictionary|指定第二層次的種別。<br>可以為nil。|
|&nbsp;&nbsp;datafeed (product[].category3)|NSDictionary|指定第三層次的種別。<br>可以為nil。|
|&nbsp;&nbsp;datafeed (product[].price)|NSDictionary|指定商品價格<br>可以為nil。|
|&nbsp;&nbsp;datafeed (product[].currency)|NSDictionary|指定商品的貨幣代碼。<br>nil的場合默認指定為"JPY"。|
|&nbsp;&nbsp;datafeed (product[].{任意})|NSDictionary|指定其他投放或分析使用的項目。|

> ※ 商品購入事件的price裡輸入的金額，請一定按照Json數據裡指定的商品總額(price * quantity)來指定。沒有指定的話，無法正常統計。

---
[返回](/lang/zh-tw/doc/fox_engagement/README.md)<br>
[TOP](/lang/zh-tw/README.md)
