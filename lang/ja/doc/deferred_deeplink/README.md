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
|deferredDeeplinkHandler|Block|ディファードディープリンクを取得した際のコールバック。コールバックはバックグラウンドスレッドで実行されます。|
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

<div id="with_thirdparty"></div>
### 他社ツールのディファードディープリンクを利用する

#### Facebook SDKの場合

以下の例では、F.O.X SDK のインストール計測完了のコールバック内で`FacebookSDK`のディファードディープリンク処理を記述しています。Cookie計測時のブラウザ立ち上げが完了した後にディファードディープリンクによる遷移が行われ、Cookie計測が正常に行われます。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
-(BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // after activate
    CYZFoxTrackOption* option = [CYZFoxTrackOption new];
    option.trackingCompletionHandler = ^ {
        // Facebook SDK でのディファードディープリンク処理を実行
    }
    [CYZFox trackInstallWithOption:option];
    // ...
    return YES; // openURL:メソッドをコールさせるため必ずYESを返してください
}
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let option: CYZFoxTrackOption = CYZFoxTrackOption()
    option.trackingCompletionHandler = {
        // Facebook SDK でのディファードディープリンク処理を実行
    }
    CYZFox.trackInstallWithOption(option)
    return true; // openURL:メソッドをコールさせるため必ずYESを返してください
}
```

> Facebook SDKの実装に関しては[公式ドキュメント](https://developers.facebook.com/docs/app-ads/deep-linking#deferred-deep-linking)を参照ください。

---
[トップ](../../README.md)
