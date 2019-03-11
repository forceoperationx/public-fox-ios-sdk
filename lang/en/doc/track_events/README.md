[TOP](../../README.md)　>　Event measurement details

---

# Event measurement details

These are the instructions for implementing additional events. <br>
Implementation instructions for engagement measurement and dynamic Ads integration are included. By implementing the following, your app will be able to measure events regardless of individual media.

* **[1. Examples of each app event](#each_event_sample)**
* **[2. Changing Implementation from a previous version(Engagement measurement)](#continuity)**
* **[3. Event tracking by tag](#track_by_tag)**

<div id="each_event_sample"></div>

## 1. Examples of each app event

#### 1.1 Member registration tracking example

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

#### 1.2 Tutorial completion event tracking example

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_tutorial_comp" andLtvId:0000];
event.buid = @"User ID";
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_tutorial_comp", ltvId:0000)
event.buid = "User ID"
CYZFox.trackEvent(event)
```

#### 1.3 In-App Purchase Event Tracking example

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

## 2. Changing Implementation from a previous version(Engagement measurement)

It is possible to continue using the same implementation methods for engagement measurement as versions before 4.0.0.<br>
See the In-App purchase event engagement measurement implementation below.

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

## 3. Event Tracking by tag

When membership registration, product purchase, etc. are completed on a web page, event measurement can be performed using an `img` tag.<br>
There are two ways for doing this.
For external browsers, see the [`trackEventByBrowser`](../sdk_api/README.md#foxtrack) method.
For web views, either run a native method from the WKWebView, or see the [`enableWebViewTracking`](../sdk_api/README.md#foxconfig) method.
By using either of these two methods, F.O.X can insert the data it needs in the cookies of the browser.

### 3.1 Event Tracking by external browser

When using tags to track events in an external browser launched by your app, use the `trackEventByBrowser` method to launch the external browser.<br>
The arguments will be composed of strings from the external browser's URL.

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
[CYZFox trackEventByBrowser:@"http://www.host.com"];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
CYZFox.trackEventByBrowser("http://www.host.com")
```

### 3.2 Event Tracking by web view

<div id="native_api_webview"></div>

#### Executing the Native API from a WebView

Use the functionality of the WKWebView and execute the native API with Javascript

reference URL:
https://developer.apple.com/documentation/webkit/wkscriptmessagehandler


**native code sample:**

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
@interface ViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"sendFoxEvent"]; // set the handler name to sendFoxEvent
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
        userController.add(self, name:"sendFoxEvent") // set the handler name to sendFoxEvent
        cfg.userContentController = userController

        webView = WKWebView(frame:self.view.bounds, configuration: cfg)
        self.view = self.webView!

        let url = URL(string:"https://hoge")
        let req = NSURLRequest(url:url!)
        webView.load(req as URLRequest)
    }

    // method called by the WebView
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


**JavaScript sample code:**
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

---
[Return to Top](../../README.md)
