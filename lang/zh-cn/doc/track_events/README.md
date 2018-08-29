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
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_register_account", ltvId:0000)
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
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_tuturial_comp", ltvId:0000)
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
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_purchase")
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

在页面上发生会员注册及商品购买等行为时，可以使用img tag或是原生方法来进行事件计测。<br>
F.O.X的事件计测适用于外部浏览器和APP内页面。外部浏览器使用[` trackEventByBrowser`](../sdk_api/README.md#foxtrack)方法、APP内页面请从WKWebView执行原生方法，或是使用[` enableWebViewTracking`](../sdk_api/README.md#foxconfig)方法，F.O.X会在页面Cookie中记录事件计测所需的信息。

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
### 3.2.1 从WebView中执行原生（Native）API（推荐）

使用WKWebView提供的结构，经由JavaScript执行原生API。

参考URL:
https://developer.apple.com/documentation/webkit/wkscriptmessagehandler

原生的范例源代码

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
@interface ViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"sendFoxEvent"];
    cfg.userContentController = userContentController;

    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) configuration:cfg];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;

    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];

    NSURL *url = [NSURL URLWithString:@"https://hoge"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:req];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
  NSString *command = message.body[@"command"];
  NSString *event_name = message.body[@"event_name"];
  int ltvid = [message.body[@"ltvid"] intValue];

  if ([command compare:@"foxEvent"] == NSOrderedSame) {
      CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:event_name ltvId:ltvid];
      [CYZFox trackEvent:event];
  }
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)

```Swift
class ViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let cfg:WKWebViewConfiguration = WKWebViewConfiguration()
        let userController:WKUserContentController = WKUserContentController()
        userController.add(self, name:"sendFoxEvent")
        cfg.userContentController = userController

        webView = WKWebView(frame:self.view.bounds, configuration: cfg)
        self.view = self.webView!

        let url = URL(string:"https://hoge")
        let req = NSURLRequest(url:url!)
        webView.load(req as URLRequest)
    }

    func userContentController(_ userContentController:WKUserContentController, didReceive message: WKScriptMessage) {
      guard let body = message.body as? [String: Any] else { return }
      guard let command = body["command"] as? String else { return }
      guard let event_name = body["event_name"] as? String else { return }
      guard let ltvid = body["ltvid"] as? Int else { return }

      if command == "foxEvent" {
          if let ltvId = body["ltvid"] as? UInt {
              let event:CYZFoxEvent = CYZFoxEvent.init(eventName:event_name,ltvId:ltvId)
              CYZFox.trackEvent(event)
          }
      }
    }
}
```

JavaScript的的范例源代码
```Html
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
  <script type="text/javascript">
  var message = {
    command: 'foxEvent',
    event_name: 'webview_event',
    ltvid: 0000
  };
  webkit.messageHandlers.sendFoxEvent.postMessage(message);
  </script>
</body>
</html>
```

### 3.2.2 同步Cookie执行（不推荐）
计测UIWebView内的用户行动时，请设定`CYZFoxConfig`的`enableWebViewTracking`。
从iOS 12开始，UIWebView将会Deprecated，今后较为推荐3.2.1的安装方法。


![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"yyyyy"];
[foxConfig enableWebViewTracking];
[foxConfig activate];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let foxConfig:CYZFoxConfig = CYZFoxConfig.init(appId:0000, salt:"xxxxx", appKey:"yyyyy")
foxConfig.enableWebViewTracking()
foxConfig.activate()
```

---
[Top](../../README.md)
