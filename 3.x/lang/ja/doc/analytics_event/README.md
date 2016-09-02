## アクセス解析によるイベント計測

自然流入経由を含めた広告別にユーザーがアプリ内で起こすイベントを計測することが出来ます。イベントを計測したいすべての地点にコードを追加します。

アクセス解析によるイベント計測を行うために、次のsendEventメソッドを実装します。

```objective-c
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label value:(NSUInteger)value;
```

sendEventメソッドのパラメータの仕様は下記の通りです。

|パラメータ|型|最大長|概要|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|計測を行うイベントを識別できる任意の名前を設定します。イベント名は自由に設定可能です。|
|action|NSString*|255|イベントに属するアクション名を設定します。アクション名は⾃由に設定可能です。nilでも構いません。|
|label|NSString*|255|イベントに属するラベル名を設定します。ラベル名は⾃自由に設定可能です。nilでも構いません。|
|value|NSUInteger|255|イベント回数を指定します。1でも構いません。|



```objective-c
#import "AnalyticsManager.h"

//- (void) didTutorial {
    // イベントの送信
    [ForceAnalyticsManager sendEvent:@“チュートリアル突破" action:nil label:nil value:1];
//}
```

---
[TOPへ](/lang/ja/README.md)
