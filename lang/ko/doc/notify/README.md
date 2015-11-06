# 푸시 알림 구현
Apple의 서버에서 디바이스 토큰을 취득하고, F.O.X의 서버에 송신합니다. 취득한 디바이스 토큰을 사용해서, F.O.X에서 단말에 푸시 알림을 송신합니다.

## 디바이스 토큰 취득

Apple의 서버에 디바이스 토큰의 취득을 요청하기 위해서는, Application Delegateの`application:didFinishLaunchingWithOptions:`에 다음과 같이 구현해 주십시오.

```objective-c
// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
	[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];

	// …

	// 디바이스 토큰의 취득
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
	// iOS8대응
		[[UIApplication sharedApplication]
			registerUserNotificationSettings: [UIUserNotificationSettings
							settingsForTypes: (UIUserNotificationTypeSound |
												UIUserNotificationTypeAlert |
												UIUserNotificationTypeBadge)
												categories:nil]];
		[[UIApplication sharedApplication] registerForRemoteNotifications];
	} else {
		// iOS7이전 버전 대응
		[[UIApplication sharedApplication]
			registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
												UIRemoteNotificationTypeSound |
												UIRemoteNotificationTypeAlert)];
	}

// }
```
> 디바이스 토큰의 취득은, 반드시 성과통지를 하는  F.O.X의 메소드 sendConversionWithStartPage의 뒤에 구현해 주십시오. (만약 이미 기술완료의 경우는, F.O.X의 메소드 sendConversionWithStartPage의 뒤에 구현하게 기술 위치를 이동해 주십시오.)

## Apple로 부터 취득한 디바이스 토큰을 F.O.X에 송신

디바이스 토큰의 취득에 성공했을 경우, Application Delegate의” didRegisterForRemoteNotificationsWithDeviceToken:”이 호출되므로,
취득한 디바이스 토큰을 F.O.X에 송신하기 위해서, 다음과 같이 구현을 해 주세요.

```objective-c
#import "Notify.h"

// - (void)application:(UIApplication *)application
//	didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)devToken{

	[[Notify sharedManager] manageDevToken:devToken];

// }
```
devToken에는、Apple로 부터 받은 디바이스 토큰을 넣어 주십시오.

## F.O.X에 개봉통지의 송신

푸시 알림을 수신한 경우에, F.O.X에 개봉 알림을 송신하기 위해, Application Delegate의`application:didFinishLaunchingWithOptions:`과`application:didReceiveRemoteNotification:`에 다음과 같이 구현해 주십시오.

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
> 개봉율은, 현재는 관리 화면에서 확인할 수는 없습니다만, 이후 관리 화면에서 확인할 수 있을 예정입니다.

## 전환처 지정 기능

푸시 알림으로 앱을 기동했을 때의 전환처를 URL스키마(scheme) 형식으로 지정하는 것이 가능합니다.
전환처의 URL 스키마(scheme)는, F.O.X의 관리 화면에서 설정할 수 있습니다.


URLスキームでアプリを起動した際に、Application Delegateの`application:openURL:sourceApplication:annotation`が呼び出され、URLスキームを取得出来ます。取得したURLスキームを利用して、アプリ内の任意の場所に遷移させます。
URL 스키마(scheme)에서 앱을 기동했을 때, Application Delegate의`application:openURL:sourceApplication:annotation`이 호출되어, URL 스키마(scheme)을 취득할 수 있습니다.
취득한 URL스키마(scheme)을 이용하고, 앱 내의 임의의 장소로 전환합니다.

예를 들어, "myscheme://myhost"이라고 하는 URL 스키마(scheme)에서 DownloadViewController을 열리는 샘플 코드를 만들면 아래와 같습니다.

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
[TOP으로](/lang/ko/README.md)
