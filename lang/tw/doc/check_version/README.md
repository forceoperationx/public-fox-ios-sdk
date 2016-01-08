## （Option）登錄在管理畫面裡的BundleVersion相對應的不同處理

通過登錄在F.O.X管理畫面裡的版本和執行中APP的版本做比較，能夠依照版本是否一致來執行不同處理。
利用這個機能，可以實現利用F.O.X來控制發布版本和測試版本做不同處理，或者實現只在測試版本裡才執行某些特定處理等任務。
使用本機能不需要安裝。


此外，F.O.X裡使用的BundleVersion相當於CFBundleShortVersionString的值。

為實現對BundleVersion來做相應的處理，需要利用`checkVersionWithDelegate:`方法。請在參數delegate裡安裝CheckVersionDelegate協議以及didLoadVersion:方法。
服務器會接收和處理BundleVersion的查詢，一收到結果就會調用didLoadVersion:。調用didLoadVersion:後，利用`getBundleVersionStatus:`方法能夠判別登錄到管理畫面裡的BundleVersion和執行中APP的BundelVersion是否一致。一致的場合返回YES，不一致的場合返回NO。

下面是這個機能的安裝例子。在想要調用Delegate方法的任意的類頭文件裡定義CheckVersionDelegate協議的安裝。

```objective-c
#import "AdManager.h"
// 在任意的類裡追加<CheckVersionDelegate>@interface MyViewController : UIViewController<CheckVersionDelegate>
@end
```

調用`checkVersionWithDelegate:`方法，服務器會接收和處理BundleVersion的查詢。以ViewController類為代表的場合、需要實裝viewDidLoad等。

```objective-c
- (void)viewDidLoad {	[super viewDidLoad];	// 判別登錄到管理畫面裡的BundleVersion和執行中APP的BundelVersion是否一致	[[AppAdForceManager shareManager] checkVersionWithDelegate:self];}
```

安裝委託方法didLoadVersion:。

```objective-c
- (void)didLoadVersion:(id)sender {	// 返回與登錄到管理畫面裡的BundleVersion做比較的結果。	BOOL matches = [[AppAdForceManager sharedManager] getBundleVersionStatus];	// 記述了不一致的場合(例如測試中的Version)的處理。	if(!matches) {		....	}}
```

>用這個方法在F.O.X服務器做查詢，為了減輕負荷，一個用戶每個版本最大5回。超過5回將不能在服務器做查詢，即didLoadVersion:不被調用。如果更新了BundleVersion可以在服務器再做5回查詢。

---
[TOPへ](/lang/tw/README.md)
