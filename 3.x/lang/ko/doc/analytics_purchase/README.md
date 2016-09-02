## 액세스 해석에 의한 과금 계측

액세스 해석 기능을 이용하여 자연 유입 경유를 포함한 광고별 이벤트와 매출을 각각 측정 할 수 있습니다.
LTV계측에 있어서도 과금을 성과지점으로 지정한 경우에는, 동일한 장소에 LTV와 액세스 해석의, 각각의 계측 처리를 구현해 주십시오.

액세스 해석에 의한 과금계측을 하기 위해서, 하기와 같이 sendEvent메소드를 구현해 주십시오.

```objective-c
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label orderID:(NSString*)orderID sku:(NSString*)sku itemName:(NSString*)itemName price:(double)price quantity:(NSUInteger)quantity currency:(NSString*)currency;
```

sendEvent 메소드의 파라미터 사양은 하기와 같습니다.

|파라미터|형|최대 길이|개요|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|트래킹을 하는 이벤트를 식별 할 수있는 임의의 이름을 설정합니다. 이벤트명은 자유롭게 설정 가능합니다.|
|action|NSString*|255|이벤트에 속하는 액션명을 설정합니다. 액션명은 자유롭게 설정 가능합니다. 특히 지정이없는 경우에는 null도 관계 없습니다.|
|label|NSString*|255|액션에 속한 라벨명을 설정합니다. 라벨명은 자유롭게 설정 가능합니다. 특히 지정이없는 경우에는 null도 관계 없습니다.|
|orderId|NSString|255|주문 번호 등을 지정합니다. 특히 지정이없는 경우에는 null도 관계 없습니다.|
|sku|String|255|상품 코드 등을 지정합니다. 특히 지정이없는 경우는 null에서도 상관하지 않습니다.|
|itemName|String|255|상품명을 지정합니다. 지정이없는 경우는 비어 두십시오.("")|
|price|double||상품 단가를 지정합니다.|
|quantity|NSUInteger||수량을 지정합니다. price * quantity가 매출액으로 계상됩니다.|
|currency|String||통화 코드를 지정합니다. null의 경우 "JPY"가 지정됩니다.|

> currency에는[ISO 4217](https://ko.wikipedia.org/wiki/ISO_4217)에 정의된 통화 코드를 지정해 주십시오.

아래의 샘플은 일본에서 300엔을 과금한 경우의 예입니다.

```objective-c
#import "Ltv.h"

// LTV計測による課金計測
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv addParameter:LTV_PARAM_PRICE:@"300"];
[ltv addParameter:LTV_PARAM_CURRENCY:@"JPY"];
[ltv sendLtv:성과지점ID];

// 액세스 해석에 의한 과금 계측
[ForceAnalyticsManager sendEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:@"Item A" price:300 quantity:1 currency:@"JPY"];
```

---
[TOP으로](/lang/ko/README.md)
