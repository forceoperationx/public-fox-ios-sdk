# AchieveLevel(レベルアップ)イベント実装

主にゲームアプリなどのレベルアップイベントが発生する箇所に、下記に従ってアクセス解析のイベント計測機能を実装ください。

### 実装例

```objc
#import <FOXExtension/FOXExtension.h>

FOXViewListingEvent* event = [[FOXViewListingEvent alloc] initWithLtvId:00000];
[event setUserId:@"USER_A001"];

[event addTrackInfoByEventLabel:@"eventLabel"
                     eventField:1
                      mainLevel:5
                       subLevel:2
                    description:@"description"
                       dateType:@"dateType";

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

2.`
-(void) addTrackInfoByEventLabel:(nonnull NSString*) eventLabel
                      eventField:(double) eventField
                       mainLevel:(double) mainLevel
                        subLevel:(double) subLevel
                     description:(nullable NSString*) description
                        dateType:(nonnull NSString*) dateType
`
> Levelの詳細情報を追加する
> <br/>@param `eventLabel` ゲーム内のイベント名を指定する場合に使用します。
> <br/>@param `eventField` Chartboostと連携を行う場合に必須となります。詳細は[Chartboost]へ(http://partners.chartboost.com/#general-event-tracking-information)
> <br/>@param `mainLevel` メインレベルを指定する場合に使用します。
> <br/>@param `subLevel` サブレベルを指定する場合に使用します。
> <br/>@param `description` レベルの説明を指定する場合に使用します。
> <br/>@param `dateType` データタイプを指定する場合に使用します。


### 連携対応済み媒体

* Chartboost
* Facebook
* Twitter

---
[戻る](../../../track_events/README.md#supported_events)

[トップ](/4.x/lang/ja/README.md)
