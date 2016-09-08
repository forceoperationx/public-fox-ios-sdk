[TOP](../../README.md)　>　最新バージョンへのアップデートについて

---

## 最新バージョンへのアップデートについて

以前のF.O.X SDKが導入されたアプリに最新のSDKを導入する際に必要な手順は以下の通りです。

### 1. SDKの入れ替え
以前のバージョンの下記のファイルがプロジェクトに組み込まれていれば、それらを削除する。
* AppAdForce.plist
* libAppAdForce.a
* AdManager.h
* AnalyticsManager.h
* Ltv.h
* Notify.h
* libFoxSdk.a
* DLAdStateDelegate.h
* DLBannerView.h
* DLInterstitialViewController.h

「[1. インストール](../../../README.md#install_sdk)」からドキュメントに従いもう一回導入手順を実施する。

#### CocoaPodsの場合
Podfileに以下の指定を
```ruby
pod "foxSdk"
```
以下のように変更します。
```ruby
pod "CYZFox"
```

#### Swiftの場合
Bridging headerファイルに記載したFOX SDKと関連あるheaderのimportを全て削除する。
```objc
// 下記を削除する
#import "AdManager.h"
#import "Ltv.h"
#import "AnalyticsManager.h"
```

### 2. ソースの変更
#### 2.1 import
4.0.0からframework libraryのextensionを採用するので、過去のheaderごとのimportを下記のように変更する。
```objc
#import <CYZFox/CYZFox.h>
#import <FOXExtension/FOXExtension.h> // 需要の場合だけ追加
```
#### 2.2 計測の実装箇所
|計測|4.0.0以前|4.0.0から|
|---|---|---|
|基本設定|AppAdForce.plistの記載項目:<br/>`APP_ID`<br/>`APP_SALT`<br/>`ANALYTICS_APP_KEY`|CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:4879<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;salt:@"xxxxx" <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;appKey:@"yyyyyy"];<br/>[foxConfig activate];|
|サーバーURL指定|AppAdForce.plistの記載項目:<br/>`SERVER_URL`<br/>`ANALYTICS_SERVER_URL`|[foxConfig withFOXServerURL:@"xxxxx"];<br>[foxConfig withAnalyticsServerURL:@"yyyyy"];<br>[foxConfig activate];
|DEBUGモード指定|[adManager setDebugMode:YES]|[foxConfig enableDebugMode];<br>[foxConfig activate];
|UIWebViewで計測指定|[ltv setLtvCookie]|[foxConfig enableWebViewTracking];<br>[foxConfig activate];
|インストール計測|[adManager sendConversionWithStartpage:@"default"]|[CYZFox trackInstall]|
|リエンゲージメント計測|[adManager setUrlScheme:url]|[CYZFox handleOpenURL:url]|
|セッション計測|[ForceAnalyticsManager sendtrackSession];|[CYZFox trackSession]|
|イベント計測<br/>(課金)|[ltv addParameter:LTV_PARAM_PRICE :@"9.99"];<br/>[ltv addParameter:LTV_PARAM_CURRENCY :@"USD"]<br/>[ltv sendLtv:123]<br/> [AnalyticsManager trackEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:nil price:9.99 quantity:1 currency:@"USD";|CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"purchase" andLtvId:123];<br/>event.price = 9.99;<br/>event.currency = @"USD";<br/>[CYZFox trackEvent:event];|
|イベント計測<br/>(チュートリアル完了)|[AnalyticsManager trackEvent:@"Tutorial" action:nil label:nil value:0]|[CYZFox trackEvent:[[CYZFoxEvent alloc] initWithEventName:@"Tutorial"]];|



SDK のアップデート後は、必ず効果測定テストを実施し、計測及びアプリケーションの動作に問題ないことを確認してください。
> ※1 バージョン4.0.0以降にマイグレーションする際、これまで旧バージョンで指定していた`イベント名`を変更してしまうと、アクセス解析にて計測してきた集計データが引き継がれなくなりますのでご注意ください。

---
[トップ](../../README.md)
