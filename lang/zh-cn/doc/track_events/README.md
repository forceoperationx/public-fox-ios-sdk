[TOP](../../README.md)　>　事件计测的详细

---

# 事件计测详细


以下为执行各类事件时的详细说明。<br>
包含一般广告计测及动态投放时所需的执行任务。实现执行任务后可以进行跨媒体事件监测。

* **[1. APP内各类事件的执行案例](#each_event_sample)**
* **[2. 替换旧版执行任务（一般广告计测）](#continuity)**
* **[3. 使用标签(tag)进行事件计测](#track_by_tag)**

<div id="each_event_sample"></div>
## 1. APP内各类事件的执行案例

#### 1.1 计测会员注册事件 执行案例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_register_account" andLtvId:0000];
event.buid = @"User ID";
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_register_account", ltvId:0000)!
event.buid = "User ID"
CYZFox.trackEvent(event)
```

#### 1.2 计测新手引导完成事件 执行案例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_tuturial_comp" andLtvId:0000];
event.buid = @"User ID";
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_tuturial_comp", ltvId:0000)!
event.buid = "User ID"
CYZFox.trackEvent(event)
```

#### 1.3 计测付费事件 执行案例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_purchase" andLtvId:0000];
event.buid = @"User ID";
event.price = 99;
event.currency = @"JPY";
event.sku = @"itemId"
event.quantity = 2;
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_purchase")!
event.price = 99
event.currency = "JPY"
event.sku = "itemId"
CYZFox.trackEvent(event)
```

<div id="continuity"></div>
## 2. 替换旧版执行任务（一般广告计测）

可沿用F.O.X Android SDK 3.0.0之前版本的执行方式。<br>
以下为计测付费事件的执行案例。

**执行案例**

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
## 3. 使用标签（tag）进行事件计测

在页面上发生会员注册及商品购买等行为时，可以使用img tag来进行事件计测。<br>
F.O.X的事件计测适用于外部浏览器和APP内页面。外部浏览器使用[` trackEventByBrowser`](../sdk_api/README.md#foxtrack)方法、APP内页面使用[` enableWebViewTracking`](../sdk_api/README.md#foxconfig)方法，F.O.X会在页面Cookie中记录事件计测所需的信息。

### 3.1 外部浏览器中的事件计测

从APP跳转至外部浏览器，利用跳转的网页进行tag计测时，请使用`trackEventByBrowser`方法来启动外部浏览器，并在参数中用字符串设置要跳转的URL。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
[CYZFox trackEventByBrowser:@"http://www.host.com"];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
CYZFox.trackEventByBrowser("http://www.host.com")
```

### 3.2 APP内WebView中的事件计测

用户跳转发生在WebView内的时候，初始化时通过设置`CYZFoxConfig`的`enableWebViewTracking`可以实现计测。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"yyyyy"];
[foxConfig enableWebViewTracking];
[foxConfig activate];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let foxConfig:CYZFoxConfig = CYZFoxConfig.init(appId:0000, salt:"xxxxx", appKey:"yyyyy")!
foxConfig.enableWebViewTracking()
foxConfig.activate()
```

---
[Top](../../README.md)
