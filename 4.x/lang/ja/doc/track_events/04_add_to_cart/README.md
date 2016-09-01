# AddToCart(買い物かご)イベント実装

AddToCart（商品購入予定一覧）イベントが発生する箇所に、下記に従ってアクセス解析のイベント計測機能を実装ください。

### 実装例

```objc
#import <FOXExtension/FOXExtension.h>

FOXAddToCartEvent* event = [[FOXAddToCartEvent alloc] initWithLtvId:00000];
[event setUserId:@"USER_A001"];
[event setCretioPartnerId:@"XXXXX"];
[event setDin:[NSDate new]];
[event setDestination:@"destination"];
[event addProductById:@"productId"
        itemLocationId:null
                 price:111
              quantity:1];
[FOXTrack sendEvent:event];
```


### FOXViewListingEvent API

#### Constructor Methods
1. `-(nullable instancetype) init`
> デフォルトのイベント名と 0 の LTV ID を使うコンストラクタ

2. `-(nullable instancetype) initWithLtvId:(NSUInteger) ltvId`
> デフォルトのイベント名と指定したltvIdを使うコンストラクタ
> <br/>@param `ltvId` 指定したいLTV ID

3. `-(nullable instancetype) initWithEventName:(NSString*)eventName andLtvId:(NSUInteger) ltvId`
> 指定したイベント名と指定した LTV IDを使うコンストラクタ
> <br/>@param `eventName` 指定したいイベント名
> <br/>@param `ltvId` 指定したいLTV ID

#### Common Methods
1. `-(void) setUserId:(nonnull NSString*) userId`
> ユーザーIDを指定する場合に使用します。
> <br/>@param `userId` 指定したいユーザーID

2. `-(void) putJsonValue:(nonnull id) value forKey:(nonnull NSString*) key`
> 任意のJSON Key-Valueを追加する場合に使用します。
> <br/>@param `value` value
> <br/>@param `key` key


#### Instance Methods
1. `-(void) setDin:(nonnull NSDate*) din`
> 開始日付の指定のある場合に使用します。
> <br/>@param `din` 日付From

2. `-(void) setDout:(nonnull NSDate*) dout`
> 終了日付の指定のある場合に使用します。
> <br/>@param `dout` 日付To

3. `-(void) setPartnerId:(nonnull NSString*) partnerId`
> CriteoアカウントIDが同一アプリで異なる場合は入力。
> <br/>@param `partnerId` CriteoアカウントID

4.`-(void) addProductById:(nonnull NSString*) productId itemLocationId:(nullable NSString*) itemLocationId price:(double) price quantity:(NSUInteger) quantity;
`
> 閲覧した商品の情報を指定する場合に使用します。
> <br/>@param `productId` 商品ID
> <br/>@param `itemLocationId` ロケーションID(商品の広告を特定の場所や地域に訴求したい場合に設定)
> <br/>@param `price` 商品の単価
> <br/>@param `quantity` 商品数

5. `-(void) setDestination:(nonnull NSString*) destination`
> 旅行アプリなど目的地を指定する場合に使用します。
> <br/>@param `destination` 目的地

6. `-(void) setOrigin:(nonnull NSString*) origin`
> 旅行アプリなど出発地点を指定する場合に使用します。
> <br/>@param `origin` 出発地点

7. `-(void) setItemId:(nonnull NSString*) itemId`
> アイテムIDを指定する場合に使用します。addProductメソッドを使用する場合は呼び出さなくて結構です。
> <br/>@param `itemId` アイテムID


### 連携対応済み媒体

* Vizury
* DynamicRemaketing
* DynalystCommerce


---
[戻る](../../../track_events/README.md#supported_events)

[トップ](/4.x/lang/ja/README.md)
