[TOP](../../README.md)　>　イベント計測の詳細

---

# イベント計測の詳細


以下、各種イベントを実装する際の詳細を説明します。<br>
エンゲージメント計測やダイナミック配信連携を行う際に必要となる実装も含まれます。本実装を行うことで、媒体を横断したイベント計測連携が可能となります。

* **[1. アプリ内の各種イベント実装例](#each_event_sample)**
* **[2. 旧バージョンでの実装の置き換え(エンゲージメント計測)](#continuity)**
* **[3. タグを利用したイベント計測について](#track_by_tag)**

<div id="each_event_sample"></div>
## 1. アプリ内の各種イベント実装例

#### 1.1 会員登録イベント計測 実装例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
FOXEvent* event = [[FOXEvent alloc] initWithEventName:@"_register_account" andLtvId:0000];
event.buid = @"User ID";
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:FOXEvent = FOXEvent.init(eventName:"_register_account", andLtvId:0000)!
event.buid = "User ID"
CYZFox.trackEvent(event)
```

#### 1.2 チュートリアル完了イベント計測 実装例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
FOXEvent* event = [[FOXEvent alloc] initWithEventName:@"_tuturial_comp" andLtvId:0000];
event.buid = @"User ID";
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:FOXEvent = FOXEvent.init(eventName:"_tuturial_comp", andLtvId:0000)!
event.buid = "User ID"
CYZFox.trackEvent(event)
```

#### 1.3 課金イベント計測 実装例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
FOXEvent* event = [[FOXEvent alloc] initWithEventName:@"_purchase" andLtvId:0000];
event.buid = @"User ID";
event.price = 99;
event.currency = @"JPY";
event.sku = @"itemId"
event.quantity = 2;
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:FOXEvent = FOXEvent.init(eventName:"_purchase")!
event.price = 99
event.currency = "JPY"
event.sku = "itemId"
CYZFox.trackEvent(event)
```

<div id="continuity"></div>
## 2. 旧バージョンでの実装の置き換え(エンゲージメント計測)

これまでのF.O.X iOS SDK 3.0.0以下で行っていた実装方法を継続することも可能となっています。<br>
下記は課金イベントのエンゲージメント計測の実装例です。

**実装例**

```objc
NSDictionary* eventInfo = @{
                            @"fox_cvpoint" : @"12345",
                            @"transaction_id" : @"ABCDFE",
                            @"product" : @[
                                    @{@"id" : @"1234", @"price" : @(550), @"quantity" : @(1)},
                                    @{@"id" : @"1235", @"price" : @(550), @"quantity" : @(2)},
                                    @{@"id" : @"1236", @"price" : @(550), @"quantity" : @(2)}
                                    ],
                            @"din" : @"2016-01-02",
                            @"dout" :@"2016-01-05",
                            @"criteo_partner_id" : @"XXXXX",
                            @"datafeed" : @{
                                    @"version" : @"v1.0",
                                    @"product" : @[
                                            @{
                                                @"id" : @"12345",
                                                @"action" : @"U",
                                                @"name" : @"icecream",
                                                @"expire" : @"2016-10-31",
                                                @"effective" : @"2016-04-01",
                                                @"img" : @"http://pngimg.com/upload/ice_cream_PNG5099.png",
                                                @"category1" : @"food",
                                                @"price" : @(2750),
                                                @"currency" : @"JPY"
                                                }
                                            ]
                                    }
                            };

CYZEvent* event = [[CYZEvent alloc]initWithEventName:@"_purchase"];
event.buid = @"user_001";
event.price = 2750;
event.currency = @"JPY";
event.quantity = 1;
event.sku = @"ABC789";
event.orderId = "ABCDFE";
event.eventInfo = eventInfo;
[CYZFox trackEvent:event];
```

<div id="track_by_tag"></div>
## 3. タグを利用したイベント計測について

会員登録や商品購入等がWebページで行われる場合に、imgタグを利用してイベント計測を利用することができます。<br>
F.O.Xのイベント計測は、外部ブラウザ、アプリ内WebViewの両方に対応しています。外部ブラウザの場合には[` trackEventByBrowser`](../sdk_api/README.md#foxtrack)メソッド、アプリ内WebViewの場合には[` enableWebViewTracking`](../sdk_api/README.md#foxconfig)メソッドを利用することで、F.O.Xがイベント計測に必要な情報をブラウザのCookieに記録します。

### 3.1 外部ブラウザによるイベント計測

アプリケーションから外部ブラウザを起動し、外部ブラウザで表示したWebページでタグ計測を行う場合は、`trackEventByBrowser`メソッドを利用して外部ブラウザを起動してください。引数には、外部ブラウザで表示するURLを文字列で指定します。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
[CYZFox trackEventByBrowser:@"http://www.host.com"];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
CYZFox.trackEventByBrowser("http://www.host.com")
```

### 3.2 アプリ内WebViewでのイベント計測について

ユーザーの遷移がWebView内で行われる場合には、初期化する際に`CYZConfig`の`enableWebViewTracking`を設定ことで計測することができます。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZConfig* foxConfig = [CYZConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"yyyyy"];
[foxConfig enableWebViewTracking];
[foxConfig activate];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let foxConfig:CYZConfig = CYZConfig.init(appId:0000, salt:"xxxxx", appKey:"yyyyy")!
foxConfig.enableWebViewTracking()
foxConfig.activate()
```

---
[トップ](../../README.md)
