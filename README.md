# Force Opetaion Xとは

Force Operation X (以下F.O.X)は、スマートフォンにおける広告効果最適化のためのトータルソリューションプラットフォームです。アプリケーションのダウンロード、ウェブ上でのユーザーアクションの計測はもちろん、スマートフォンユーザーの行動特性に基づいた独自の効果計測基準の元、企業のプロモーションにおける費用対効果を最大化することができます。

本ドキュメントでは、スマートフォンアプリケーションにおける広告効果最大化のためのF.O.X SDK導入手順について説明します。

## F.O.X SDKとは

F.O.X SDKをアプリケーションに導入することで、以下の機能を実現します。

* **インストール計測**

広告流入別にインストール数を計測することができます。

* **LTV計測**

流入元広告別にLife Time Valueを計測します。主な成果地点としては、会員登録、チュートリアル突破、課金などがあります。各広告別に登録率、課金率や課金額などを計測することができます。

* **アクセス解析**

自然流入と広告流入のインストール比較。アプリケーションの起動数やユニークユーザー数(DAU/MAU)。継続率等を計測することができます。

* **プッシュ通知**

F.O.Xで計測された情報を使い、ユーザーに対してプッシュ通知を行うことができます。例えば、特定の広告から流入したユーザーに対してメッセージを送ることができます。

## 1. インストール

ダウンロードしたSDK「FOX_iOS_SDK_<version>.zip」を展開し、以下ファイルをXcodeの任意の場所にコピーを行い、アプリケーションのプロジェクトに組み込んでください。

各ファイルの説明は以下の通りです。

<table>
<tr><th>機能名</th><th>必須?</th><th>ファイル名</th></tr>
<tr><td>ライブラリ本体</td><td>必須</td><td>libAppAdForce.a</td></tr>
<tr><td>インストール計測</td><td>必須</td><td>AdManager.h</td></tr>
<tr><td>LTV計測</td><td>オプション</td><td>Ltv.h</td></tr>
<tr><td>アクセス計測</td><td>オプション</td><td>AnalyticsManager.h</td></tr>
<tr><td>プッシュ通知</td><td>オプション</td><td>Notify.h</td></tr>
</table>

[TODO: インストールの詳細](http://xxx)

## 2. 設定

* **フレームワーク設定**

次のフレームワークをプロジェクトにリンクしてください。

<table>
<tr><th>フレームワーク名</th><th>Status</th></tr>
<tr><td>AdSupport.framework</td><td>Optional</td></tr>
<tr><td>iAd.framework </td><td>Required</td></tr>
<tr><td>SystemConfiguration.framework </td><td>Required </td></tr>
<tr><td>Security.framework </td><td>Required </td></tr>
<tr><td>StoreKit.framework </td><td>Required </td></tr>
</table>

> AdSupport.frameworkはiOS 6以降で追加されたフレームワークのため、アプリケーションをiOS 5以前でも動作させる(iOS Deployment Targetを5.1以下に設定する)場合にはweak linkを行うために”Optional”に設定してください。

[TODO: フレームワーク設定の詳細](http://xxx)

* **SDK設定**

SDKの動作に必要な設定をplistに追加します。「AppAdForce.plist」というファイルをプロジェクトの任意の場所に作成し、次のキーと値を入力してください。

<table>
<tr>
  <th>Key</th>
  <th>Type</th>
  <th>Value</th>
</tr>
<tr>
  <td>APP_ID</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>SERVER_URL</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>APP_SALT</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>APP_OPTIONS</td>
  <td>String</td>
  <td>何も入力せず、空文字の状態にしてください。</td>
</tr>
<tr>
  <td>CONVERSION_MODE</td>
  <td>String</td>
  <td>1</td>
</tr>
<tr>
  <td>ANALYTICS_APP_KEY</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。<br />アクセス解析を利用しない場合は設定の必要はありません。</td>
</tr>
</table>

[TODO: SDK設定の詳細](http://xxx)
[TODO: AppAdForce.plistサンプル](http://xxx)

## 3. インストール計測の実装

初回起動のインストール計測を実装することで、広告の効果測定を行うことができます。プロジェクトのソースコードを編集し、Application Delegateのapplication:didFinishLaunchingWithOptions:に次の通り実装を行ってください。

```objectivec
#import "AdManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];

// }
```

sendConversionWithStartPage:の引数には、通常は上記の通り@"default"という文字列を入力してください。

[sendConversionWithStartPage:の詳細について](http://xxx)

また、URLスキーム経由の起動を計測するために、application:openURL:にsetUrlScheme:メソッドを実装します。

```objectivec
// - (BOOL)application:(UIApplication *)application
//   openURL:(NSURL *)url
//   sourceApplication:(NSString *)sourceApplication
//   annotation:(id)annotation {

[[AppAdForceManager sharedManager] setUrlScheme:url];

// }
```

## 4. LTV計測の実装

会員登録、チュートリアル突破、課金など任意の成果地点にLTV計測を実装することで、流入元広告のLTVを測定することができます。LTV計測が不要の場合には、本項目の実装を省略できます。

```objectivec
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv sendLtv:{成果地点ID}];
```

LTV計測を行うためには、各成果地点を識別する成果地点IDが発行されている必要があります。{成果地点ID}に発行されたIDをintで指定してください。

課金計測を行う場合には、課金が完了した箇所で以下のように課金額と通貨コードを指定してください。

```objectivec
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv sendLtv:{成果地点ID}];
[ltv addParameter:LTV_PARAM_PRICE:@"9.99"];
[ltv addParameter:LTV_PARAM_CURRENCY:@"USD"];
```

[タグを利用したLTV計測について](http://xxx)

## 5. アクセス解析の実装

自然流入と広告流入のインストール数比較、アプリケーションの起動数やユニークユーザー数(DAU/MAU)、継続率等を計測することができます。アクセス解析が不要の場合には、本項目の実装を省略できます。

アプリケーションの起動、及びバックグラウンドからの復帰を計測するために、application:didFinishLaunchingWithOptions:およびapplicationWillEnterForegroundにコードを追加します。

```objectivec
#import "AnalyticsManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[ForceAnalyticsManager sendStartSession];

//}

// - (void)applicationWillEnterForeground:(UIApplication *)application {

[ForceAnalyticsManager sendStartSession];

//}
```

sendStartSessionは必ず上記二カ所に実装を行ってください。

[アクセス解析によるカスタムイベント計測](http://xxx)
[アクセス解析による課金計測](http://xxx)

## 疎通テストの実施

マーケットへの申請までに、SDKを導入した状態で十分にテストを行い、アプリケーションの動作に問題がないことを確認してください。

インストール計測の通信は、起動後に一度のみ行わるため、続けて効果測定テストを行いたい場合には、アプリケーションをアンインストールし、再度インストールから行ってください。

* **テスト手順**

1. テスト用端末にテストアプリがインストールされている場合には、アンインストール
1. テスト用端末の「設定」→「Safari」→「Cookieとデータを消去」によりCookieを削除
1. 弊社より発行したテスト用URLをクリック
1. マーケットへリダイレクト
1. テスト用端末にテストアプリをインストール<br />
1. アプリを起動、ブラウザが起動<br />
ここでブラウザが起動しない場合には、正常に設定が行われていません。設定を見直していただき、問題が見当たらない場合には弊社へご連絡ください。
1. LTV地点まで画面遷移<br />
1. アプリを終了し、バックグラウンドからも削除<br />
1. 再度アプリを起動<br />

弊社へ3、6、7、9の時間をお伝えください。正常に計測が行われているか確認いたします。弊社側の確認にて問題がなければテスト完了となります。

> テスト用URLは必ず標準のSafari上でリクエストされるようにしてください。Chromeなどの3rd partyブラウザ、メールアプリやQRコードアプリを利用されそのアプリ内WebViewで遷移した場合には計測できません。

> テストURLをクリックした際に、遷移先がなくエラーダイアログが表示される場合がありますが、疎通テストにおいては問題ありません。

## SDKの最新バージョンへのアップデートについて

## 最後に必ずご確認ください（これまで発生したトラブル集）

## その他機能の実装

[プッシュ通知の実装](http://xxx)
[オプトアウトの実装](http://xxx)
[管理画面上に登録したバンドルバージョンに応じた処理の振り分け](http://xxx)

