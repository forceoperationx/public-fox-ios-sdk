# 什么是Force Operation X

Force Operation X（以下简称F.O.X）是一款用于优化智能手机广告效果的整体解决方案平台。不光是App的下载和网页用户行为的计测，基于智能用户行为特征的独特计测基准，能够实现企业推广的性价比最大化。

本文件是为实现智能手机app中广告效果最大化的安装F.O.X SDK安装说明书。

## 目录

* **[1. 导入](#install_sdk)**
	* [1.1 使用CocoaPods导入](#by_cocoapods)
	* [1.2 使用Carthage导入](#by_carthage)
	* [1.3 手动导入](#by_manual)
* **[2. 设置](#setting_sdk)**
	* [2.1 Framework设置](#setting_framework)
	* [2.2 关于App Transport Security](#setting_ats)
	* [2.3 URL scheme设置](#setting_urlscheme)
	* [SDK API](./doc/sdk_api/README.md)
* **[3. 激活F.O.X SDK](#activate_sdk_into_app)**
	* [3.1 Framework类库的导入](#activate_import)
	* [3.2 Configuration](#activate_config)
* **[4. 执行Install计测](#tracking_install)**
	* [Install计测的详情](./doc/track_install/README.md)
	* [Deferred Deeplink的安装](./doc/deferred_deeplink/README.md)
* **[5. 执行流失唤回广告计测](#tracking_reengagement)**
	* [5.1 使用自定义URL Scheme计测](#tracking_reengagement_scheme)
	* [5.2 使用Universal Link计测](#tracking_reengagement_ulink)
* **[6. APP内事件计测](#tracking_event)**
	* [6.1 session（启动事件）计测](#tracking_session)
	* [6.2 其他APP内事件计测](#tracking_other_event)
	* [事件计测详情](./doc/track_events/README.md)
* **[7. 执行其他功能](#other_function)**
	* [执行optout](./doc/optout/README.md)
* **[8. 最后的注意事项](#trouble_shooting)**


## 什么是F.O.X SDK
[![Platform](https://img.shields.io/badge/platform-iOS%20|%20tvOS-blue.svg?style=flat)](http://www.apple.com/ios/)
[![Language](https://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)]()
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)]()

将F.O.X SDK导入app之后，能够实现以下功能。

* **Install计测**

能够计测不同广告带来的安装数。

* **LTV计测**

可以计测不同广告来源的Life Time Value。主要的成果地点为会员注册、新手引导完成、付费等。能够分别监测和统计各广告的登录率、付费率以及付费金额。

* **流量分析**

比较自然流量和广告流量带来的安装。能够计测App的启动次数和unique用户数(DAU/MAU)、留存率等。


<div id="install_sdk"></div>

## 1. 安装

<div id="by_cocoapods"></div>

### 1.1 使用CocoaPods导入

请按下列方法更新Podfile文件。
* **使用iOS objective-c开发的场合**
```ruby
# 请将下列内容添加在Podfile的最前端
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# 请将下列内容添加在指定目标中
pod "CYZFox", "<VERSION>"
```

* **使用tvOS objective-c开发的场合**
```ruby
# 请将下列内容添加在Podfile的最前端
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# 请将下列内容添加在指定目标中
pod "CYZFoxTv", "<VERSION>"
```

* **iOS Swift中使用dynamic framework的场合**
```ruby
# 请将下列内容添加在Podfile的最前端
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# 使dynamic framework有效
use_frameworks!

pod "CYZFoxDy", "<VERSION>"
```

* **tvOS Swift中使用dynamic framework的场合**
```ruby
# 请将下列内容添加在Podfile的最前端
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# 使dynamic framework有效
use_frameworks!

pod "CYZFoxTvDy", "<VERSION>"
```
> ※ `<VERSION>`为想要指定的4.0.0以上发行版本。

<div id="by_carthage"></div>

### 1.2 使用Carthage导入

Cartfile文件中添加以下内容。
```
github "cyber-z/public-fox-ios-sdk" == <VERSION>
```
> ※ `<VERSION>`为想要指定的4.0.0以上发行版本。

> ※ Carthageの場合Target VersionはiOS 8.0以上に指定する必要となります。

<div id="by_manual"></div>

### 1.3 手动导入

[发行页面](https://github.com/cyber-z/public_fox_ios_sdk/releases)中下载并解压`CYZFox_iOS_static_<VERSION>.zip`，将`CYZFox.framework`文件安装到Xcode项目中。

> ※ 如果APP中已经安装了SDK，请参考[新版本的更新说明](./doc/update/README.md)。

> ※ tvOS的场合请下载`CYZFox_tvOS_static_<VERSION>.zip`。导入步骤与iOS相同。


<div id="setting_sdk"></div>

## 2. 设置

进行SDK操作所需的Xcode设置。

<div id="setting_framework"></div>

### 2.1 Framework设置

请将以下架构连接到项目中。

<table>
<tr><th>架构名</th><th>Status</th></tr>
<tr><td>UIKit.framework</td><td>Required</td></tr>
<tr><td>Foundation.framework</td><td>Required</td></tr>
<tr><td>Security.framework</td><td>Required</td></tr>
<tr><td>SystemConfiguration.framework</td><td>Required</td></tr>
<tr><td>WebKit.framework</td><td>Required</td></tr>
<tr><td>AdSupport.framework</td><td>Optional</td></tr>
</table>

<div id="setting_ats"></div>

### 2.2 App Transport Security设置

从F.O.X SDK ver4.0.0开始，底层全部都基于HTTPS协议进行通信，不需要做额外的对应。

<div id="setting_urlscheme"></div>

### 2.3 URL scheme设置

为进行Cookie安装计测和流失唤回广告计测，请务必添加自定义URL scheme设置。

> ※ 根据运行环境，可能会有URL SCHEME的大小写文字不能识别而导致无法迁移的情况。请将URL SCHEME全部设置为小写英文字母或数字或小数点。

> ※ 为了防止与其他APP冲突，建议使用反向域名(例 _`jp.co.company.product`_ )。


<div id="activate_sdk_into_app"></div>

## 3. 激活F.O.X SDK

<div id="activate_import"></div>

### 3.1 Framework类库的导入

为使用API，请添加下列import。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
#import <CYZFox/CYZFox.h>
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
import CYZFox
```

<div id="activate_config"></div>

### 3.2 Configuration

为激活F.O.X SDK，请在didFinishLaunchingWithOptions方法内进行[`CYZFoxConfig`](./doc/sdk_api/README.md#foxconfig)类的configuration配置。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // ...
    [[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];
    // ...
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // ...
    CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx")!.activate()
    // ...
}
```

> ※ 激活的配置必须在所有计测开始前进行。


<div id="tracking_install"></div>

## 4. 执行Install计测

进行首次启动的Install计测，可以计测广告效果。
F.O.X SDK在首次启动时，使用从iOS9版本开始发行的新WebView形式 `SFSafariViewController` 进行计测，可以防止后台跳转带来的用户体验变差的问题。

下列[`[CYZFox trackInstall]`](./doc/sdk_api/README.md#CYZFox)方法在APP启动时，在`didFinishLaunchingWithOptions`方法中执行。
使用`SFSafariViewController`进行安装计测后，为关闭`SFSafariViewController`，请在`-(BOOL)application:openURL:sourceApplication:annotation:`方法内、执行`[CYZFox handleOpenURL:url]`。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // ...
    [[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];
    [CYZFox trackInstall];
    // ...
	return YES; // openURL:为呼出方法，请务必返回YES
}

-(BOOL) application:(UIApplication *) application openURL:(nonnull NSURL *) url
sourceApplication:(nullable NSString *) sourceApplication annotation:(nonnull id) annotation {
    // ...
    [CYZFox handleOpenURL:url]; // 使用Cookie计测或流失唤回广告计测的场合
    // ...
    return YES;
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // ...
    CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx")!.activate()
    CYZFox.trackInstall()
    // ...
    return true
}

func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    // ...
    CYZFox.handleOpen(url)
    // ...
    return true
}

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    CYZFox.handleOpen(url)
    return true
}
```

> ※ 第２次以后，即使呼出trackInstall方法也没有任何操作。

> ※ trackInstall方法中可以指定Option参数。详情请参考[Install计测详情](./doc/track_install/README.md)。

 * **Fingerprinting计测时的注意事项**

 Fingerprinting计测使用UIWebView，如果使用UserAgent独特的自定义方法可能会导致无法正常计测。
 按下列内容，在进行UserAgent自定义处理前做好FOXConfig的配置。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
 ```objc
CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:000 salt:@"xxxxx" appKey:@"xxxx"];
[foxConfig enableCustomizedUserAgent];
[foxConfig activate];
 ```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)

```Swift
let foxConfig = CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx")!
foxConfig.enableCustomizedUserAgent()
foxConfig.activate()
```

* [Install计测详情](./doc/track_install/README.md)
* [Deferred Deeplink的安装](./doc/deferred_deeplink/README.md)

<div id="tracking_reengagement"></div>

## 5. 执行流失唤回广告计测

<div id="tracking_reengagement_scheme"></div>

### 5.1 依靠定制化URL Scheme进行计测

为进行流失唤回广告广告的计测（计测经由URL SCHEME的启动行为），需在`UIApplicationDelegate`的`openURL`方法中执行`[CYZFox handleOpenURL:url]`。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application openURL:(nonnull NSURL *) url
sourceApplication:(nullable NSString *) sourceApplication annotation:(nonnull id) annotation {
    // ...
    [CYZFox handleOpenURL:url];
    // ...
    return YES;
}

-(BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // ...
    [CYZFox handleOpenURL:url];
    // ...
    return YES;
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    // ...
    CYZFox.handleOpen(url)
    // ...
    return true
}

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    // ...
    CYZFox.handleOpen(url)
    // ...
    return true
}
```

> ※ 进行流失唤回广告计测时，必须在Info.plist里事先自定义好URL scheme。

<div id="tracking_reengagement_ulink"></div>

### 5.2 使用Universal Link计测

适用Universal Link的场合、在`continueUserActivity`方法中 和[5.1](#tracking_reengagement_scheme) 一样执行`[CYZFox handleOpenURL:url]`。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application continueUserActivity:(NSUserActivity *) userActivity
restorationHandler:(void (^)(NSArray *restorableObjects)) restorationHandler {
    // ...
    [CYZFox handleOpenURL:userActivity.webpageURL];
    // ...
    return YES;
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    // ...
    if let url = userActivity.webpageURL {
        CYZFox.handleOpen(url)
    }
    // ...
    return true
}
```

> ※ 如果希望对应自定义URL Scheme和Universal Link，必须两边都做代码安装。

<div id="tracking_event"></div>

## 6. APP内事件计测

<div id="tracking_session"></div>

### 6.1 session（启动事件）计测

计测APP启动以及后台恢复时，需在代码中添加application:didFinishLaunchingWithOptions:およびapplicationWillEnterForeground。

※使用后台获取的场合，后台启动时OS呼出application:didFinishLaunchingWithOptions:。为使后台不呼出启动计测F.O.X方法，请在applicationState中进行状态判定。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    If ([application applicationState] == UIApplicationStateBackground) {
        //APP在后台运行时的处理
    } else {
        //APP在后台运行时不调用启动计测处理
        [CYZFox trackSession];
    }

    // ...
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [CYZFox trackSession];
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool{
    if application.applicationState == UIApplicationState.background {
        //APP在后台运行时的处理
    } else {
        //APP在后台运行时不调用启动计测处理
        CYZFox.trackSession()
    }
}

func applicationDidEnterBackground(_ application: UIApplication) {
    CYZFox.trackSession()
}
```

<div id="tracking_other_event"></div>

### 6.2 其他APP内事件计测

通过在会员注册、新手引导突破、付费等任意成果地点中执行事件计测，可以测定广告来源LTV。<br>如不需要事件计测时，可以忽略本项。

**[新手引导事件的计测案例]**

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

> 进行event计测时，需指定识别成果地点的成果地点ID。[`CYZFoxEvent`](./doc/sdk_api/README.md#foxevent)类的构造函数的引数中请指定事件名和生成的ID。

**[付费事件的计测案例]**

进行付费计测时，请在付费完成的位置指定付费金额和货币代码。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_purchase"];
event.price = 99;
event.currency = @"JPY";
event.sku = @"itemId";
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

currency请指定[ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217)认证的货币代码。

[事件计测详情](./doc/track_events/README.md)

<div id="other_function"></div>

## 7. 执行其他功能

* [执行optout](./doc/optout/README.md)

<div id="trouble_shooting"></div>
## 8. 最后的注意事项（常见问题集）

### 8.1. F.O.X中使用的bundle版本是什么？

iOS中，bundle版本具体为以下两种。

* CFBundleVersion
* CFBundleShortVersionString

F.O.X中，上述中CFBundleShortVersionString的值作为管理目的而使用。

### 8.2. 期待的广告安装数比报表数据低

安装计测的`trackInstall:`及`trackInstallWithOption:`若不在启动后马上执行，在到达地点前离开的用户会被遗漏计测。

`trackInstall:`和`trackInstallWithOption:`在没有特殊情况时，请在`application:didFinishLaunchingWithOptions:`内执行。在其他位置执行可能会导致安装数无法正确计测。

在`application:didFinishLaunchingWithOptions:`中未安装代码的状态投放成果型广告时，请务必告知广告代理店或媒体公司负责人。无法进行正确计测的状态投放成果型广告时，可能会导致需要支付超出实际安装数的广告费用。

### 8.3. 未设置URL SCHEME的APP上线发布后无法从浏览器跳转至APP

进行Cookie计测时启动浏览器以后，必须使用URL scheme跳转回到APP画面。此时需要设置URL scheme，未设置scheme就上线发布时会导致无法正常迁移。

### 8.4. URL SCHEME中含有大写字母时，无法正常迁移app。

根据运行环境，会出现因为URL SCHEME 的大小写字母不能判定而导致URL SCHEME 无法正常迁移的情况。请将URL SCHEME 全部设置为小写英文或数字或小数点。

### 8.5. URL scheme设置与其他公司APP相同时，浏览器跳转了其他APP

iOS中，多个APP设置为同一个URL scheme时，会随机启动APP。由于可能导致无法启动指定的APP，请将URL scheme区别与其他APP来设定。

### 8.6. 进行短时间内获取大量用户的推广无法正确计测

iOS中，APP启动时超过一定时间主线程被阻止运行时，会强制关闭APP。请注意不要让启动时的初始化处理在主线程上与服务器同时进行通讯。短时间内获得大量用户的激励广告等会因为集中访问服务器，通讯回复较差而导致APP启动时间延长或强制关闭等情况，从而导致无法正确计测广告结果。

按照以下步骤可以进行以上情况的测试，请进行以下设置，确认APP是否正常启动。

`iOS「设置」→「开发者」→「NETWORK LINK CONDITIONER」`

* 「Enable」设置为on
* 勾选「Very Bad Network」

---
[Main Menu](/README.md)
