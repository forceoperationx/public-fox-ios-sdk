## sendLtv의 상세

회원등록,튜토리얼 돌파, 과금등 임의의 성과지점에 LTV계측을 실장하여 주시는 것으로 유입경로별 광고의 LTV계측이 가능합니다.


LTV계측을 하실 경우 이하의 실장을 하여 주십시오.

```objc
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init]];
[ltv sendLtv:{성과지점ID}];
```

> **성과지점ID**(필수) : 관리콘솔상에서 확인가능합니다. 불분명한 경우 support@cyber-z.co.jp에 연락하여 주십시오.

#### 광고주 단말ID(buid)를 지정

앱내부의 성과에 광고주 단말 ID(유저 ID등)을 포함하실 수 있으며 이것을 기준으로 하여 성과 계측이 가능합니다.
LTV성과에 광고주 단말 ID를 부여하실 경우 이하의 실장을 하여 주십시오.

```objc
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init]];
[ltv sendLtv:{성과지점ID}:{광고주 단말ID}];
```

> **광고주 단말 ID**(옵션) : 귀사에서 관리하고 있는 유니크한 식별자(유저 ID등)을 지칭하고 있습니다. 지정 가능한 값은 64문자 이내 영숫자입니다.
---
[TOP](/lang/ko/README.md)
