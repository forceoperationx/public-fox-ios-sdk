# 廣告投放功能

## 1. 必須類庫

* libDahliaSdk.a
* DLBannerView.h
* DLInterstitialViewController.h
* DLAdStateDelegate.h

## 2. 必須framework
* UIKit.framework
* Foundation.framework
* Security.framework
* SystemConfiguration.framework
* AdSupport.framework

## 3. plist設定文件
**文件名**

`AppAdForce.plist`

**設定項目設定項目**
* `APP_ID`值是案件開始時由敝司發行的ID，是廣告表示必要的資訊。

## 4. API

### DLBannerView
|屬性|類型|詳細|
|---:|:---|:---|
|placementId|NSString|廣告表示ID（管理者發行）|
|adStateDelegate|id<DLAdStateDelegate>|廣告表示時取得事件使用的delegate|

|返回值類型|方法|詳細|
|---:|:---|:---|
|void|show|表示橫幅（Banner）廣告。|

### DLInterstitialViewController
|返回值類型|方法|詳細|
|---:|:---|:---|
|placementId|NSString|廣告表示ID（管理者發行）|
|adStateDelegate|id<DLAdInterstitialStateDelegate>|廣告表示時取得事件使用的delegate|

|返回值類型|方法|詳細|
|---:|:---|:---|
|void|`+(void) showInterstitial:(NSString* _Nonnull) placementId InController:(UIViewController* _Nonnull) controller`<br><br>`placementId` : 廣告表示ID（管理者發行）<br>`controller` : 親ViewController|表示插播廣告的幫助方法。|
|void|`+(void) showInterstitial:(NSString* _Nonnull) placementId InController:(UIViewController* _Nonnull) controller WithDelegate:(id<DLAdInterstitialStateDelegate> _Nullable) adDelegate`<br><br>`placementID` : 廣告表示ID（管理者發行）<br>`controller` : 親ViewController <br>`adDelegate` : 取得廣告表示事件使用的delegate|表示插播廣告的幫助方法。|


## 5. 嵌入到代碼

### 5.1 橫幅廣告表示實例1

```objc
NSString* placementId = xxx; // 由管理員發行
CGRect frame = xxx;// 想要指定的場所和尺寸
DLBannerView* adView = [][DLBannerView alloc] initWithFrame:frame];
adView.placementId = placementId;
[parentView addSubview:adView];
[adView show];
```

### 5.2 橫幅廣告表示實例2

```objc
NSString* placementId = xxx; // 由管理員發行
CGRect frame = xxx;// 想要指定的場所和尺寸
DLBannerView* adView = [][DLBannerView alloc] initWithFrame:frame];
adView.placementId = placementId;
[parentView addSubview:adView];
view.adStateDelegate = bannerStateDelegate;
[adView show];


// DLBannerStateDelegate 安裝
-(void) onAdSuccess:(UIView *) view {
    NSLog(@"onAdSuccess delegate implement");
}

-(void) onAdFailed:(UIView *) view {
    NSLog(@"onAdFailed delegate implement");
}
```

### 5.3 插播廣告表示實例1

```objc
// 表示
NSString* placementId = xxx; // 管理員發行
[DLInterstitialViewController showInterstitial:placementId InController:currentViewCtrl];
```

### 5.4 插播廣告表示實例2

```objc
// 表示
NSString* placementId = xxx; // 管理員發行
[DLInterstitialViewController showInterstitial:placementId InController:currentViewCtrl WithDelegate:interstitialDelegate];


// DLAdInterstitialStateDelegate 安裝
-(void) onAdSuccess:(UIView *) view {
    NSLog(@"onAdSuccess delegate implement");
}

-(void) onAdExit {
    NSLog(@"onAdExit delegate implement");
}

-(void) onAdFailed:(UIView *) view {
    NSLog(@"onAdFailed delegate implement");
}

```

> 使用實例：從畫面A跳轉到畫面B的時候，表示完插播廣告以後讓其跳轉<br>
（畫面A→插播廣告→畫面B）<br>這時，在畫面A裡進行如上的安裝，能夠在`onAdSuccess`,`onAdFailed`,`onAdExit`的各個方法裡安裝跳轉到畫面B的處理。

## 6. 表示實例

<table>
<tr>
<td align="center" style="border-style:none;">[橫幅廣告實例]</td>
<td align="center" style="border-style:none;">[插播廣告實例]</td>
</tr>
<tr>
<td style="border-style:none;"><img src="./sample_banner.jpg" width="300px"/></td>
<td style="border-style:none;"><img src="./sample_interstitial.jpg" width="300px"/></td>
</tr>
</table>

---
[TOP](/lang/zh-tw/README.md)
