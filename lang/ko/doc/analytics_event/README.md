## 액세스 해석에 의한 이벤트 계측

자연 유입 경유를 포함한 광고 별로 사용자가 앱 내에서 일으키는 이벤트를 측정 할 수 있습니다. 이벤트를 측정하고자하는 모든 지점에 코드를 추가합니다.

액세스 해석에 의한 이벤트 측정을 위해 다음 sendEvent 메소드를 구현합니다.

```objective-c
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label value:(NSUInteger)value;
```

sendEvent 메소드의 파라미터의 사양은 아래와 같습니다.

|파라미터|형|최대 길이|개요|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|측정하는 이벤트를 식별 할 수있는 모든 이름을 설정합니다. 이벤트 이름은 자유롭게 설정 가능합니다.|
|action|NSString*|255|이벤트에 속하는 작업 이름을 설정합니다. 액션 이름은 자유롭게 설정 가능합니다. nil도 가능합니다.|
|label|NSString*|255|이벤트에 속하는 레이블 이름을 설정합니다. 레이블 이름은 자유롭게 설정 가능합니다. nil도 가능합니다.|
|value|NSUInteger|255|이벤트 횟수를 지정합니다. 1이라도 상관 없습니다.|



```objective-c
#import "AnalyticsManager.h"

//- (void) didTutorial {
    // 이벤트 보내기
    [ForceAnalyticsManager sendEvent:@“튜토리얼 돌파" action:nil label:nil value:1];
//}
```

---
[TOP으로](/lang/ko/README.md)
