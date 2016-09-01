# ViewToppage(アプリトップ訪問)イベント実装

View Home（ホーム画面）イベントが発生する箇所に、下記に従ってアクセス解析のイベント計測機能を実装ください。

### 実装例

```objc
#import <FOXExtension/FOXExtension.h>

FOXViewToppageEvent* event = [[FOXViewToppageEvent alloc] initWithLtvId:00000];
[event setUserId:@"USER_A001"];
[event setCretioPartnerId:@"XXXXX"];
[event setDin:[NSDate new]];
[FOXTrack sendEvent:event];
```

### FOXViewToppageEvent API

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

4. `-(void) setCategoryId:(nonnull NSString*) categoryId`
> カテゴリーIDを指定する場合使用します
> <br/>@param `categoryId` カテゴリーID


### 連携対応済み媒体

* Criteo
* Vizury

---
[戻る](../../../track_events/README.md#supported_events)

[トップ](../../../../README.md)
