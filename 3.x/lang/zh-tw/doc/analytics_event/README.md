## 依靠流量分析進行Event計測

能夠計測按不同廣告流入和自然流入的用戶在APP裡面引發的Event。請在想要做Event計測的全部地點追加代碼。

為了進行依據流量分析的Event計測，請安裝下面的sendEvent方法。

```objective-c
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label value:(NSUInteger)value;
```

sendEvent方法的參數說明如下。

|參數|型|最大長度|概要|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|設定能夠識別計測Event的任意名稱。|
|action|NSString*|255|設定屬於Event的Action名。可以自由設定。可以為nil。|
|label|NSString*|255|設定屬於Event的Label名。可以自由設定。可以為nil。|
|value|NSUInteger|255|指定Event次數。可以為1。|



```objective-c
#import "AnalyticsManager.h"

//- (void) didTutorial {
    // Event的發送
    [ForceAnalyticsManager sendEvent:@“教程突破" action:nil label:nil value:1];
//}
```

---
[TOPへ](/lang/zh-tw/README.md)
