[TOP](../../README.md)　>　Install计测详细

---

# Install计测详细

* [1. 执行Install计测](#track_install_basic)
* [2. 执行Install计测(指定Option参数)](#track_install_optional)

<div id="track_install_basic"></div>
## 1. 执行Install计测

使用`trackInstall`方法可以进行Install计测。使用Cookie计测的情况时会启用外部浏览器或`SFSafariViewController`。外部浏览器的迁移网页可以通过在`CYZFoxTrackOption`的实例中指定URL字符串来实现。


编辑项目中的代码源，在APP启动时的`didFinishLaunchingWithOptions`方法内，执行以下内容。
此外在`SFSafariViewController`进行Install计测后，为了关闭`SFSafariViewController`，请在`-(BOOL)application:openURL:sourceApplication:annotation:`方法内执行`[CYZFox handleOpenURL:url]`。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // ...
    [[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];
    [CYZFox trackInstall];
    // ...
    return YES; // 为了调用openURL:方法，请务必返回YES
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
    CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx")!.activate()
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

> ※ 未指定参数呼出`trackInstall`方法时，将会优先使用F.O.X管理页面上设置的内容。Cookie计测时需要指定自动跳转的URL时，请参考本章中以下说明。

> ※ 没有特别的理由，请在APP启动时调用的didFinishLaunchingWithOptions方法内编码安装trackInstall方法。在其他地方安装的话有可能无法正确监测统计Install数量。APP启动时调用`didFinishLaunchingWithOptions`方法中未编码安装的状态下投放安装成果转化型广告时，必须向广告代理店或媒体公司负责人进行说明。未正确进行计测就开始投放安装成果转化型广告，可能会产生超过计测安装数的广告费用。

<div id="track_install_optional"></div>
## 2. 执行Install计测(option参数)

如果想要用callback来获取Install计测完成的信息、或是跳转到特定URL、或是用APP动态生成URL时，请使用以下[CYZFoxTrackOption](../sdk_api/README.md#CYZFoxoption)类。<br>

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
	return YES; // 为了调用openURL:方法，请务必返回YES
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let option: CYZFoxTrackOption = CYZFoxTrackOption()
    option.redirectURL = "myapp://top"
    option.buid = "USER ID"
    option.optout = true
    option.trackingCompletionHandler = {
        print("callback after tracking finished")
    }
    CYZFox.trackInstallWithOption(option)
}
```

> 上述示例代码为，redirect位置・BUID・有无optout・计测完成的callback受理的执行案例。<br>`trackingCompletionHandler`设置后完成计测时会呼出`Block`，请在Install计测完成后在此执行操作。`Block`的处理将会在主线程中被执行。

> optout为有效时，可以将用户从广告投放对象中移除。<br>
另外，optout仅在APP中编码安装了类似用户可选optout功能的情况下有效。

> F.O.X SDK的API说明请从[这里](../sdk_api/README.md)确认。
