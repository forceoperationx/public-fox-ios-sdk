[TOP](../../../README.md)　>　[サードパーティツールとの連携](./README.md) > **KARTEとの連携**

---

# KARTEとの連携

[KARTE](https://karte.io/)と連携し、F.O.Xで計測した情報を送る際の実装方法を説明します。
管理画面の設定は[ヘルプページ](https://support.forceoperationx.com/hc/ja/articles/360000014841)をご確認ください。
KARTE SDKで設定されたVisitorIDを、F.O.Xの通信に含めることで、KARTEとの連携を行います。

## インストールイベントの実装例

KARTE SDKで設定されたVisitorIDを[CYZFoxTrackOption](../../sdk_api/README.md#CYZFoxTrackOption)クラスを使用してF.O.Xへ通知します。
[インストール計測の実装(オプション指定)](../../track_install/README.md#track_install_optional)も併せてご確認ください。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
// KARTE SDKの実装
[KarteTracker setupWithAppKey: @"YOUR_APP_KEY"];

// ...

// VisitorIDの取得
NSString *visitorId = [[KarteTracker sharedTracker] visitorId];

// 初回起動のインストール計測
CYZFoxTrackOption* option = [CYZFoxTrackOption new];
option.redirectURL = @"myapp://top";
option.buid = visitorId;
option.optout = YES;
option.trackingCompletionHandler = ^ {
  NSLog(@"callback after tracking finished");
}
[CYZFox trackInstallWithOption:option];
```

## その他イベントの実装例

KARTE SDKで設定されたVisitorIDを任意のイベント地点の通信に含めることで、F.O.Xで計測したイベントをKARTEと連携します。
下記の例は会員登録イベント計測地点の実装例となります。
その他のイベント地点に実装する場合は[イベント計測の詳細](../../track_events/README.md)をご確認ください。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
// KARTE SDKの実装
[KarteTracker setupWithAppKey: @"YOUR_APP_KEY"];

// ...

// VisitorIDの取得
NSString *visitorId = [[KarteTracker sharedTracker] visitorId];

// ユーザーIDをF.O.Xへ送る
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_register_account" andLtvId:123456];
event.buid = visitorId;
[CYZFox trackEvent:event];
```

## 注意事項

* KARTE SDKの導入が必要になります。
* KARTEの実装方法につきましてはKARTEへお問い合わせください。
* F.O.X管理画面で設定が必要です。[ヘルプページ](https://support.forceoperationx.com/hc/ja/articles/360000014841)もあわせてご確認ください。
