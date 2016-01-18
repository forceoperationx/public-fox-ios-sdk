## sendConversionWithStartPage:的詳細

利用`sendConversionWithStartPage:`方法能夠進行Install計測。如果使用Cookie計測手法，外部瀏覽器將被啟動。這個時候，可以把外部瀏覽器的跳轉目的地用字符串形式指定到`sendConversionWithStartPage:`的參數裡。

編輯項目的源代碼，請按下面那样来安装到Application Delegate的`application:didFinishLaunchingWithOptions:`里。

> 【注意事项】
沒有特別的理由請將`sendConversionWithStartPage:`安裝在`application:didFinishLaunchingWithOptions:`裡面。安裝在別的地點可能無法正確計測安裝數。
在沒有安裝`application:didFinishLaunchingWithOptions:`的狀態下投放安裝成果型廣告的時候，請一定事先通知廣告代理店或者媒體負責人。不能正常計測的狀態下投放安裝成果型廣告，可能被要求支付超過計測安裝數的廣告費用。

```objective-c
#import "AdManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];

// }
```

通常在sendConversionWithStartPage:的參數裡像上面那樣輸入@"default"。默認是顯示準備好的標準頁面，可以在FOX管理畫面裡任意設定跳轉目標頁面的URL。

![sendConversion01](./img01.png)

想要跳轉至特定URL的場合，或者用APP動態生成URL的場合，請設定URL字符串。

```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html"];
```
代替`sendConversionWithStartPage:`使用`sendConversionWithStartPage:buid:`方法、能夠輸出廣告主終端設備ID到成果LOG裡。比如，如果想用APP起動時生成的UUID和初次啟動的成果綁定到一起做管理，可以利用這個方法。

```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html" buid:@"{your uniq id}"];
```
> 作為剛啟動後的處理需要實際安裝`sendConversionWithStartPage:buid:`，但像登錄ID這樣的用戶行為相伴的值無法通過參數傳遞。

## Fingerprint計測的注意事項

Fingerprint計測使用WebView，使用獨自的定制化UserAgent的時候，將無法正常計測。把WebView的UserAgent定制化成特定字符串之前，請一定安裝下面的方法。```objective-c
[[AppAdForceManager sharedManager] cacheDefaultUserAgent];```

## 3.2.	v2.16g以前舊版本的場合

到現在，進行Reengagement計測的時候，需要在`didFinishLaunchingWithOptions:`裡安裝`setUrlSchemeWithOptions:`方法。由於已經統合到`setUrlScheme:`方法裡了，從本文檔開始不再需要安裝。

[削除]
```objective-c
  [[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];
```

此外，為了保持向下兼容性，可以按過去的那種方式來調用。---[TOP](/lang/tw/README.md)