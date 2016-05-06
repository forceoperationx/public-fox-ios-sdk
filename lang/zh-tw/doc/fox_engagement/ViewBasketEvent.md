# View Basket（購物筐）実装方法

　在View Basket（商品購入預定一覽）事件發生的地點、請按照下面的例子來安裝流量分析的事件計測功能。

### 安裝例

```objective-c
[ForceAnalyticsManager sendEvent:@"_add_to_cart"
                          action: nil
                           label: nil
                           value: 0
                       eventInfo:@{
                           @"currency":@"JPY",
                        @"fox_cvpoint":12346,
                            @"product":@[
                                    {@"id ":@"1234",@"price":@100,@"quantity":@1},
	                                  {@"id ":@"1235",@"price":@200,@"quantity":@2},
	                                  {@"id ":@"1236",@"price":@300,@"quantity":@3}
                            ],
                                @"din":@"2016-01-02",
                               @"dout":@"2016-01-05",
                  @"criteo_partner_id":@"XXXXX"             
                       }
];
```

### 參數詳細

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventName|NSString|請指定"\_add\_to\_cart"|
|<span style="color:grey">action|<span style="color:grey">NSString|<span style="color:grey">不使用。|
|<span style="color:grey">label|<span style="color:grey">NSString|<span style="color:grey">不使用。|
|<span style="color:grey">value|<span style="color:grey">NSUInteger|<span style="color:grey">不使用。|
|eventInfo|NSDictionary|事件資訊詳細 (參考下面)|


#### 事件資訊詳細

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventInfo (currency)|NSDictionary|貨幣<br>如果設定為Nil/Null、默認為“JPY”|
|eventInfo (fox_cvpoint)|NSDictionary|設定F.O.X的成果地點ID。|
|eventInfo (product)|JSONArray|把Product作為KEY，用數組形式設定商品ID。|
|&nbsp;&nbsp;eventInfo (product[].id)|NSDictionary|商品ID<br>請使用和數據字段相同的商品ID。|
|&nbsp;&nbsp;eventInfo (product[].price)|NSDictionary|設定該商品的價格。|
|&nbsp;&nbsp;eventInfo (product[].quantity)|NSDictionary|設定購入該商品的個數。|
|eventInfo (din/dout)|NSDictionary|如果希望指定日期請輸入。（任意）|
|eventInfo (criteo_partner_id)|NSDictionary|Criteo帳號ID在同一個APP裡不一樣的時候請設定。(任意)|


---
[返回](/lang/zh-tw/doc/fox_engagement/README.md)<br>
[TOP](/lang/zh-tw/README.md)
