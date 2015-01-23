## アクセス解析による課金計測

アクセス解析機能を利用し、自然流入経由を含めた広告別の課金計測を行うことができます。LTV計測においても課金を成果地点としている場合には、同一の箇所にLTVとアクセス解析のそれぞれの計測処理を実装してください。

アクセス解析による課金計測を行うために、次のsendEventメソッドを実装します。

```objectivec
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label orderID:(NSString*)orderID sku:(NSString*)sku itemName:(NSString*)itemName price:(double)price quantity:(NSUInteger)quantity currency:(NSString*)currency;
```

sendEventメソッドのパラメータの仕様は下記の通りです。

|パラメータ|型|最大長|概要|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|トラッキングを行うイベントを識別できる任意の名前を設定します。イベント名は自由に設定可能です。|
|action|NSString*|255|イベントに属するアクション名を設定します。アクション名は自由に設定可能です。特に指定がない場合はnilでも構いません。|
|label|NSString*|255|アクションに属するラベル名を設定します。ラベル名は自由に設定可能です。特に指定がない場合はnullでも構いません。|
|orderId|NSString|255|注文番号等を指定します。特に指定がない場合はnilでも構いません。|
|sku|String|255|商品コード等を指定します。特に指定がない場合はnilでも構いません。|
|itemName|String|255|商品名を指定します。指定しない場合には空文字@""を設定してください。|
|price|double||商品単価を指定します。|
|quantity|NSUInteger||数量を指定します。price * quantityが売上金額として計上されます。|
|currency|String||通貨コードを指定します。nilの場合は"JPY"が指定されます。|

> currencyには[ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217)で定義された通貨コードを指定してください。

サンプルとして、以下にアメリカドルで300円の課金を行った場合の実装例を記載致します。

```objectivec
#import "Ltv.h"

// LTV計測による課金計測
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv addParameter:LTV_PARAM_PRICE:@"300"];
[ltv addParameter:LTV_PARAM_CURRENCY:@"JPY"];
[ltv sendLtv:成果地点ID];

// アクセス解析による課金計測
[ForceAnalyticsManager sendEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:@"Item A" price:300 quantity:1 currency:@"JPY"];
```

[TOP](../../)
