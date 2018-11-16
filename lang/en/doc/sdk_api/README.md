# FOX SDK API

<div id="foxconfig"></div>

## 1. CYZFoxConfig

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|appId|NSString|readonly, App ID issued by the dashboard|
|salt|NSString|readonly, Salt issued by the dashboard|
|appKey|NSString|readonly, App Key issued by the dashboard|
|foxServerURL|NSString|DeliverServerURL|
|analyticsServerURL|NSString|access analytics ServerURL|
|debugMode|BOOL|readonly, enable/disable debug log output|
|webViewTrackingEnabled|BOOL|enable/disable tracking by UIWebView|
|customizedUserAgentEnabled|BOOL|enable/disable support for a custom UserAgent|
|offlineMode|BOOL|disable SDK communications with OfflineMode. Once disabled, this setting cannot be changed. |

#### Instance Methods

1. `-(void) enableDebugMode`
> displays error messages and stack traces

2. `-(void) enableWebViewTracking`
> enable/disable tracking by UIWebView

3. `-(void) activate`
> specified information is reflected within the SDK. Warning: Settings are only saved the first time this is called.

４. `-(void) enableCustomizedUserAgent`
> enables the use of a custom UserAgent

#### Static Methods

1.
```objc
+(nullable CYZFoxConfig*) configWithAppId:(NSUInteger) appId salt:(nonnull NSString*) salt appKey:(nonnull NSString*) appKey;
```
> The constructor method and required `Properties` are both set during initialization
> <br/>@param `appId` App ID issued from the dashboard
> <br/>@param `salt` App Salt issued from the dashboard
> <br/>@param `appKey` App Key issued from the dashboard


<div id="CYZFox"></div>

## 2 CYZFox

#### Static Methods

1. `+(void) trackInstall`
> Method for first time install tracking. Operates as configured on the dashboard.

2. `+(void) trackInstallWithOption:(nonnull CYZFoxTrackOption*) option`
> Tracks first launch after install. Executes according to tracking options specified in `FoxOption`
> <br/>@param [`option`](#CYZFoxTrackOption) options specified for measurement

3. `+(void) handleOpenURL:(nonnull NSURL*) url`
> Method that receives the URL/URL Scheme used when performing Cookie tracking and Re-engagement measurement.
> <br/>@param `url` url that launches an app from an external browser

4. `+(void) trackSession`
> performs session tracking

5. `+(void) trackEvent:(nonnull CYZFoxEvent*) event`
> performs event tracking
> <br/>@param [`event`](#foxevent) event information details

6. `+(nullable NSDictionary*) getUserInfo`
> gets user information/traits that are universal to all events when tracking

7. `+(void) setUserInfo:(nonnull NSDictionary*) userInfo`
> gets user information/traits that are universal to all events when tracking
> <br/>@param `userInfo` user information/traits in JSON format

8. `+(BOOL) isConversionCompleted`
> returns a boolean value determining whether install tracking has been completed.

9. `+(void) trackEventByBrowser:(nonnull NSString*) redirectURL`
> tracks events with an event tag embedded into a web page URL.
> <br/>@param `redirectURL` web page URL embedded with an event tag

10. `+(void) handleOpenURL:(nonnull NSURL*) url buid:(nullable NSString*) buid`
> Method that receives the URL/URL Scheme used when performing Cookie tracking and Re-engagement measurement.
> <br/>@param `url` url that launches an app from an external browser
> <br/>@param `buid` advertiser device ID (e.g. userID)

11. `+(nullable NSString*) getXuniqId`
> gets a FOX unique id


<div id="CYZFoxTrackOption"></div>

## 3 CYZFoxTrackOption

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|optout|BOOL|OptOut toggler<br>※default: false|
|redirectURL|NSString|redirect destination after browser launch|
|buid|NSString|Buid setter|
|onTrackFinished|Block|Not Recommended: use `trackingCompletionHandler` instead.<br> First time install tracking completion callback.|
|trackingCompletionHandler|Block|First time install tracking completion callback.|
|deferredDeeplinkHandler|Block|Callback for when a deferred deeplink is obtained.<br>_Callback Parameters_：<br>`deeplinkInfo` -- NSDictionary、JSON type deeplink information|
|durationSinceClick|NSTimeInterval| Validity period between click and deferred deeplink. (measured in seconds)|

<div id="foxevent"></div>

## 4 CYZFoxEvent

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|ltvId|NSUInteger|LTV ID issued from the dashboard|
|buid|NSString|client user ID|
|extraInfo|NSDictionary|arbitrary Key-Value|
|eventName|NSString|event name|
|value|NSUInteger|event related value|
|orderId|NSString|purchase event order ID|
|sku|NSString|item's sku|
|itemName|NSString|item's name|
|price|NSString|item's **unit price**|
|quantity|NSString|amount of items|
|currency|NSString|currency|
|eventInfo|NSDictionary|customized JSON type information|

#### Instance Methods
1. `-(nullable instancetype) initWithEventName:(nonnull NSString*) eventName`
> Specify init method and event name.
> <br/>@param `eventName` event name

2. `-(nullable instancetype) initWithEventName:(nonnull NSString*) eventName andLtvId:(NSUInteger) ltvId`
> Specify init method, event name and LTVID.
> <br/>@param `eventName` event name
> <br/>@param `ltvId` issued from the dashboardLTV ID

3. `-(void) addExtraValue:(nonnull NSString*) value forKey:(nonnull NSString*) key`
> Add arbitrary Key-Value data
> <br/>@param `value` Value
> <br/>@param `key` Key

#### Static Methods
1.
```objc
+(nullable CYZFoxEvent*) makePurchaseEventWithEventName:(nonnull NSString*) eventName
                                               ltvId:(NSUInteger) ltvId
                                               price:(double) price
                                            currency:(nullable NSString*) currency;
```
> Helper method for purchase events
> <br/>@param `eventName` event name
> <br/>@param `ltvId` LTV ID issued from the dashboard
> <br/>@param `price` unit price
> <br/>@param `currency` currency


---
[Return to Top](../../README.md)
