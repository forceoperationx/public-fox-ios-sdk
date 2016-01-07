# PUSH通知機能的安裝
從Apple的服務器取得Device Token，發送到F.O.X服務器。使用Device Token從F.O.X向移動設備發送PUSH通知。

## Device Token的取得

為了向Apple服務器要求取得Device Token，編輯項目的源代碼，請按下面那樣來安裝Application Delegate的`application:didFinishLaunchingWithOptions:`。

```objective-c
// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
	[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];

	// …

	// 取得Device Token
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
	// iOS8対応
		[[UIApplication sharedApplication]
			registerUserNotificationSettings: [UIUserNotificationSettings
							settingsForTypes: (UIUserNotificationTypeSound |
												UIUserNotificationTypeAlert |
												UIUserNotificationTypeBadge)
												categories:nil]];
		[[UIApplication sharedApplication] registerForRemoteNotifications];
	} else {
		// iOS7以前版本的對應
		[[UIApplication sharedApplication]
			registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
												UIRemoteNotificationTypeSound |
												UIRemoteNotificationTypeAlert)];
	}

// }
```

> Device Token的取得請一定安裝在進行成果通知方法sendConversionWithStartPage的後面。
（如果已經有了提示說明文，請將安裝到F.O.X方法sendConversionWithStartPage後面的提示說明文移動到合適位置）

## 發送從Apple取得的Device Token給F.O.X

取得Device Token成功以後，回調用Application Delegate的`didRegisterForRemoteNotificationsWithDeviceToken:`，為了向F.O.X發送取得的Device Token，請按下面那樣編寫代碼。


```objective-c
#import "Notify.h"

// - (void)application:(UIApplication *)application
//	didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)devToken{

	[[Notify sharedManager] manageDevToken:devToken];

// }
```
devToken裡存放有從Apple取得的Device Token。

## 發送給F.O.X開封通知

收到PUSH通知的時候，為了向F.O.X發送開封通知，請按下面那樣安裝到Application Delegate的`application:didFinishLaunchingWithOptions:`和`application:didReceiveRemoteNotification:`裡。


```objective-c
// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if !TARGET_IPHONE_SIMULATOR
	[[Notify sharedManager] sendOpenedStatus: launchOptions];
#endif

// }
```

```objective-c
// - (void)application:(UIApplication *)application
//	 didReceiveRemoteNotification:(NSDictionary *)userInfo {

#if !TARGET_IPHONE_SIMULATOR
	if ( [[Notify sharedManager] sendOpenedStatus:userInfo application:application] ) {
		return;
	}
#endif

//}
```

> 開封比率現在還無法在管理畫面裡確認，將來會提供此機能。


## 指定遷移目的地機能

從PUSH通知來啟動APP的時候，可以通過URL Scheme的形式來指定遷移目的地。
可以在F.O.X的管理畫面裡設定URL Scheme。

希望用URL Scheme啟動APP的時候，調用Application Delegate的`application:openURL:sourceApplication:annotation`能夠取得URL Scheme。利用取得的URL Scheme可以遷移到APP內的任意地點。

例如，下面是利用"myscheme://myhost"這樣的URL Scheme來打開DownloadViewController的事例代碼。

```objective-c
// - (BOOL)application:(UIApplication *)application
//   openURL:(NSURL *)url
//   sourceApplication:(NSString *)sourceApplication
//   annotation:(id)annotation{
	if ([@"myhost" compare:[url host]] == NSOrderedSame) {
		UIViewController \*viewController =
			[[DownloadViewController alloc] initWithNibName:nil bundle:nil];
		self.window.rootViewController = viewController;
		[self.window makeKeyAndVisible];
	}
	return YES;
//   }
```

---
[TOP](/lang/ja/README.md)
