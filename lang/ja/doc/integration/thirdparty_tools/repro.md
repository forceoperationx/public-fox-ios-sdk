[TOP](../../../README.md)　>　[サードパーティツールとの連携](./README.md) > **Reproとの連携**

---

# Reproとの連携

[Repro](https://repro.io/)と連携し、F.O.Xで計測した情報を送る際の実装方法を説明します。
管理画面の設定は[ヘルプページ](https://support.forceoperationx.com/hc/ja/articles/360000014841)をご確認ください。
事前に設定したRepro側のユーザーIDを、イベント地点の通信に含めることで、Reproとの連携を行います。

## 実装例

下記の例は会員登録イベント計測地点にてRepro側で設定したユーザーIDを送付する場合の実装例となります。
その他のイベント地点に実装する場合は[イベント計測の詳細](../../track_events/README.md)をご確認ください。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
// Repro SDKの実装
// ...

// Repro側のユーザーIDの設定
[Repro setUserID:@"ABCDEFGHIJ"];

// ...

// 設定したユーザーIDの取得
NSString* userID = [Repro getUserID];

// ユーザーIDをF.O.Xへ送る
CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_register_account" andLtvId:123456];
event.buid = userID;
[CYZFox trackEvent:event];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
// Repro SDKの実装
// ...

// Repro側のユーザーIDの設定
Repro.setUserID("ABCDEFGHIJ")

// ...

// 設定したユーザーIDの取得
let userID = Repro.getUserID()

// ユーザーIDをF.O.Xへ送る
let event:CYZFoxEvent = CYZFoxEvent.init(eventName:"_register_account", ltvId:123456)
event.buid = userID
CYZFox.trackEvent(event)
```

## 注意事項

* Repro SDKの導入が必要になります。
* Reproの実装方法につきましてはReproへお問い合わせください。
* F.O.X管理画面で設定が必要です。[ヘルプページ](https://support.forceoperationx.com/hc/ja/articles/360000014841)もあわせてご確認ください。
