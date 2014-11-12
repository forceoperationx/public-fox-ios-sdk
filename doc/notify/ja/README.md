## プッシュ通知機能の実装
Appleのサーバからデバイストークンを取得し、F.O.Xのサーバへ送信します。取得したデバイストークンを使用して、F.O.Xから端末にプッシュ通知を送信します。


### デバイストークンの取得

Appleのサーバに対してデバイストークンを取得要求を行うために、プロジェクトのソースコードを編集し、Application Delegateのapplication:didFinishLaunchingWithOptions:に次の通り実装を行ってください。


```objectivec
// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];

// …

// デバイストークンの取得
if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {	// iOS8対応	[[UIApplication sharedApplication]
		registerUserNotificationSettings: [UIUserNotificationSettings
						settingsForTypes: (UIUserNotificationTypeSound |
											UIUserNotificationTypeAlert |
											UIUserNotificationTypeBadge)
											categories:nil]];
	[[UIApplication sharedApplication] registerForRemoteNotifications];} else {	// iOS7以前に対応	[[UIApplication sharedApplication] 
		registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
											UIRemoteNotificationTypeSound |
											UIRemoteNotificationTypeAlert)];}

// }
```
> デバイストークンの取得は、必ず成果通知を行う F.O.X のメソッド sendConversionWithStartPage の後に実装してください。 (もし既に記述済の場合は、F.O.X のメソッド sendConversionWithStartPage の後に実装するように記述位置を移 動してください)

### Appleから取得したデバイストークンをF.O.Xへ送信

デバイストークンの取得に成功した場合、Application DelegateのdidRegisterForRemoteNotificationsWithDeviceToken:が呼び出されますので、
取得したデバイストークンをF.O.Xへ送信するために、次の通り実装を行ってください。

```objectivec
#import "Notify.h"

// - (void)application:(UIApplication *)application
//	didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)devToken{
	[[Notify sharedManager] manageDevToken:devToken];
// }
```
devTokenには、Appleから送られてきたデバイストークンが入っています。

### F.O.Xへの開封通知の送信

プッシュ通知を受信した際に、F.O.Xへ開封通知を送信するために、Application Delegateのapplication:didFinishLaunchingWithOptions:とapplication:didReceiveRemoteNotificationに下記の実装を行ってください。


```objectivec
// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if !TARGET_IPHONE_SIMULATOR
[[Notify sharedManager] sendOpenedStatus: launchOptions];
#endif

// }
```

```objectivec
// - (void)application:(UIApplication *)application
//	 didReceiveRemoteNotification:(NSDictionary *)userInfo {
#if !TARGET_IPHONE_SIMULATOR
	if ( [[Notify sharedManager] sendOpenedStatus:userInfo application:application] ) {		return;
	}
#endif
//}
```

> 開封率は、現在は管理画面で確認することは出来ませんが、今後表示を予定しています。


## 遷移先指定機能

Push通知からアプリを起動した際の遷移先をURLスキーム形式で指定することが可能です。
遷移先のURLスキームは、FOXの管理画面で設定することができます。

URLスキームでアプリを起動した際に、Application Delegateのapplication:openURL:sourceApplication:annotationが呼び出され、URLスキームを取得出来ます。取得したURLスキームを利用して、アプリ内の任意の場所に遷移させます。

例として、"myscheme://myhost"というURLスキームでDownloadViewControllerを開くサンプルコードを記します。

```objectivec
// - (BOOL)application:(UIApplication *)application
//   openURL:(NSURL *)url
//   sourceApplication:(NSString *)sourceApplication
//   annotation:(id)annotation{
	if ([@"myhost" compare:[url host]] == NSOrderedSame) {		UIViewController *viewController =			[[DownloadViewController alloc] initWithNibName:nil bundle:nil];		self.window.rootViewController = viewController;		[self.window makeKeyAndVisible];	}	return YES;}```

[TOP](https://github.com/cyber-z/public_fox_ios_sdk#%E3%81%9D%E3%81%AE%E4%BB%96%E6%A9%9F%E8%83%BD%E3%81%AE%E5%AE%9F%E8%A3%85)


