## 有關更新到最新版本

已經導入了舊版本F.O.X SDK的APP需要更新到最新的SDK，這時請按下面的步驟來進行。
1. 如果開發項目裡含有舊版本的類庫文件和頭文件，請先刪除。
1. 追加最新版本的文件到開發項目裡
1. 執行Xcode的「Product」→「Clean」

在F.O.X iOS SDK v2.12以後，類庫文件只提供libAppAdForce.a。v2.11以前散放的類庫文件全部包含在libAppAdForce.a裡了。在更新的時候如果發現含有下面的文件，請全部刪除。

* libLtv.a
* libAnalytics.a
* libNotify.a

是否確實需要導入最新版，可以通過調用setDebugMode方法來確認。

```objective-c
[[AppAdForceManager sharedManager] setDebugMode:YES];
```
下面的輸出信息裡含有版本號，請確認是否和最新版一致。

```
[5160:c07] ===== FORCE OPERATION X DEBUG DESCRIPTION =====
[5160:c07] Force Operation X SDK v2.13.4g
```
到發布APP的時候請刪掉setDebugMode方法。

更新完SDK以後，請一定去做疏通測試，以確保計測和APP動作沒有發生問題。

## 更新v2.13.4g及以前的舊版本

在F.O.X裡為了按照APP的每個版本來控制動作，使用了BundleVersion。從v2.13.5g開始，做控制動作的BundelVersion的值由CFBundleVersion變成了CFBundleShortVersionString。使用BundleVersion進行控制動作的場合請留意。

## 更新v2.12.1及以前的舊版本

從v2.13g開始，追加了Reengagement計測機能。為了計測通過URL Scheme進入APP的啟動數，請按照「[3. Install計測的安裝](/lang/tw/doc/send_conversion/README.md)」追加安裝`setUrlSchemeWithOptions:以及setUrlSchem:`。


## 更新v2.11.1及以前的舊版本

如果更新v2.11.1及以前舊版本的SDK，必須追加和使用iAd.framework。

## 更新v2.8.1及以前的舊版本
如果更新v2.8.1及以前舊版本的SDK，必須追加和使用AdSupport.framework。

---
[TOP](/lang/tw/README.md)
