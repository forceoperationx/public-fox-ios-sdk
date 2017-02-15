# About the Force Operation X

Force Operation X (Hereinafter referred to as F.O.X) is total solution platform optimizing the ad effectiveness on Smartphone. Including downloading application and the calculation of user's' actions, it is able to maximize the price-performance ratio of companies' promotion according to criteria of original effective measurements based on behavior characteristics of Smartphone users.

This documents instructs the integration procedures of F.O.X. SDK to maximize the ad effectiveness on Smartphone application.

## Table of contents

* **[1. Install SDK](#install_sdk)**
	* [SDK download](https://github.com/cyber-z/public-fox-ios-sdk/releases)
	* [Install procedure](./doc/integration/README.md)
* **[2. Settings](#setting_sdk)**
	* [SDK Configuration](./doc/config_plist/README.md)
* **[3. Implement install tracking](#tracking_install)**
	* [The detail of sendConversionWithStartPage:](./doc/send_conversion/README.md)
* **[4. Implement LTV tracking](#tracking_ltv)**
	* [LTV tracking by using tag](./doc/ltv_browser/README.md)
* **[5. Implement access analytics](#tracking_analytics)**
	* [Event tracking by using access analytics](./doc/analytics_event/README.md)
	* [Purchase-event tracking by using access analytics](./doc/analytics_purchase/README.md)
* **[6. Integration test](#integration_test)**
	* [Integration test for measuring reengagement](./doc/reengagement_test/README.md)
* **[7. Implement other function](#other_function)**
	* [Implement opt out](./doc/optout/README.md)
* **[8. Trouble shooting](#trouble_shooting)**

## What is F.O.X SDK?

Installing F.O.X SDK into application realizes the following functions.

* **Install tracking**

It is able to measure the number of installation for each inflows of advertisement.

* **LTV measurement**

It measures Life Time Value for each advertisements of influx sources. Primary conversion points are membership registration, completion of tutorial, and billing. It is able to measure registration rate, billing rate, and the billing amount for each advertisement.

* **Access Analytics**

It measure comparison of Installation number of organic and non-organic, the number of the of activating application and unique users (DAU / MAU), user retention and so on.

<div id="install_sdk"></div>
## 1. Install SDK
* **Integrate F.O.X SDK by using CocoaPods**

Add the following settings in the Podfile.
```ruby
# Add the following line to the beginning of Podfile.
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# Specify the version.
pod "CYZFox", "<VERSION>"
```
> * From `3.4.0`, F.O.X SDK is provided by CocoaPods Private Pods, <VERSION> should be 3.4.0 or higher.
> * Please refer to [Release Tag History in the past](https://github.com/cyber-z/public-fox-ios-sdk/releases) for how to install `3.3.0` or lower version.
> * Since `4.0.0` does not have backward compatibility, please inquire the administrator.

* **Integrate F.O.X SDK manually**

Download latest SDK from following page.

[SDK download](https://github.com/cyber-z/public_fox_ios_sdk/releases)

If you integrate old version of F.O.X SDK, please check [Updating to latest version of F.O.X SDK](./doc/update/README.md).

Unzip "FOX_iOS_SDK_<version>.zip" and、add the header and lib files to your project.

The description of each file is as follows.

<table>
<tr><th>Functions</th><th>Mandatory</th><th>File name</th></tr>
<tr><td>Library file</td><td>Mandatory</td><td>libFoxSdk.a</td></tr>
<tr><td>Install tracking</td><td>Mandatory</td><td>AdManager.h</td></tr>
<tr><td>LTV measurement</td><td>Optional</td><td>Ltv.h</td></tr>
<tr><td>Access Analytics</td><td>Optional</td><td>AnalyticsManager.h</td></tr>
</table>

![Install procedure](./doc/integration/img01.png)

[Install procedure](./doc/integration/README.md)

<div id="setting_sdk"></div>
## 2. Settings

* **Framework configuration**

Add the following frameworks to your project.

<table>
<tr><th>framework</th><th>Status</th></tr>
<tr><td>AdSupport.framework</td><td>Optional</td></tr>
<tr><td>Security.framework </td><td>Required</td></tr>
<tr><td>StoreKit.framework </td><td>Required</td></tr>
</table>

![framework configuration 1](./doc/config_framework/img01.png)
![framework configuration 2](./doc/config_framework/img02.png)

* **SDK configuration**

Create a file "AppAdForce.plist" anywhere in the project and add the following key and value.

Key | Type | Value
:---: | :---: | :---
APP_ID | String | There will be a contact from the administrator of Force Operation X, so please type the value.
SERVER_URL | String | There will be a contact from the administrator of Force Operation X, so please type the value.
APP_SALT | String | There will be a contact from the administrator of Force Operation X, so please type the value.
APP_OPTIONS | String | Please do not type anything, so please keep it empty.
CONVERSION_MODE | String | Enter 1
ANALYTICS_APP_KEY | String | There will be a contact from the administrator of Force Operation X, so please type the value.

![plist setting](./doc/config_plist/img05.png)

[SDK configuration](./doc/config_plist/README.md)

[Sample for AppAdForce.plist](./doc/config_plist/AppAdForce.plist)

* **Editing Swift Bridging Header**

If you develop with Swift, add the following description to the Bridging Header file.
```objc
#import "AdManager.h"
#import "Ltv.h"
#import "AnalyticsManager.h"
```

<div id="tracking_install"></div>
## 3. Implement install tracking

By implementing install tracking , it is able to start the effectiveness measurements of advertisement.

For F.O.X install tracking, implement the following method

Method | Implement point | Outline
:---: | :---: | :---
setStartPageVisible|didFinishLaunchingWithOptions:|(Optional) Implement before sendConversionWithStartPage. To hide SFSafariViewController, set 'NO'(Default: 'YES')
sendConversionWithStartPage:|didFinishLaunchingWithOptions:|(Mandatory) Install tracking for first launch
setUrlScheme:|openURL:|(Mandatory) Post-processing of install tracking at first launch and receive parameters via URL scheme

Please implement in `application:didFinishLaunchingWithOptions:` as follows.

```objective-c
#import "AdManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];

  return YES; // return YES in order to call openURL:
// }
```

```objective-c
// - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
//                sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

          [[AppAdForceManager sharedManager] setUrlScheme:url];

          return YES;
// }
```
Input the string "default" to the argument of `sendConversionWithStartPage:` as above.

> If the terminal is iOS 9 or higher, and in case of cookie tracking, SFSafariViewController is to be launched.

> Please make sure that the `openURL:` and `setUrlScheme` is called.

> ※ In case of implementing `openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options`, you must implement `setUrlScheme:` in `openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options`.

[The detail of sendConversionWithStartPage:](./doc/send_conversion/README.md)

* **Note to Fingerprinting measurement**

Fingerprinting measurement uses WebView, and you can not measure correctly if you customize UserAgent.
Be sure to implement the following method before customizing WebView's UserAgent to its own character string.

```objc
[[AppAdForceManager sharedManager] cacheDefaultUserAgent];
```

<div id="tracking_ltv"></div>
## 4. Implement LTV tracking

By implementing LTV measurements at arbitrary conversion points such as membership registration, completion of tutorial, billing and etc, It measures Life Time Value for each advertisements of influx sources. In the case that LTV measurement is not necessary, it is able to omit this implementation.

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv sendLtv:{LTV POINT ID}];
```

In order to perform measure the LTV measurement, you need to specify the outcome point ID that identifies each achievement point. Please specify the issued ID in the argument of the `sendLtv:`.

In the case of performing the purchase measurement, please specify the billing amount and the currency code in the following manner at the point where the charging is complete.

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv addParameter:LTV_PARAM_PRICE:@"9.99"];
[ltv addParameter:LTV_PARAM_CURRENCY:@"USD"];
[ltv sendLtv:{LTV POINT ID}];
```

Please specify the currency code defined in [ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217) for LTV_PARAM_CURRENCY.

[LTV tracking by using tag](./doc/ltv_browser/README.md)

<div id="tracking_analytics"></div>
## 5. Implement access analytics

You can measure comparison of Installation number of naturally flow and advertising flows, the number of the of activating application and unique users (DAU / MAU), the ongoing rate and so on. When the access analysis is not required, you can omit the implementation of this item.

To measure application launch and return from background, add `[ForceAnalyticsManager sendStartSession]` to `application:didFinishLaunchingWithOptions:` and `applicationWillEnterForeground`.

When using Background Fetch, the OS calls `application:didFinishLaunchingWithOptions:` while running in background.
Please make state control in applicationState so that startup measurement FOX method is not called during background.

```objective-c
#import "AnalyticsManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    If ([application applicationState] == UIApplicationStateBackground) {
        // running in background
    } else {
		// running in foreground
        [ForceAnalyticsManager sendStartSession];
    }

//}

// - (void)applicationWillEnterForeground:(UIApplication *)application {

    [ForceAnalyticsManager sendStartSession];

//}
```

Be sure to implement `sendStartSession` in the above two places.

* [Event tracking by using access analytics](./doc/analytics_event/README.md)

* [Purchase-event tracking by using access analytics](./doc/analytics_purchase/README.md)


<div id="integration_test"></div>
## 6. Integration test

Until the application to market, test enough in a state where the the SDK has been introduced, and make sure that there is no problem in the operation of the application.

Communication of Installation measurement is performed only once after startup. If you want to do effect measurement test next, uninstall the application, please go from the installation again.

* **Test procedure**

1. Uninstall test app if it has been installed in the testing terminal.
1. Delete the Cookie of the default browser of the testing terminal.
1. Click the test URL that issued from our company
1. Redirected to the Market
1. Install a test application to the testing terminal
1. Activate the app, the browser will start-up
If the browser does not start, that means setting has not been carried out correctly. Review the settings, and if you do not see any problem, please contact us.
1. Screen transition to LTV point
1. Quit the app, also removed from the background
1. Activate the app again

Please tell the time of 3,6,7,9 to us. We will see if measurement has been successfully performed. If there are no problems in our confirmation, the test will be completed.

> Make sure that test URL will be requested on Safari. The measurement will not be performed if you transit by 3rd party browser such as Chrome or Web View in the app such as mail app or QR code reader.

> When you click on a test URL, there is a case where error dialog is displayed because there is no transit destination, but this is not a problem in the communication test.

[Integration test for measurement reengagement](./doc/reengagement_test/README.md)

<div id="other_function"></div>
## 7. Implementation of other function

* [Implement opt out](./doc/optout/README.md)

<div id="trouble_shooting"></div>
## 8. Trouble shooting

### 8.1. What is "Bundle Version" used in F.O.X.

In iOS, there are two parameters called bundle version as follows.

* CFBundleVersion
* CFBundleShortVersionString

F.O.X uses the value of CFBundleShortVersionString of the above.

### 8.2.  It is released without setting of URL scheme and it does not transit to application from browser.

After starting external browsers to conduct Cookie measurement, it is necessary to go back to original screen by using URL scheme and transits to application. At this moment, it is necessary to set original URL scheme. If releasing without setting of URL scheme, it does not conduct such a transition.

### 8.3. URL scheme includes capital letters and small letters and it does not normally conduct transition to application

Depending on the environment, the capital letters and small letters of URL scheme are not distinctive and it does not conduct transition of URL scheme as usual. Please set the URL scheme in all small letters and alphanumeric.

### 8.4. The setting of URL scheme is same as application made from other companies and it opens the application from browsers.

In iOS, in the case of setting same URL scheme in several application, nobody knows which application is started. It does not start specific application for sure, so URL scheme should have some complexity which are unique to application made from other companies.

### 8.5. When operating promotion to acquire tons of users in short time, it did not measure.

iOS forcibly close the application when main thread is blocked for longer than certain time at staring application. Please do not synchronous communication to server on main thread, such as initialization at starting. As a result of acquiring tons of users in short time by reward advertisement, access to the server is concentrated and normal response is getting worse and worse. Then, it takes much time to start application and there is a case that it is forcibly closed and does not measure advertisement effectiveness when starting.

By following procedures below, it is able to practice test in the condition, so please confirm that application is normally started in following setting.

iOS「Setting」→「Developer」→「NETWORK LINK CONDITIONER」

「Enable」is on.
Check「Very Bad Network」

---
[Main menu](/README.md)
