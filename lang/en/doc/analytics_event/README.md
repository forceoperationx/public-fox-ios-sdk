## Event tracking by using access analytics

Access Analytics allows to measure amount of in-app events by ads included organic install. In order to perform event measurement by access analysis, implement the following `sendEvent`.

```objective-c
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label value:(NSUInteger)value;
```

Specification of the arguments of the sendEvent is as follows.

|Parameter|Type|Maximum length|Outline|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|Set the arbitrary name identifying event conducting tracking. It is able to set event name freely.|
|action|NSString*|255|Set the action name belonging to event. It is able to set action name freely. If not specifying, nil is acceptable.|
|label|NSString*|255|Set the label name belonging to action. It is able to set label name freely. If not specifying, nil is acceptable.|
|value|NSUInteger|255|Set the number of events. Basically, please set 1.|


```objective-c
#import "AnalyticsManager.h"

//- (void) didTutorial {
    // send event
    [ForceAnalyticsManager sendEvent:@“tutorial_completion" action:nil label:nil value:1];
//}
```

---
[TOP](/lang/en/README.md)
