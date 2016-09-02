# Force Operation Xとは

Force Operation X (以下F.O.X)は、スマートフォンにおける広告効果最適化のためのトータルソリューションプラットフォームです。アプリケーションのダウンロード、ウェブ上でのユーザーアクションの計測はもちろん、スマートフォンユーザーの行動特性に基づいた独自の効果計測基準の元、企業のプロモーションにおける費用対効果を最大化することができます。

本ドキュメントでは、スマートフォンアプリケーションにおける広告効果最大化のためのF.O.X SDK導入手順について説明します。

## 目次

* **[1. インストール](#install_sdk)**
	* [1.1 CocoaPodsによる導入](#by_cocoapods)
	* [1.2 Carthageによる導入](#by_carthage)
	* [1.3 手動による導入](#by_manual)
* **[2. 設定](#setting_sdk)**
	* [2.1 Frameworkの設定](#setting_framework)
	* [2.2 App Transport Securityの設定](#setting_ats)
	* [2.2 URLスキームの設定](#setting_urlscheme)
* **[3. F.O.X SDKのアクティベーション](#activate_sdk_into_app)**
	* [3.1 Frameworkのインポート](#activate_import)
	* [3.1 コンフィギュレーション](#activate_config)
* **[4. インストール計測の実装](#tracking_install)**
	* [インストール計測の詳細](./doc/track_install/README.md)
* **[5. リエンゲージメント計測の実装](#tracking_reengagement)**
	* [5.1 カスタマイズURL Schemeによって計測](#tracking_reengagement_scheme)
	* [5.2 Universal Linkによって計測](#tracking_reengagement_ulink)
* **[6. アプリ内イベントの計測](#tracking_event)**
	* [6.1 セッション（起動イベント）の計測](#tracking_session)
	* [6.2 その他のアプリ内イベントの計測](#tracking_other_event)
	* [イベント計測の詳細](./doc/track_events/README.md)
* **[7. その他機能の実装](#other_function)**
	* [オプトアウトの実装](./doc/optout/README.md)
* **[8. 最後に必ずご確認ください](#trouble_shooting)**


## F.O.X SDKとは

F.O.X SDKをアプリケーションに導入することで、以下の機能を実現します。

* **インストール計測**

広告流入別にインストール数を計測することができます。

* **LTV計測**

流入元広告別にLife Time Valueを計測します。主な成果地点としては、会員登録、チュートリアル突破、課金などがあります。各広告別に登録率、課金率や課金額などを計測することができます。

* **アクセス解析**

自然流入と広告流入のインストール比較。アプリケーションの起動数やユニークユーザー数(DAU/MAU)。継続率等を計測することができます。


<div id="install_sdk"></div>

## 1. インストール

<div id="by_cocoapods"></div>

### 1.1 CocoaPodsによる導入

下記のようにPodfileファイルを更新してください。
* **iOS objective-cで開発する場合**
```ruby
# 下記の一行をPodfileの一番最初に追加してください
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# 下記を指定したいターゲットに追加してください
pod "FOXSDK", "<VERSION>"
```

* **tvOS objective-cで開発する場合**
```ruby
# 下記の一行をPodfileの一番最初に追加してください
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# 下記を指定したいターゲットに追加してください
pod "FOXSDKTv", "<VERSION>"
```

* **iOS Swiftでdynamic frameworkを利用する場合**
```ruby
# 下記の一行をPodfileの一番最初に追加してください
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# dynamic frameworkを有効に
use_frameworks!

pod "FOXSDKDy", "<VERSION>"
```

* **tvOS Swiftでdynamic frameworkを利用する場合**
```ruby
# 下記の一行をPodfileの一番最初に追加してください
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# dynamic frameworkを有効に
use_frameworks!

pod "FOXSDKTvDy", "<VERSION>"
```
> ※ `<VERSION>`は指定したいリリースバージョン、4.0.0以上です。

<div id="by_carthage"></div>

### 1.2 Carthageによる導入

Cartfileファイルに下記の設定を追加してください。
```
github "cyber-z/public-fox-ios-sdk" == <VERSION>
```
> ※ `<VERSION>`は指定したい4.0.0以上のリリースバージョンです。

> ※ Carthageの場合Target VersionはiOS 8.0以上に指定する必要となります。

<div id="by_manual"></div>

### 1.3 手動による導入

[リリースページ](https://github.com/cyber-z/public_fox_ios_sdk/releases)から`FOXSDK_iOS_static_<VERSION>.zip`をダウンロードして展開し、`FOXSDK.framework`ファイルをXcodeプロジェクトに組み込んでください。

> ※ 既にアプリケーションにSDKが導入されている場合には、[最新バージョンへのアップデートについて](./doc/update/README.md)をご参照ください。

> ※ tvOSの場合`FOXSDK_tvOS_static_<VERSION>.zip`をダウンロードしてください。導入手順はiOSと同じです。


<div id="setting_sdk"></div>

## 2. 設定

SDKの動作に必要なXcodeの設定を行います。

<div id="setting_framework"></div>

### 2.1 Frameworkの設定

次のフレームワークをプロジェクトにリンクしてください。

<table>
<tr><th>フレームワーク名</th><th>Status</th></tr>
<tr><td>UIKit.framework</td><td>Required</td></tr>
<tr><td>Foundation.framework</td><td>Required</td></tr>
<tr><td>Security.framework</td><td>Required</td></tr>
<tr><td>SystemConfiguration.framework</td><td>Required</td></tr>
<tr><td>AdSupport.framework</td><td>Optional</td></tr>
</table>

<div id="setting_ats"></div>

### 2.2 App Transport Securityの設定

iOS9より提供されたAppTransportSecurity(以下、ATS)を有効にしている場合、Info.plistに以下の設定を行いF.O.X SDKが行う通信先のドメインをATSの例外としてください。

キー | タイプ | 概要
:---: | :---: | :---
NSExceptionDomains|Dictionary|ATSの例外を指定するディクショナリー
指定ドメイン文字列|Dictionary|以下２つのドメインをキーで作成してください。<br>・app-adforce.jp<br>・forceoperationx.com
NSExceptionAllowsInsecureHTTPLoads|Boolean|YES を指定してくださいATSの例外とします。
NSIncludesSubdomains|Boolean|YES を指定しATSの例外設定をサブドメインにも適用させます。

![ATS設定](./img_setting_ats.png)

<div id="setting_urlscheme"></div>

### 2.3 URLスキームの設定

Cookieインストール計測とリエンゲージメント計測を行うため、カスタマイズURL schemeの設定を必ず追加してください。

> ※ 環境によっては、URLスキームの大文字小文字が判別されないことにより正常に URLスキームの遷移が行えない場合があります。URLスキームは全て小文字の英数字を用いて設定を行ってください。

> ※ 他アプリと衝突しないためリバースドメイン(例 _`jp.co.company.product`_ )の使用がおすすめです。


<div id="activate_sdk_into_app"></div>

## 3. F.O.X SDKのアクティベーション

<div id="activate_import"></div>

### 3.1 Frameworkのインポート

APIを使用するため下記importを追加してください。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
#import <FOXSDK/FOXSDK.h>
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
import FOXSDK
```

<div id="activate_config"></div>

### 3.2 コンフィギュレーション

F.O.X SDKのアクティベーションを行うため、[`CYZFoxConfig`](./doc/sdk_api/README.md#foxconfig)クラスのコンフィギュレーション設定をdidFinishLaunchingWithOptionsメソッド内に実装します。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
	// ...
	[[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];
	// ...
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
	// ...
	CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx")!.activate()
	// ...
}
```

> ※ アクティベーションの実装は必ず全ての計測の前に行わなければなりません。


<div id="tracking_install"></div>

## 4. インストール計測の実装

初回起動のインストール計測を実装することで、広告の効果測定を行うことができます。
F.O.X SDKではiOS9からリリースされた新しいWebView形式である `SFSafariViewController` を初回起動時に起動させ計測することで、バックグラウンド表示によるユーザービリティの低下を防止することが出来ます。

以下の[`[CYZFox trackInstall]`](./doc/sdk_api/README.md#CYZFox)メソッドをアプリケーションの起動時に`didFinishLaunchingWithOptions`メソッド内に実装します。
また`SFSafariViewController`でのインストール計測を行った後に`SFSafariViewController`を閉じるため、`-(BOOL)application:openURL:sourceApplication:annotation:`メソッド内、`[CYZFox handleOpenURL:url]`を実装を行ってください。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
	// ...
	[[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];
	[CYZFox trackInstall];
	// ...
	return YES; // openURL:メソッドをコールさせるため必ずYESを返してください
}

-(BOOL) application:(UIApplication *) application openURL:(nonnull NSURL *) url
sourceApplication:(nullable NSString *) sourceApplication annotation:(nonnull id) annotation {
	// ...
	[CYZFox handleOpenURL:url]; // Cookie計測或はリエンゲージメント計測を利用する場合
	// ...
	return YES;
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
	// ...
	CYZFoxConfig.init(appId:0000,salt:"xxxxx",appKey:"xxxxx")!.activate()
	CYZFox.trackInstall()
	// ...
	return true
}

func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
	// ...
	CYZFox.handleOpenURL(url)
	// ...
	return true
}
```

> ※ ２回目以降、trackInstallメソッドが呼び出されても動作することはありません。

> ※ trackInstallメソッドにはオプションを指定することも可能です。詳細は[インストール計測の詳細](./doc/track_install/README.md)をご確認ください。

 * **Fingerprinting計測時の注意事項**

 Fingerprinting計測はUIWebViewを使用しており、UserAgentを独自のカスタマイズを行っている場合正常に計測することが出来なくなります。
 下記のように計測処理が完了した後にUIWebViewのUserAgentを独自の文字列にカスタマイズを行います。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
 ```objc
 CYZFoxTrackOption* option = [CYZFoxTrackOption new];
 option.onTrackFinished = ^() {
     NSLog(@"callback after tracking finished");
     // set customize UserAgent
 };
 [CYZFox trackInstallWithOption:option];
 ```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)

```Swift
let option: CYZFoxTrackOption = CYZFoxTrackOption.init()
option.onTrackFinished = {
    print("callback after tracking finished")
    // set customize UserAgent
}
CYZFox.trackInstallWithOption(option)
```

[インストール計測の詳細](./doc/track_install/README.md)

<div id="tracking_reengagement"></div>

## 5. リエンゲージメント計測の実装

<div id="tracking_reengagement_scheme"></div>

### 5.1 カスタマイズURL Schemeによる計測

リエンゲージメント広告の計測（URLスキーム経由の起動を計測）するために、`UIApplicationDelegate`の`openURL`メソッドに`[CYZFox handleOpenURL:url]`を実装します。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application openURL:(nonnull NSURL *) url
sourceApplication:(nullable NSString *) sourceApplication annotation:(nonnull id) annotation {
	// ...
    [CYZFox handleOpenURL:url];
	// ...
    return YES;
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
	// ...
  CYZFox.handleOpenURL(url)
	// ...
  return true
}
```

> ※ リエンゲージメント広告の計測を行うためにはInfo.plistに定義されているカスタムURLスキームが設定されていることが前提となります。

<div id="tracking_reengagement_ulink"></div>

### 5.2 Universal Linkによる計測

Universal Link対応の場合、`continueUserActivity`メソッドに [5.1](#tracking_reengagement_scheme) と同じ`[CYZFox handleOpenURL:url]`を実装します。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application continueUserActivity:(NSUserActivity *) userActivity
restorationHandler:(void (^)(NSArray *restorableObjects)) restorationHandler {
	// ...
    [CYZFox handleOpenURL:userActivity.webpageURL];
	// ...
    return YES;
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
  // ...
  CYZFox.handleOpenURL(url)
  // ...
  return true
}
```

> ※ カスタマイズURL SchemeとUniversal Link 両方対応の場合、両方の実装が必要です。

<div id="tracking_event"></div>

## 6. アプリ内イベントの計測

<div id="tracking_session"></div>

### 6.1 セッション（起動イベント）の計測

アプリケーションの起動、及びバックグラウンドからの復帰を計測するために、application:didFinishLaunchingWithOptions:およびapplicationWillEnterForegroundにコードを追加します。

※バックグラウンドフェッチを利用している場合、バックグラウンド起動時にOS側がapplication:didFinishLaunchingWithOptions:をコールしています。バックグラウンド時は起動計測F.O.Xメソッドが呼ばれないようにapplicationStateにて状態判定をおこなってください。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objective-c
- (BOOL)application:(UIApplication *)application
   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    If ([application applicationState] == UIApplicationStateBackground) {
        //バックグラウンド時の処理
    } else {
        //バックグラウンド時は起動計測が呼ばれないようにする
        [CYZFox trackSession];
    }

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    [CYZFox trackSession];

}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		if application.applicationState == UIApplicationState.Background {
				//バックグラウンド時の処理
		} else {
				//バックグラウンド時は起動計測が呼ばれないようにする
				CYZFox.startSession()
		}
}

func applicationDidEnterBackground(application: UIApplication) {	  
		CYZFox.startSession()
}
```

<div id="tracking_other_event"></div>

### 6.2 その他のアプリ内イベントの計測

会員登録、チュートリアル突破、課金など任意の成果地点にイベント計測を実装することで、流入元広告のLTVを測定することができます。<br>イベント計測が不要の場合には、本項目の実装を省略できます。

**[チュートリアルイベントの計測例]**

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_tuturial_comp" andLtvId:0000];
event.buid = @"User ID";
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_tuturial_comp", andLtvId:0000)!
event.buid = "User ID"
CYZFox.trackEvent(event)
```

> イベント計測を行うためには、各成果地点を識別する`成果地点ID`を指定する必要があります。[`CYZFoxEvent`](./doc/sdk_api/README.md#foxevent)クラスのコンストラクタの引数にイベント名と発行されたIDを指定してください。

**[課金イベントの計測例]**

課金計測を行う場合には、課金が完了した箇所で以下のように課金額と通貨コードを指定してください。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_purchase"];
event.price = 99;
event.currency = @"JPY";
event.sku = @"itemId";
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_purchase")!
event.price = 99
event.currency = "JPY"
event.sku = "itemId"
CYZFox.trackEvent(event)
```

currencyの指定には[ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217)で定義された通貨コードを指定してください。

[イベント計測の詳細](./doc/track_events/README.md)

<div id="other_function"></div>

## 7. その他機能の実装

* [オプトアウトの実装](./doc/optout/README.md)

<div id="trouble_shooting"></div>
## 8. 最後に必ずご確認ください（これまで発生したトラブル集）

### 8.1. F.O.Xで利用するバンドルバージョンとは？

iOSでは、バンドルバージョンと呼ばれるものには具体的に以下の二つがあります。

* CFBundleVersion
* CFBundleShortVersionString

F.O.Xでは、上記のうちCFBundleShortVersionStringの値を管理の目的で利用します。

### 8.2. 期待した広告経由のインストール数よりもレポートの数字が低い

インストール計測の`trackInstall:`または`trackInstallWithOption:`が起動直後ではない箇所に実装されている場合に、その地点に到達する前に離脱したユーザーは計測漏れが発生します。

`trackInstall:`および、`trackInstallWithOption:`は、特に理由がない限りは`application:didFinishLaunchingWithOptions:`内に実装してください。それ以外の箇所に実装された場合にはインストール数が正確に計測できない場合があります。

`application:didFinishLaunchingWithOptions:`に実装していない状態でインストール成果型の広告を実施する際には、必ず広告代理店もしくは媒体社の担当にその旨を伝えてください。正確に計測が行えない状態でインストール成果型の広告を実施された際には、計測されたインストール数以上の広告費の支払いを求められる恐れがあります。

### 8.3. URLスキームの設定がされずリリースされたためブラウザからアプリに遷移ができない

Cookie計測を行うために外部ブラウザを起動した後に、元の画面に戻すためにはURLスキームを利用してアプリケーションに遷移させる必要があります。この際、独自のURLスキームが設定されている必要があり、URLスキームを設定せずにリリースした場合にはこのような遷移を行うことができなくなります。

### 8.4. URLスキームに大文字が含まれ、正常にアプリに遷移されない

環境によって、URLスキームの大文字小文字が判別されないことにより正常にURLスキームの遷移が行えない場合があります。URLスキームは全て小文字で設定を行ってください。

### 8.5. URLスキームの設定が他社製アプリと同一でブラウザからそちらのアプリが起動してしまう

iOSにおいて、複数のアプリに同一のURLスキームが設定されていた場合に、どのアプリが起動するかは不定です。確実に特定のアプリを起動することができなくなるため、URLスキームは他社製アプリとはユニークになるようある程度の複雑性のあるものを設定してください。

### 8.6. 短時間で大量のユーザー獲得を行うプロモーションを実施したら正常に計測がされなかった

iOSには、アプリ起動時に一定時間以上メインスレッドがブロックされるとアプリケーションを強制終了する仕様があります。起動時の初期化処理など、メインスレッド上でサーバーへの同期通信を行わないようにご注意ください。リワード広告などの大量のユーザーを短時間で獲得した結果、サーバーへのアクセスが集中し、通信のレスポンスが非常に悪くなることでアプリケーションの起動に時間がかかり、起動時に強制終了され正常に広告成果が計測できなくなった事例がございます。

以下の手順で、こうした状況をテストすることができますので、以下の設定でアプリケーションが正常に起動するかをご確認ください。

`iOS「設定」→「デベロッパー」→「NETWORK LINK CONDITIONER」`

* 「Enable」をオン
* 「Very Bad Network」をチェック

---
[メインメニュー](/README.md)
