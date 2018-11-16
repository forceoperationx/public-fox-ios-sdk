# About Force Operation X

Force Operation X (Hereinafter referred to as F.O.X) is a total solution platform which measures and optimizes ad effectiveness on smartphone applications. Primary features such as user install tracking, LTV measurement, and CV measurement, will maximize the price-performance ratio of your app's advertising.
<br>
This document is a manual for integrating the F.O.X SDK, a tool which maximizes the ad effectiveness for smartphone applications.
<br>
Find out more about F.O.X at [cyber-z.co.jp](https://cyber-z.co.jp/en/fox).

Read this in another language: [日本語](https://github.com/cyber-z/public-fox-ios-sdk/blob/4.x-master/lang/ja/README.md),[中文](https://github.com/cyber-z/public-fox-ios-sdk/blob/4.x-master/lang/zh-cn/README.md).


## Table of Contents

* **[1. Setting up the SDK](#install_sdk)**
	* [1.1 Setup with CocoaPods](#by_cocoapods)
	* [1.2 Setup with Carthage](#by_carthage)
	* [1.3 Manual Setup](#by_manual)
* **[2. General Settings](#setting_sdk)**
	* [2.1 Framework Settings](#setting_framework)
	* [2.2 About App Transport Security](#setting_ats)
	* [2.3 URL Scheme Settings](#setting_urlscheme)
	* [SDK API](./doc/sdk_api/README.md)
* **[3. F.O.X SDK Activation](#activate_sdk_into_app)**
	* [3.1 Framework Imports](#activate_import)
	* [3.2 Configuration](#activate_config)
* **[4. Implementing Install Tracking](#tracking_install)**
	* [Install tracking details](./doc/track_install/README.md)
	* [Implementing deferred-deeplink](./doc/deferred_deeplink/README.md)
* **[5. Re-engagement Measurement Implementation](#tracking_reengagement)**
	* [5.1 Re-engagement tracking with a Custom URL Scheme](#tracking_reengagement_scheme)
	* [5.2 Re-engagement tracking with a Universal Link](#tracking_reengagement_ulink)
* **[6. In-App Event Measurement](#tracking_event)**
	* [6.1 Session measurement](#tracking_session)
	* [6.2 Additional event measurement](#tracking_other_event)
	* [Event measurement details (engagement measurement, dynamic Ads integration...](./doc/track_events/README.md)
* **[7. Additional Feature Implementation](#other_function)**
	* [Enabling opt-out feature](./doc/optout/README.md)
* **[8. Frequent Troubleshooting Issues](#trouble_shooting)**
	* [FAQ・Notes](./doc/trouble_shooting/README.md)


## About F.O.X SDK
[![Platform](https://img.shields.io/badge/platform-iOS%20|%20tvOS-blue.svg?style=flat)](http://www.apple.com/ios/)
[![Language](https://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)]()
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)]()

By installing the F.O.X SDK, users can access the following features.

* **Install tracking**

Track and measure the number of installs along different advertising channels.

* **LTV measurement**

Measure Lifetime Value(LTV) along different advertising channels. Primary conversion points are member registrations, tutorial completions, and purchases. F.O.X monitors and maintains member registration rates, purchase rates, and purchase amounts per advertisement.

* **Site optimization analysis | Demographic analysis**

Compare organic and non-organic installs. Track app launches and unique users(DAU/MAU). Measure user retention and so on.

<div id="install_sdk"></div>

## 1. Setting up the SDK

<div id="by_cocoapods"></div>

### 1.1 Setup with CocoaPods

Edit your Podfile as displayed below.
* **objective-c**

```ruby
# Add this to the very beginning of your Podfile
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# Add this to any targets you wish to specify
pod "CYZFox", "<VERSION>"
```

* **tvOS objective-c**

```ruby
# Add this to the very beginning of your Podfile
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# Add this to any targets you wish to specify
pod "CYZFoxTv", "<VERSION>"
```

* **iOS Swift (dynamic framework)**

```ruby
# Add this to the very beginning of your Podfile
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# enable dynamic frameworks
use_frameworks!

pod "CYZFoxDy", "<VERSION>"
```

* **tvOS Swift (dynamic framework)**

```ruby
# Add this to the very beginning of your Podfile
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# enable dynamic frameworks
use_frameworks!

pod "CYZFoxTvDy", "<VERSION>"
```
> ※ `<VERSION>` is whatever release version you wish to specify (above 4.0.0)

<div id="by_carthage"></div>

### 1.2 Setup with Carthage

Add the following settings to your `Cartfile` file.
```
github "cyber-z/public-fox-ios-sdk" == <VERSION>
```
> ※ `<VERSION>` is whatever release version you wish to specify (above 4.0.0)

> ※ Carthage supports Target Versions 8.0 and above.

* __Migrating to 4.4.0__

  Up until version 4.3.0, three dynamic frameworks (`CYZFox`, `CYZAdCommon`, `CYZAdUtil`) are implemented but as of version 4.4.0 only one framework, `CYZFox.framework`, is implemented. Please remove your `CYZAdCommon` and `CYZAdUtil` files manually.

<div id="by_manual"></div>

### 1.3 Manual Setup

Download the `CYZFox_iOS_static_<VERSION>.zip` file from our [release page](https://github.com/cyber-z/public_fox_ios_sdk/releases) and build it into your Xcode project.

> ※ If you are already implementing version 3.X of our SDK, see ["Updating to the latest version"](./doc/update/README.md)

> ※ For tvOS, download the `CYZFox_tvOS_static_<VERSION>.zip` file. The integration process is the same as iOS.


<div id="setting_sdk"></div>

## 2. General Settings

Some Xcode settings must be changed to ensure the SDK functions properly.

<div id="setting_framework"></div>

### 2.1 Framework Settings

Link the following frameworks into your project.

<table>
<tr><th>Framework name</th><th>Status</th></tr>
<tr><td>UIKit.framework</td><td>Required</td></tr>
<tr><td>Foundation.framework</td><td>Required</td></tr>
<tr><td>Security.framework</td><td>Required</td></tr>
<tr><td>SystemConfiguration.framework</td><td>Required</td></tr>
<tr><td>WebKit.framework</td><td>Required</td></tr>
<tr><td>AdSupport.framework</td><td>Required</td></tr>
<tr><td>CoreTelephony.framework</td><td>Required</td></tr>
</table>

<div id="setting_ats"></div>

### 2.2 About App Transport Security

As of F.O.X SDK version 4.0.0, all tracking is performed using HTTPS, so there is no need to take additional measures with App Transport Security.

<div id="setting_urlscheme"></div>

### 2.3 URL Scheme Settings

Please be sure to set a customized URL scheme in order to perform  Cookie installation tracking and re-engagement measurement.

> ※ Depending on your production environment, there are cases where capitalized URL schemes are not recognized. In order to avoid this, please set your URL scheme in lower case alphanumeric characters.

> ※ Because it won't conflict with other apps, we recommend using a reverse domain (e.g. _`jp.co.company.product`_)


<div id="activate_sdk_into_app"></div>

## 3. F.O.X SDK Activation

<div id="activate_import"></div>

### 3.1 Framework Imports

Add the following import to use the API

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

In order to activate the F.O.X SDK, we need to implement the [`CYZFoxConfig`](./doc/sdk_api/README.md#foxconfig) class' configuration settings inside the didFinishLaunchingWithOptions method

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
    CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx").activate()
    // ...
}
```

> ※ You must absolutely implement the activation before any performing any tracking.

> ※ After your application has been registered, you may find the values for appID, salt, and appKey at F.O.X Dashboard App List > find your application from the dropdown list on the top right of the page > and check the SDK installation settings.


### 3.3 Offline Mode

The following are configuration settings on how to stop the F.O.X SDK from performing measurement and tracking. <br>
To enable OfflineMode set `CYZFoxConfig.offlineMode` to `YES`. To disable OfflineMode set it to `NO`.(By default, OfflineMode is disabled) <br/>

- If you want to enable OfflineMode based on a user's permission, run `CYZFoxConfig.activate` after the user has chosen to enable OfflineMode.
- `CYZFoxConfig.activate` must always be called on App launch.
- Once offline mode is set, it will persist until the application is uninstalled.

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxConfig* config = [CYZFoxConfig configWithAppId:0000 salt:@"xxxx" appKey:@"xxxx"];
if (!hasUserPermission) {
    config.offlineMode = YES;
}
[config activate];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let config = CYZFoxConfig.init(appId: 0000, salt: "xxxx", appKey: "xxxx")
if !hasUserPermission {
	config.isOfflineMode = true
}
config.activate()
```

<div id="tracking_install"></div>

## 4. Implementing Install Tracking

You can perform advertising effectiveness measurement by tracking the first application launch event.

By tracking the first application launch event using the new `SFSafariViewController` WebView released in iOS9, you can reduce the drop in usability from background display.

Implement the [`[CYZFox trackInstall]`](./doc/sdk_api/README.md#CYZFox) method displayed below inside the `didFinishLaunchingWithOptions` method. <br>
Additionally, because the `SFSafariViewController` is closed after the install tracking is performed, implement the `[CYZFox handleOpenURL:url]` inside the `-(BOOL)application:openURL:sourceApplication:annotation:` method.

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // ...
    [[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];
    [CYZFox trackInstall];
    // ...
    return YES; // In order to call the openURL: method, make sure this is set to YES
}

-(BOOL) application:(UIApplication *) application openURL:(nonnull NSURL *) url
sourceApplication:(nullable NSString *) sourceApplication annotation:(nonnull id) annotation {
    // ...
    [CYZFox handleOpenURL:url]; // Use when performing Cookie tracking or Re-engagement measurement
    // ...
    return YES;
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // ...
    CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx").activate()
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

> ※ Even if the trackInstall method is called multiple times it will not execute more than once.

> ※ You may define options on the trackInstall method. For further details see [Install Tracking details](./doc/track_install/README.md)

 * **Note on Fingerprinting**

If you customize a UserAgent when performing Fingerprinting measurement through a UIWebView/WKWebView, you will become unable to perform those measurements.
Before running any code that would customize your UserAgent, please enable the FOXConfig settings as shown below.

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
 ```objc
CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:000 salt:@"xxxxx" appKey:@"xxxx"];
[foxConfig enableCustomizedUserAgent];
[foxConfig activate];
 ```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)

```Swift
let foxConfig = CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx")
foxConfig.enableCustomizedUserAgent()
foxConfig.activate()
```

* [Install tracking details](./doc/track_install/README.md)
* [Implementing deferred-deeplink](./doc/deferred_deeplink/README.md)

<div id="tracking_reengagement"></div>

## 5. Re-engagement Measurement Implementation

<div id="tracking_reengagement_scheme"></div>

### 5.1 Re-engagement measurement with a Custom URL Scheme

In order to perform Re-engagement advertising measurement (measure app launches via URL Scheme), implement `[CYZFox handleOpenURL:url]` inside the `openURL` method of your `UIApplicationDelegate`.

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

> ※ In order to measure Re-engagement advertising, it is a pre-requisite that a custom URL scheme be defined in Info.plist.

<div id="tracking_reengagement_ulink"></div>

### 5.2 Re-engagement measurement with a Universal Link

In order to perform Re-engagement measurement with a Universal Link, implement `[CYZFox handleOpenURL:url]` in the `continueUserActivity` method, just as in [5.1](#tracking_reengagement_scheme).

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

> ※ If you want to use a custom URL Scheme and a Universal Link, then you must implement both.

<div id="tracking_event"></div>

## 6. In-App Event Measurement

<div id="tracking_session"></div>

### 6.1 Session measurement

In order to track app launch, or a return from the background, add the code below to `application:didFinishLaunchingWithOptions:` and `applicationWillEnterForeground`

※ Make sure session measurement (launch event) gets called after [Install Tracking](#tracking_install)

※ If you are using background fetch, the OS calls application:didFinishLaunchingWithOptions: each time the app is launched from the background. Please configure your applicationState so that the F.O.X session measurement method is not called.

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// ...
	//install tracking
	[CYZFox trackInstall];
	// ...

    if ([application applicationState] == UIApplicationStateBackground) {
        // arbitrary source run when the application is coming from the background
    } else {
        // call trackSession only when the application is not in the background
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
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool{// ...
	// install tracking
	CYZFox.trackInstall()
	// ...

    if application.applicationState == UIApplicationState.background {
        // arbitrary source run when the application is coming from the background
    } else {
        // call trackSession only when the application is not in the background
        CYZFox.trackSession()
    }
}

func applicationWillEnterForeground(_ application: UIApplication) {
    CYZFox.trackSession()
}
```

<div id="tracking_other_event"></div>

### 6.2 Session measurement

By measuring app events such as member registrations, tutorial completions, In-App Purchases and other such conversion points, you can track the LTV of individual advertisements. <br>
When event tracking is not required, you can omit the implementation of this item.

※ Make sure any event tracking code gets called after [Install Tracking](#tracking_install) and [Session-start Measurement](#tracking_session)

**[Tutorial event measurement example]**

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

> In order to measure each event, you need to specify the `conversion point ID` that identifies each conversion point. Please specify the event name and issued ID as an argument in the [`CYZFoxEvent`](./doc/sdk_api/README.md#foxevent) class' constructor.

**[In-App Purchase example]**

When measuring purchase events, please specify the purchase amount and currency code at the point where the transaction completes as follows:

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
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_purchase")
event.price = 99
event.currency = "JPY"
event.sku = "itemId"
CYZFox.trackEvent(event)
```

Please specify the currency code as defined in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217)

[Event measurement details (engagement measurement, dynamic Ads integration...](./doc/track_events/README.md)

<div id="other_function"></div>

## 7. Additional Feature Implementation

* [Enabling opt-out feature](./doc/optout/README.md)

<div id="trouble_shooting"></div>

## 8. Frequent Troubleshooting Issues

* [FAQ・Notes](./doc/trouble_shooting/README.md)

---
[Main menu](/README.md)
