[TOP](../../README.md)　>　Updating to the latest version

---

## Updating to the latest version

Instructions for how to upgrade to the latest version of the F.O.X SDK.

### 1. SDK Reinstallation
Delete all of the following files built into your project.
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

Reinstall the SDK according to the instructions in 「[1. Installation](../../README.md#install_sdk)」

#### Using CocoaPods
Specify the following in your Podfile.<br>

**BEFORE**
```ruby
pod "foxSdk"
```
**AFTER** (Change to these settings)
```ruby
pod "CYZFox"
```

#### Using Swift
Delete any FOX SDK related import headers contained in your Bridging header file.
```objc
// delete the following
#import "AdManager.h"
#import "Ltv.h"
#import "AnalyticsManager.h"
```

### 2. Source changes
#### 2.1 import
As we've adopted the use of framework library extensions as of version 4.0.0, make the following changes
to your each of your header's imports.

```objc
#import <CYZFox/CYZFox.h>
#import <FOXExtension/FOXExtension.h> // add as needed
```
#### 2.2 Tracking Implementation Items
|Tracking type|Before 4.0.0|4.0.0 and above|
|---|---|---|
|Basic Settings|AppAdForce.plist entries:<br/>`APP_ID`<br/>`APP_SALT`<br/>`ANALYTICS_APP_KEY`|CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:4879<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;salt:@"xxxxx" <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;appKey:@"yyyyyy"];<br/>[foxConfig activate];|
|Set Server URL|AppAdForce.plist entries:<br/>`SERVER_URL`<br/>`ANALYTICS_SERVER_URL`|Setting not necessary
|Set DEBUG Mode|[adManager setDebugMode:YES]|[foxConfig enableDebugMode];<br>[foxConfig activate];
|UIWebView Tracking|[ltv setLtvCookie]|[foxConfig enableWebViewTracking];<br>[foxConfig activate];
|Install Tracking|[adManager sendConversionWithStartpage:@"default"]|[CYZFox trackInstall]|
|Re-engagement Tracking|[adManager setUrlScheme:url]|[CYZFox handleOpenURL:url]|
|Session Tracking|[ForceAnalyticsManager sendStartSession];|[CYZFox trackSession]|
|Event Tracking<br/>(In-App Purchase)|[ltv addParameter:LTV_PARAM_PRICE :@"9.99"];<br/>[ltv addParameter:LTV_PARAM_CURRENCY :@"USD"]<br/>[ltv sendLtv:123]<br/> [AnalyticsManager sendEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:nil price:9.99 quantity:1 currency:@"USD";|CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"purchase" ltvId:123];<br/>event.price = 9.99;<br/>event.currency = @"USD";<br/>[CYZFox trackEvent:event];|
|Event Tracking<br/>(Tutorial Completion)|[AnalyticsManager sendEvent:@"Tutorial" action:nil label:nil value:0]|[CYZFox trackEvent:[[CYZFoxEvent alloc] initWithEventName:@"Tutorial"]];|


Make sure you test for any bugs/abnormalities as well as measurement tests after updating the SDK.
> `※1` <strong>WARNING:</strong> When migrating from any version before 4.0.0, be sure not to change the `event name` used for measuring In-App purchases. If such a change occurs, any data collected before the migration will lose its integrity.

---
[Return to Top](../../README.md)
