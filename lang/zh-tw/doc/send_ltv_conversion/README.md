## sendLtv的詳細

通過在會員登錄，新手教程突破，消費等任意的成果地點安裝LTV計測處理，能夠測定不同廣告流入的LTV成果。

請按照如下格式安裝LTV計測的代碼。

```objc
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init]];
[ltv sendLtv:{成果地點ID}];
```

> **成果地點ID**(必需) : 請輸入Force Operation X管理員告知的值。

#### 指定廣告主終端ID(buid)

在APP內部的成果裡可以包含廣告主終端ID（USER ID等），能夠進行以此為基準的成果計測。
請按如下代碼來給LTV成果設置廣告主終端ID。

```objc
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init]];
[ltv sendLtv:{成果地点ID}:{広告主端末ID}];
```

> **広告主端末ID**(任意) : 是指貴公司管理的唯一識別ID(USER ID等)。可以指定64文字以內的半角英文數字。

---
[Top](/lang/zh-tw/README.md)
