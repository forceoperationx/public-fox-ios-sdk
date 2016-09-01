# Tutorial(チュートリアル完了)イベント実装

チュートリアルイベントが完了したタイミングで、下記に従ってアクセス解析のイベント計測機能を実装ください。

### 実装例


```objc
#import <FOXExtension/FOXExtension.h>

FOXTutorialEvent* event = [[FOXTutorialEvent alloc] initWithLtvId:00000];
[event setUserId:@"USER_A001"];
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

1. `-(void) setItemId:(nonnull NSString*) itemId`
> アイテムIDを指定する場合に使用します。addProductメソッドを使用する場合は呼び出さなくて結構です。
> <br/>@param `itemId` アイテムID

### 連携対応済み媒体

* Facebook
* Twitter
* DynalystGames


---
[戻る](../../../track_events/README.md#supported_events)

[トップ](/4.x/lang/ja/README.md)
