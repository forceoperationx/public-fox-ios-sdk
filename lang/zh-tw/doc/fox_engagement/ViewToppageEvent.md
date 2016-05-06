#	View Home(APP TOP訪問事件)安裝方法
　在View Home（HOME畫面）事件發生的地點、請按照下面的例子來安裝流量分析的事件計測功能。

### 安裝實例

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

### 参数详细

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventName|NSString|請指定“\_view\_toppage”|
|<span style="color:grey">action|<span style="color:grey">NSString|<span style="color:grey">不使用。|
|<span style="color:grey">label|<span style="color:grey">NSString|<span style="color:grey">不使用。|
|<span style="color:grey">value|<span style="color:grey">NSUInteger|<span style="color:grey">不使用。|
|eventInfo|NSDictionary|事件資訊詳細 (參考下面)|


#### 事件資訊詳細

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventInfo (din/dout)|NSDictionary|如果希望指定日期請輸入（任意）|
|eventInfo (criteo_partner_id)|NSDictionary|Criteo帳號ID在同一個APP裡不一樣的時候請設定。(任意)|
|eventInfo (fox_cvpoint)|NSDictionary|設定F.O.X的成果地點ID。|

---
[返回](/lang/zh-tw/doc/fox_engagement/README.md)<br>
[TOP](/lang/zh-tw/README.md)
