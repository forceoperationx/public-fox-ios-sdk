# イベント計測の詳細

以下、各種イベントを実装する際の詳細を説明します。<br>
ダイナミック配信連携を行う際に必要となる実装も含まれます。本実装を行うことで、媒体を横断したイベント計測連携が可能となります。

<div id="install_extension"></div>
## 1. イベント計測拡張プラグインモジュールのインポート

アプリ内の各種イベントの計測を補助するためのサポートライブラリをインポートすることで、イベント計測の実装が容易になります。
サポートライブラリでは[`FOXEvent`](../sdk_api/README.md#foxevent)クラスを拡張し、各種イベント毎のクラスを提供しています。

## 1. 導入
### 1.1 CocoaPods

下記のようにPodfileファイルを更新してください。
* **iOS objective-cで開発する場合**

```ruby
# 下記の一行をPodfileの一番最初に追加してください
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# 下記を指定したいターゲットに追加してください
pod "FOXSDK", "<VERSION>"
pod "FOXSDKEx", "<VERSION>"
```

* **iOS Swiftでdynamic frameworkを利用する場合**
```ruby
# 下記の一行をPodfileの一番最初に追加してください
source "https://github.com/cyber-z/public-fox-ios-sdk.git"

# dynamic frameworkを有効に
use_frameworks!

pod "FOXSDKDy", "<VERSION>"
pod "FOXSDKExDy", "<VERSION>"
```

> ※ `<VERSION>`は指定したいリリースバージョン、4.0.0以上です。



### 1.2 Carthage
```
# 下記のをCartfileに追加してください
github "cyber-z/public-fox-ios-sdk" == 4.0.0
```

## 2. import
拡張イベントを利用するため、下記のimportを追加する。
```objc
#import <FOXExtension/FOXExtension.h>
```

### CocoaPodsの場合
`use_frameworks`を使用しない場合、headerファイル毎のimportが必要になりますので、下記のimportを追加する。
```objc
#import "FOXExtension.h"
```

<div id="supported_events"></div>
## 2. 対応しているイベント計測

> #### 1. [ViewToppageイベント](./01_view_toppage/README.md)
> #### 2. [ViewListingイベント](./02_view_listing/README.md)
> #### 3. [ViewProductイベント](./03_view_product/README.md)
> #### 4. [AddToCartイベント](./04_view_basket/README.md)
> #### 5. [Purchaseイベント](./05_track_transaction/README.md)
> #### 6. [AchieveLevelイベント](./06_achieve_level/README.md)
> #### 7. [ViewCategoryイベント](./07_view_category/README.md)
> #### 8. [Tutorialイベント](./08_tutorial_completion/README.md)
> #### 9. [Searchイベント](./09_search/README.md)

---
[トップ](../../README.md)
