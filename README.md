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

// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];
```

sendConversionWithStartPage:の引数には通常は上記の通り@"default"という文字列を入力していただければ問題はありません。
[sendConversionWithStartPage:の詳細について](http://xxx)

また、URLスキーム経由の起動を計測するために、application:openURL:にsetUrlScheme:メソッドを実装します。

```objectivec
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

[[AppAdForceManager sharedManager] setUrlScheme:url];
```




