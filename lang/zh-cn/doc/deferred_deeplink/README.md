[TOP](../../README.md)　>　Deferred Deeplink的执行

---

# Deferred Deeplink的执行

通过安装Deferred Deeplink处理，可以在点击广告时跳转到绑定的Deferred Deeplink，以此来跳转到APP内的目标页面。此外，即使APP没有安装，也可以使用Deeplink让用户在经过广告安装进入APP后跳转到指定的页面。

> 支持版本: 4.1.0及以上

下面针对Defferred Deeplink的代码安装所需的类和方法进行说明。

## FoxTrackOption

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|deferredDeeplinkHandler|Block|取得Defferred Deeplink时调用的Callback方法。|
|durationSinceClick|NSTimeInterval|使用Defferred Deeplink访问服务器的时候，作为对象的Last Click的期间(秒)（按秒数来指定追溯到多久以前）。不设定的话，默认为24小时。|

* `deferredDeeplinkHandler`的详细

`void (^deferredDeeplinkHandler)(NSDictionary* _Nullable deeplinkInfo)`

`deeplinkInfo` : NSDictionary、JSON类型的deeplink信息。Defferred Deeplink不存在或者终端通信失败的时候，返回NULL。

* `deeplinkInfo`的详细 :

  |Key|Type|Detail|
  |:---|:---|:---|
  |deeplink|String|取得的Deeplink字符串|

## 代码安装范例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxTrackOption* option = [CYZFoxTrackOption new];
option.durationSinceClick = 60 * 60 * 12;
option.deferredDeeplinkHandler = ^(NSDictionary* deeplinkInfo) {
    NSString* url = [deeplinkInfo objectForKey:@"deeplink"];
    NSLog(@"app received url %@", url);
    if (url) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
};
[CYZFox trackInstallWithOption:option];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```swift
let foxTrackOption = CYZFoxTrackOption()
foxTrackOption.durationSinceClick = TimeInterval(60 * 60 * 12)
foxTrackOption.deferredDeeplinkHandler = { deeplinkInfo in
    if let deeplink = deeplinkInfo?["deeplink"] as? String,
        let url = URL(string: deeplink) {
        UIApplication.shared.openURL(url)
    }
    return
}
CYZFox.trackInstall(with: foxTrackOption)
```

---
[Top](../../README.md)
