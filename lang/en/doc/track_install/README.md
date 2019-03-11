[TOP](../../README.md)　>　Install Tracking details

---

# Install Tracking details

* [1. Implementing Install Tracking](#track_install_basic)
* [2. Implementing Install Tracking with Options](#track_install_optional)

<div id="track_install_basic"></div>

## 1. Implementing Install Tracking

You can track installs using `trackInstall`. For Cookie tracking, either an external browser or the `SFSafariViewController` method will be used. In this case, assign the redirect destination string URL to the `CYZFoxTrackOption` instance.

Implement the following code into the `didFinishLaunchingWithOptions` method. <br>
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

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
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
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // ...
    CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx").activate()
    CYZFox.trackInstall()
    // ...
}

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

> ※ If you call the `trackInstall` method without specifying an argument, the settings on the F.O.X management portal will take precedence. If you are specifying a redirect URL for Cookie tracking, see the following explanation.

> ※ The trackInstall method should be implemented in the `didFinishLaunchingWithOptions` method called when the application is launched unless there is a particular reason. If it is included in any other place, the install tracking results may not be accurate. <br> Be sure to notify your advertising agency or media company if you have not implemented the `trackInstall` method in the `didFinishLaunchingWithOptions` method invoked at app launch. Otherwise there is a risk of being charged more for advertising expenses due to the possibility of falsely increased install numbers.

<div id="track_install_optional"></div>

## 2. Implementing Install Tracking with Options

If you want to receive callbacks for install completions, add custom parameters to install tracking, redirect to arbitrary URLs, or dynamically generate URLs in your app, use the following [`CYZFoxTrackOption`](../sdk_api/README.md#CYZFoxoption) class.

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // after activate
    CYZFoxTrackOption* option = [CYZFoxTrackOption new];
    option.redirectURL = @"myapp://top";
    option.buid = @"USER ID";
    option.optout = YES;
    option.trackingCompletionHandler = ^ {
        NSLog(@"callback after tracking finished");
    }
    [CYZFox trackInstallWithOption:option];
    // ...
    return YES; // In order to call the openURL: method, make sure this is set to YES
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // after activate
    let option: CYZFoxTrackOption = CYZFoxTrackOption()
    option.redirectURL = "myapp://top"
    option.buid = "USER ID"
    option.isOptout = true
    option.trackingCompletionHandler = {
        print("callback after tracking finished")
    }
    CYZFox.trackInstall(with: option)
    // ...
    return true
}
```

> ※ The above sample code demonstrates how to set redirect URLs, set a BUID, enable the OptOut feature, and receive callbacks for tracking completions. <br>
If there is any source that you would like to run immediately after setting the `trackingCompletionHandler` and successfully tracking an install, please run it in the `Block` that gets called. `Block` will execute on the main thread.

> ※ If the OptOut feature is enabled, that user will no longer be targeted by advertisements. <br>
However, The OptOut feature is only available if your application requires users to choose whether or not to opt out.

> For more details see the [F.O.X SDK API](../sdk_api/README.md).
