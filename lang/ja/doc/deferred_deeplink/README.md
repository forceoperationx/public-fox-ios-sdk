[TOP](../../README.md)　>　ディファードディープリンクの実装

---

# ディファードディープリンクの実装

ディファードディープリンクを実装することで、広告をクリックした際に紐付いているディープリンクにリダイレクトし
アプリ内の対象のページに遷移することが可能となります。また、アプリが未インストールの場合でも、インストール後に
広告のリダイレクト先となるディープリンクに遷移させることが可能となります。

> サポートバージョン : 4.1.0以上

以下、ディファードディープリンクの実装に必要なクラス及び、メソッド情報のみを説明しています。

## FoxTrackOption

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|deferredDeeplinkHandler|Block|ディファードディープリンクを取得した際のコールバック。|
|durationSinceClick|NSTimeInterval|ディファードディープリンクをサーバに問い合わせる際に、対象となるラストクリックの対象期間(秒)（どれだけ遡るかを秒数で指定）。設定しない時、デフォルト24時間となります。|

* `deferredDeeplinkHandler`の詳細

`void (^deferredDeeplinkHandler)(NSDictionary* _Nullable deeplinkInfo)`

`deeplinkInfo` : NSDictionary、JSONタイプのdeeplinkの情報。ディファードディープリンクが存在しない場合や、端末が通信に失敗する場合にはnullを返します。

* `deeplinkInfo`の詳細 :

  |Key|Type|Detail|
  |:---|:---|:---|
  |deeplink|String|取得したディープリンクの文字列|

## 実装例

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
CYZFoxTrackOption* option = [CYZFoxTrackOption new];
option.durationSinceClick = 60 * 60 * 12;
option.deferredDeeplinkHandler = ^(NSDictionary* deeplinkInfo) {
    NSString* url = [deeplinkInfo objectForKey:@"deeplink"];
    NSLog(@"app received url %@", url);
    if (url) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
};
[CYZFox trackInstallWithOption:option];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```swift
let foxTrackOption = CYZFoxTrackOption()
foxTrackOption.durationSinceClick = TimeInterval(60 * 60 * 12)
foxTrackOption.deferredDeeplinkHandler = { deeplinkInfo in
    if let deeplink = deeplinkInfo?["deeplink"] as? String,
        let url = URL(string: deeplink) {
        UIApplication.shared.openURL(url)
    }
    return
}
CYZFox.trackInstall(with: foxTrackOption)
```

---
[トップ](../../README.md)
