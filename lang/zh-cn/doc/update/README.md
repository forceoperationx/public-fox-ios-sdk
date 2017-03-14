[TOP](../../README.md)　>　更新到最新版本    

---

## 更新到最新版本

以前导入过旧版F.O.X SDK的APP中导入最新SDK时，请按照以下的顺序进行。

### 1. SDK替换
如果项目中安装了以下文件，请将其删除。
* AppAdForce.plist
* libAppAdForce.a
* AdManager.h
* AnalyticsManager.h
* Ltv.h
* Notify.h
* libFoxSdk.a
* DLAdStateDelegate.h
* DLBannerView.h
* DLInterstitialViewController.h

「[1. 安装](../../../README.md#install_sdk)」中按照文档指示再次执行导入步骤。

#### CocoaPods的场合
Podfile中将以下指示
```ruby
pod "foxSdk"
```
更改为以下内容。
```ruby
pod "CYZFox"
```

#### Swift的场合
Bridging header文件中与FOX SDK相关header的import全部删除。
```objc
// 删除下列内容
#import "AdManager.h"
#import "Ltv.h"
#import "AnalyticsManager.h"
```

### 2. 更改源代码
#### 2.1 import
4.0.0版本开始使用framework libraryのextension，将以前header的import更改为以下内容。
```objc
#import <CYZFox/CYZFox.h>
#import <FOXExtension/FOXExtension.h> // 需要时添加
```
#### 2.2 计测执行位置
|计测|4.0.0以前的版本|4.0.0以后的版本|
|---|---|---|
|基础设置|AppAdForce.plist记载项:<br/>`APP_ID`<br/>`APP_SALT`<br/>`ANALYTICS_APP_KEY`|CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:4879<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;salt:@"xxxxx" <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;appKey:@"yyyyyy"];<br/>[foxConfig activate];|
|服务器URL指定|AppAdForce.plist记载项:<br/>`SERVER_URL`<br/>`ANALYTICS_SERVER_URL`|[foxConfig withFOXServerURL:@"xxxxx"];<br>[foxConfig withAnalyticsServerURL:@"yyyyy"];<br>[foxConfig activate];
|DEBUG模式指定|[adManager setDebugMode:YES]|[foxConfig enableDebugMode];<br>[foxConfig activate];
|使用UIWebView指定计测|[ltv setLtvCookie]|[foxConfig enableWebViewTracking];<br>[foxConfig activate];
|Install计测|[adManager sendConversionWithStartpage:@"default"]|[CYZFox trackInstall]|
|流失唤回广告计测|[adManager setUrlScheme:url]|[CYZFox handleOpenURL:url]|
|session计测|[ForceAnalyticsManager sendtrackSession];|[CYZFox trackSession]|
|事件计测<br/>(付费)|[ltv addParameter:LTV_PARAM_PRICE :@"9.99"];<br/>[ltv addParameter:LTV_PARAM_CURRENCY :@"USD"]<br/>[ltv sendLtv:123]<br/> [AnalyticsManager trackEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:nil price:9.99 quantity:1 currency:@"USD";|CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"purchase" andLtvId:123];<br/>event.price = 9.99;<br/>event.currency = @"USD";<br/>[CYZFox trackEvent:event];|
|事件计测<br/>(新手指导完成)|[AnalyticsManager trackEvent:@"Tutorial" action:nil label:nil value:0]|[CYZFox trackEvent:[[CYZFoxEvent alloc] initWithEventName:@"Tutorial"]];|



SDK 更新后，请务必实行效果测试，并确认计测及APP动作没有问题。
> ※1 请注意，迁移到4.0.0以上的版本时，如果修改旧版本的`事件名`，将无法保留流量分析中到现在为止计测到的数据。

---
[Top](../../README.md)
