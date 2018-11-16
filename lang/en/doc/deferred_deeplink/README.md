[TOP](../../README.md)　>　Implementing deferred-deeplink

---

# Implementing deferred-deeplink

By implementing deferred deeplink, users can access a page within an app when clicking on an advertisement that has a deeplink attached to it. Additionally, if a user installs an app after accessing a deeplink page, they can still transition to it after installing the app by clicking the same advertisement.

> Supported versions: 4.1.0 and above

Below is an explanation of the required classes and methods for deferred deep linking.

## FoxTrackOption

#### Properties
|Property|Type|Details|
|:---|:---|:---|
|deferredDeeplinkHandler|Block|A callback for when the deferred deeplink is obtained. This callback is run in the background sled.|
|durationSinceClick|NSTimeInterval|[Optional]When querying the deferred deep link to the server, this method returns the duration (in seconds) of the most recent click. <br> The default setting is 86400 seconds (24 hours)|

##### `deferredDeeplinkHandler` details

`void (^deferredDeeplinkHandler)(NSDictionary* _Nullable deeplinkInfo)`

`deeplinkInfo` : NSDictionary, JSON type deeplink data. If the deferred deeplink doesn't exist, or there is a communication error with the device, then it will return a null value.

##### `deeplinkInfo` details :

  |Key|Type|Detail|
  |:---|:---|:---|
  |deeplink|String|deeplink string value|

## Example

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

<div id="with_thirdparty"></div>

### Using a third-party tool's deferred deeplink

#### Using the Facebook SDK

In the example below, the `FacebookSDK` deferred deeplink source-code is included inside the F.O.X SDK's install tracking completion callback. Cookie tracking is completed correctly when screen transition by deferred deeplink occurs after the browser launch is completed.

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // after activate
    CYZFoxTrackOption* option = [CYZFoxTrackOption new];
    option.trackingCompletionHandler = ^ {
        // Run any Facebook SDK deferred deeplink source-code here
    }
    [CYZFox trackInstallWithOption:option];
    // ...
    return YES; // In order to call the openURL: method, make sure this is set to YES
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let option: CYZFoxTrackOption = CYZFoxTrackOption()
    option.trackingCompletionHandler = {
        // Run any Facebook SDK deferred deeplink source-code here
    }
    CYZFox.trackInstallWithOption(option)
    return true; // In order to call the openURL: method, make sure this is set to YES
}
```
> For more information on implementing the Facebook SDK see their [developer docs](https://developers.facebook.com/docs/app-ads/deep-linking#deferred-deep-linking).
---
[Return to Top](../../README.md)
