## sendConversionWithStartPage:の詳細

`sendConversionWithStartPage:`メソッドを利用することで、インストール計測を行うことができます。Cookie計測を利用する場合には、外部ブラウザが起動されます。この際、外部ブラウザの遷移先を`sendConversionWithStartPage:`の引数にURL文字列を指定することができます。

プロジェクトのソースコードを編集し、Application Delegateの`application:didFinishLaunchingWithOptions:`に次の通り実装を行ってください。

> 【ご注意】
sendConversionWithStartPage:は、特に理由がない限りは`application:didFinishLaunchingWithOptions:`内に実装してください。それ以外の箇所に実装された場合にはインストール数が正確に計測できない場合があります。
`application:didFinishLaunchingWithOptions:`に実装していない状態でインストール成果型の広告を実施する際には、必ず広告代理店もしくは媒体社の担当にその旨を伝えてください。正確に計測が行えない状態でインストール成果型の広告を実施された際には、計測されたインストール数以上の広告費の支払いを求められる恐れがあります。

```objective-c
#import "AdManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];

// }
```

sendConversionWithStartPage:の引数には、通常は上記の通り@"default"という文字列を入力してください。デフォルトでは標準で用意されたページが表示されますが、遷移先のURLをF.O.X管理画面上で任意に設定することが可能です。

![sendConversion01](./img01.png)

特定のURLヘ遷移させたい場合や、アプリケーションで動的にURLを生成したい場合には、URLの文字列を設定してください。

```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html"];
```

`sendConversionWithStartPage:`の代わりに`sendConversionWithStartPage:buid:`メソッドを利用し、成果ログに広告主端末IDを付与することができます。例えば、アプリ起動時にUUIDを生成し、初回起動の成果と紐付けて管理したい場合等に、利用できます。

```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html" buid:@"{your uniq id}"];
```
> `sendConversionWithStartPage:buid:`は起動直後の処理として実装される必要があるため、ログインIDなどのユーザーアクションが伴う値を引数として渡すことはできません。


## Fingerprint計測時の注意事項

Fingerprint計測はWebViewを使用しており、UserAgentを独自のカスタマイズを行っている場合正常に計測することが出来なくなります。WebViewのUserAgentを独自の文字列にカスタマイズを行う前に次のメソッドを必ず実装してください。```objective-c
[[AppAdForceManager sharedManager] cacheDefaultUserAgent];```

## 3.2.	v2.16g未満からご利用頂いている場合

これまでリエンゲージメント計測を実施する際、`didFinishLaunchingWithOptions:`内に
`setUrlSchemeWithOptions:`メソッドを実装する仕様となっておりましたが、`setUrlScheme:`メソッドに仕様を統合したため、本ドキュメントからは実装の記載を削除しております。

[削除]
```objective-c
  [[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];
```
尚、下位互換性を保つため、これまで通り呼び出すことが可能です。---[TOPへ](/lang/ja/README.md)