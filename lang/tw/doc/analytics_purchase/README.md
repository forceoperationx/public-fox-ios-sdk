## 依靠流量分析進行消費計測

利用流量分析機能，能夠計測不同廣告流入和自然流入的用戶消費狀況。在LTV計測地點也做消費計測的場合，請在同一個地點安裝LTV和流量分析的各自的計測處理代碼。

為了依靠流量分析進行消費計測，請安裝下面的sendEvent方法。

```objective-c
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label orderID:(NSString*)orderID sku:(NSString*)sku itemName:(NSString*)itemName price:(double)price quantity:(NSUInteger)quantity currency:(NSString*)currency;
```

sendEvent方法的參數說明如下。

|參數|型|最大長度|概要|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|設定能夠識別監測Event的任意名稱。可以自由設定。|
|action|NSString*|255|設定屬於Event的Action名。可以自由設定。不做特別指定的場合可以為nil。|
|label|NSString*|255|屬於Action的Label名。可以自由設定。不做特別指定的場合可以為nil。|
|orderId|NSString|255|指定訂單號。不做特別指定的場合可以為nil。|
|sku|String|255|指定商品代號sku。不做特別指定的場合可以為nil。|
|itemName|String|255|指定商品名。不指定的場合請設定空文字串@""|
|price|double||指定商品單價。|
|quantity|NSUInteger||指定數量。按price * quantity的銷售金額來計算在內。|
|currency|String||指定貨幣代碼。nil的場合默認指定為"JPY"。|

> currency請用[ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217)定義的貨幣代碼來指定。

下面是一個按美元300日圓消費的場合的安裝例子。

```objective-c
#import "Ltv.h"

// LTV計測形式的消費計測
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv addParameter:LTV_PARAM_PRICE:@"300"];
[ltv addParameter:LTV_PARAM_CURRENCY:@"JPY"];
[ltv sendLtv:成果地点ID];

// 流量分析形式的消費計測
[ForceAnalyticsManager sendEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:@"Item A" price:300 quantity:1 currency:@"JPY"];
```

---
[TOP](/lang/tw/README.md)
