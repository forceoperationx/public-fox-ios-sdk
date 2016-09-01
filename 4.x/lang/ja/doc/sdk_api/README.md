# FOX SDK API

<div id="foxconfig"></div>

## 1. FOXConfig

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|appId|NSString|readonly, 管理画面で発行されたアプリID|
|salt|NSString|readonly, 管理画面で発行されたソルト|
|appKey|NSString|readonly, 管理画面で発行されたアプリKEY|
|foxServerURL|NSString|DeliverサーバーURL|
|analyticsServerURL|NSString|アクセス解析サーバーURL|
|debugMode|BOOL|readonly, デバッグログの出力有無|
|webViewTrackingEnabled|BOOL|UIWebViewで計測する機能有効の有無|

#### Instance Methods
1. `-(nonnull FOXConfig*) withFOXServerURL:(nonnull NSString*) url`
> デバッグ用、またはHTTPS/HTTPを切り替える用のURLのセッター
> <br/>@param `url` 切り替える用DeliverサーバーURL暗号化文字列

2. `-(nonnull FOXConfig*) withAnalyticsServerURL:(nonnull NSString*) url`
> デバッグ用、またはHTTPS/HTTPを切り替える用のURLのセッター
> <br/>@param `url` 切り替える用アクセス解析サーバーURL暗号化文字列

3. `-(nonnull FOXConfig*) withDebugMode`
> エラー時のメッセージやスタックトレースを表示させる

4. `-(nonnull FOXConfig*) withWebViewTrackingEnabled`
> UIWebViewで計測する機能有効にする

5. `-(void) activate`
> 設定した情報をSDK内部で反映する。注意、最初の一回呼ばれる時にだけ設定値が保存される。

#### Static Methods
1.
```objc
+(nullable FOXConfig*) configWithAppId:(NSUInteger) appId salt:(nonnull NSString*) salt appKey:(nonnull NSString*) appKey;
```
> コンストラクタメソッド、必須Propertiesは初期化と同時にセットされます。
> <br/>@param `appId` 管理画面で発行されたアプリID
> <br/>@param `salt` 管理画面で発行されたアプリソルト
> <br/>@param `appKey` 管理画面で発行されたアプリKEY



<div id="foxtrack"></div>

## 2 FOXTrack

#### Static Methods

1. `+(void) onLaunch`
> インストール後の初回起動計測用メソッド。管理画面で設定した通りに動作する

2. `+(void) onLaunchWithOption:(nonnull FOXTrackOption*) option`
> インストール後の初回起動計測用メソッド。インストール後の初回起動計測用メソッド。FoxOptionに設定した計測オプションに従い動作する。
> <br/>@param [`option`](#foxtrackoption) 計測に指定するオプション

3. `+(void) handleOpenURL:(nonnull NSURL*) url`
> Cookie計測とリエンゲージメント計測用URL schemeを受け取るメソッド
> <br/>@param `url` 外部によりアプリを起動させるURL

4. `+(void) startSession`
> セッション計測を行う

5. `+(void) sendEvent:(nonnull FOXEvent*) event`
> イベント計測を行う
> <br/>@param [`event`](#foxevent) イベント情報の詳細

6. `+(nullable NSDictionary*) getUserInfo`
> 全てのイベントに共有される計測する際のユーザー情報・属性等を取得する

7. `+(void) setUserInfo:(nonnull NSDictionary*) userInfo`
> 全てのイベントに共有される計測する際のユーザー情報・属性等を設定する
> <br/>@param `userInfo` JSON形式の設定する情報・属性

8. `+(BOOL) isConversionCompleted`
> インストール計測が完成しているかをbooleanで返す

9. `+(void) trackEventByBrowser:(nonnull NSString*) redirectURL`
> イベントタグを設置した外部のWebページのイベント計測
> <br/>@param `redirectURL` イベントタグを埋め込んだ外部のWebページのURL


<div id="foxtrackoption"></div>

## 3 FOXTrackOption

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|optout|BOOL|OptOut有無のセッター<br>※デフォルト : false|
|redirectURL|NSString|ブラウザ起動後のリダイレクト先|
|buid|NSString|Buidのセッター|
|onTrackFinished|Block|初回起動計測が成功した際のコールバック。|

<div id="foxevent"></div>

## 4 FOXEvent

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|ltvId|NSUInteger|管理画面で発行されたLTV ID|
|buid|NSString|client user ID|
|extraInfo|NSDictionary|任意のKey-Value情報|
|eventName|NSString|イベント名|
|value|NSUInteger|イベントと関係する値|
|orderId|NSString|購入イベントのorder ID|
|sku|NSString|アイテムのSKU|
|itemName|NSString|アイテム名|
|price|NSString|アイテムの**単価**|
|quantity|NSString|アイテムの数|
|currency|NSString|単価の通貨|
|eventInfo|NSDictionary|カスタマイズJSON形式の情報|

#### Instance Methods
1. `-(nullable instancetype) initWithEventName:(nonnull NSString*) eventName`
> 初期化メソッド、イベント名を指定する。
> <br/>@param `eventName` イベント名

2. `-(nullable instancetype) initWithEventName:(nonnull NSString*) eventName andLtvId:(NSUInteger) ltvId`
> 初期化メソッド、イベント名とLTV IDを指定する。
> <br/>@param `eventName` イベント名
> <br/>@param `ltvId` 管理画面で発行されたLTV ID

3. `-(void) addExtraValue:(nonnull NSString*) value forKey:(nonnull NSString*) key`
> 任意のKey-Value情報を追加する
> <br/>@param `value` Value
> <br/>@param `key` Key

#### Static Methods
1.
```objc
+(nullable FOXEvent*) makePurchaseEventWithEventName:(nonnull NSString*) eventName
                                               ltvId:(NSUInteger) ltvId
                                               price:(double) price
                                            currency:(nullable NSString*) currency;
```
> 購入イベントを作成するヘルパーメソッド
> <br/>@param `eventName` イベント名
> <br/>@param `ltvId` 管理画面で発行されたLTV ID
> <br/>@param `price` 単価
> <br/>@param `currency` 単価の通貨
