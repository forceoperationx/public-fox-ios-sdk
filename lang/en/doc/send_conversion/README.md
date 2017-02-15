## The detail of sendConversionWithStartPage method

By implementing install tracking , it is able to start the effectiveness measurements of advertisement. When using cookie tracking, the external browser is activated. In this case, you can specify the URL string as the argument of `sendConversionWithStartPage:` as the transition destination of the external browser.

Please implement in a order following.

> NOTE: Please implement `sendConversionWithStartPage:` within the `application:didFinishLaunchingWithOptions:` of Application Delegate unless there is a special reason. If it is mounted in other places, the installation number may not be accurately measured.

```objective-c
#import "AdManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];

// }
```

Input the string @"default" to the argument of `sendConversionWithStartPage:` as above. By default, the page prepared by F.O.X is displayed, but it is possible to set the URL of the transition destination arbitrarily on the F.O.X management console.

![sendConversion01](./img01.png)

If you want to transition to a specific URL or if you want to dynamically generate a URL in your application, please set the character string of the URL.

```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html"];
```

You can pass the User ID by calling `sendConversionWithStartPage:buid:` instead of `sendConversionWithStartPage:`. For example, it can be used when you want to generate UUID at the time of launching the application and manage to relate it and first launch connection.

```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html" buid:@"{your uniq id}"];
```
> `sendConversionWithStartPage:buid:` cannot pass Login ID as arguments because of implementing this as function launch directory.

## Receive installation measurement completion callback

By using `setInstallTrackingCompletionHandler:` like the following implementation, you can receive callback of installation measurement completion.

```objc
#import "AdManager.h"
- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // launching process
    // ...

    [[AppAdForceManager sharedManager] setInstallTrackingCompletionHandler:^{
        NSLog(@"onInstallTrackingCompletionHandler");
    }];

    [[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[AppAdForceManager sharedManager]setUrlScheme:url];
    return YES;
}
```

> In the case of cookie measurement, the browser is started and measurement is performed. After the measurement is completed, handler block is called immediately after the application returns to the foreground.

## Note to Fingerprinting measurement

Fingerprinting measurement uses WebView, and you can not measure correctly if you customize UserAgent.
Be sure to implement the following method before customizing WebView's UserAgent to its own character string.
```objective-c
[[AppAdForceManager sharedManager] cacheDefaultUserAgent];```

---
[TOP](/lang/en/README.md)