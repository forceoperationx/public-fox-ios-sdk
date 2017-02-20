## sendLtvConversionの詳細

会員登録、チュートリアル突破、課金など任意の成果地点にLTV計測を実装することで、流入元広告のLTVを測定することができます。

LTV計測を行う際は以下の実装を行います。

```objc
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init]];
[ltv sendLtv:{成果地点ID}];
```

> **成果地点ID**(必須) : 管理者より連絡します。

#### 広告主端末ID(buid)を指定する

アプリ内部の成果に、広告主端末ID(ユーザーIDなど)を含めることができ、これを基準とした成果計測を行うことが可能となります。
LTV成果に広告主端末IDを付与する際は以下の実装を行います。

```objc
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init]];
[ltv sendLtv:{成果地点ID}:{広告主端末ID}];
```

> **広告主端末ID**(オプション) : 御社で管理されているユニークな識別子(ユーザーID等)を指します。指定出来る値は64文字以内の半角英数字となっています。

---
[トップ](/lang/ja/README.md)
