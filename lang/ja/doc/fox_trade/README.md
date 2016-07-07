# 広告配信機能

## 1. 必須ライブラリ

* libDahliaSdk.a
* DLBannerView.h
* DLInterstitialViewController.h
* DLAdStateDelegate.h

## 2. 必要なframework
* UIKit.framework
* Foundation.framework
* Security.framework
* SystemConfiguration.framework
* AdSupport.framework

## 3. plist設定ファイル
**ファイル名**

`AppAdForce.plist`

**設定項目**
* `APP_ID` 値は案件開始時に弊社より発行させて頂くIDとなります。
広告表示に必須となります。

## 4. API

### DLBannerView
|プローパティー|タイプ|詳細|
|---:|:---|:---|
|placementId|NSString|広告表示ID(管理者より発行されます)|
|adStateDelegate|id<DLAdStateDelegate>|広告表示の際のイベントを取得するためのdelegate|

|返り値型|メソッド|詳細|
|---:|:---|:---|
|void|show|バナー広告を表示します。|

### DLInterstitialViewController
|プローパティー|タイプ|詳細|
|---:|:---|:---|
|placementId|NSString|広告表示ID(管理者より発行されます)|
|adStateDelegate|id<DLAdInterstitialStateDelegate>|広告表示の際のイベントを取得するためのdelegate|

|返り値型|メソッド|詳細|
|---:|:---|:---|
|void|`+(void) showInterstitial:(NSString* _Nonnull) placementId InController:(UIViewController* _Nonnull) controller`<br><br>`placementId` : 広告表示ID (管理者より発行されます)<br>`controller` : 親ViewController|インタースティシャル広告を表示するヘルパーメソッド。|
|void|`+(void) showInterstitial:(NSString* _Nonnull) placementId InController:(UIViewController* _Nonnull) controller WithDelegate:(id<DLAdInterstitialStateDelegate> _Nullable) adDelegate`<br><br>`placementID` : 広告表示ID (管理者より発行されます)<br>`controller` : 親ViewController <br>`adDelegate` : 広告表示のイベントを取得するためのdelegate|インタースティシャル広告を表示するヘルパーメソッド。|

### DLAdOperation
|プローパティー|タイプ|詳細|
|---:|:---|:---|
|placementId|NSString|広告表示ID(管理者より発行されます)|

|返り値型|メソッド|詳細|
|---:|:---|:---|
|void|<br>`-(void) reqestAdInfo:(NSString* _Nonnull) placementId`<br>`　success:(_Nonnull onReceiveAdInfo) success`<br>`　failure:(_Nullable onFailure) failure`<br><br>`placementId` : 広告表示ID (管理者より発行されます)<br>`success` : 成功時のJsonをコールバック<br>`failure` :　失敗時のコールバック<br><br>|バナー広告を表示するための情報をJson形式で取得する|
|void|<br>`+(void) sendImp:(NSString* _Nonnull) placementId`<br>`　impStatus:(BOOL) impStatus`<br>`　sessionId:(NSString* _Nonnull) sessionId`<br><br>`placementId` : 広告表示ID (管理者より発行されます)<br>`impStatus` : 表示有無<br>`sessionId` : APIから取得したセッション情報<br><br>|広告情報が表示されたかを送る|
|void|<br>`+(void) sendClick:(NSString* _Nonnull) placementId`<br>` sessionId:(NSString* _Nonnull) sessionI`<br><br>`placementId` : 広告表示ID (管理者より発行されます)<br>`sessionId` : APIから取得したセッション情報<br><br>|広告情報がクリックされた時に送る|


## 5. コードへの組み込み

### 5.1 バナー広告表示サンプル その１

```objc
NSString* placementId = xxx; // 管理者より発行される
CGRect frame = xxx;// 指定したい場所とサイズ
DLBannerView* adView = [][DLBannerView alloc] initWithFrame:frame];
adView.placementId = placementId;
[parentView addSubview:adView];
[adView show];
```

### 5.2 バナー広告表示サンプル その２

```objc
NSString* placementId = xxx; // 管理者より発行される
CGRect frame = xxx;// 指定したい場所とサイズ
DLBannerView* adView = [][DLBannerView alloc] initWithFrame:frame];
adView.placementId = placementId;
[parentView addSubview:adView];
view.adStateDelegate = bannerStateDelegate;
[adView show];


// DLBannerStateDelegate 実装
-(void) onAdSuccess:(UIView *) view {
    NSLog(@"onAdSuccess delegate implement");
}

-(void) onAdFailed:(UIView *) view {
    NSLog(@"onAdFailed delegate implement");
}
```

### 5.3 インタースティシャル広告表示サンプル その１

```objc
// 表示
NSString* placementId = xxx; // 管理者より発行される
[DLInterstitialViewController showInterstitial:placementId InController:currentViewCtrl];
```

### 5.4 インタースティシャル広告表示サンプル その２

```objc
// 表示
NSString* placementId = xxx; // 管理者より発行される
[DLInterstitialViewController showInterstitial:placementId InController:currentViewCtrl WithDelegate:interstitialDelegate];


// DLAdInterstitialStateDelegate 実装
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

> 使用例 : 画面A→画面Bへ遷移する際、インタースティシャル広告を表示してから遷移させるなど<br>
（画面A→インタースティシャル広告→画面B）<br>その場合、画面Aにて上記実装を行い、`onAdSuccess`,`onAdFailed`,`onAdExit`の各々のメソッド内に画面Bへの遷移する処理を実装することで可能となります。

### 5.5 カスタム広告のサンプル その３

```objc    

@property (nonatomic,strong) NSString* placementId; // 管理者より発行される
@property (nonatomic,strong) NSString *sessionID;   // レスポンスJsonから取得

    // APIから広告表示に必要なデータを取得する
    DLAdOperation *adOperation = [DLAdOperation new];
    [adOperation requestAdInfo:self.placementId
                      success:^(NSDictionary * _Nonnull receiveObject) {

                          dispatch_async(dispatch_get_main_queue(), ^{

                              UIWebView *webView = [UIWebView new];
                              webView.scalesPageToFit = YES;
                              webView.delegate = self;
                              CGRect viewframe = xxx;      // 指定したい場所とサイズ
                              webView.frame = viewframe
                              [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:receiveObject[@"curl"]]]];
                              self.sessionID = receiveObject[@"session"];
                              [self.view addSubview:webView];

                              UIButton *button = [UIButton new];
                              button.frame = webView.frame;
                              [button addTarget:self
                                         action:@selector(adClick:) forControlEvents:UIControlEventTouchUpInside];
                              [self.view addSubview:button];
                              [webView bringSubviewToFront:button];
                          });
                      }
                      failure: ^{
                          NSLog(@"failure");
                      }];

```

```objc

-(void) webViewDidFinishLoad:(UIWebView*) webView {

    [DLAdOperation sendImp:self.placementId
                 impStatus:YES
                 sessionId:self.sessionID];

}

-(void) webView:(UIWebView *) webView didFailLoadWithError:(NSError *) error {

    [DLAdOperation sendImp:self.placementId
                 impStatus:NO
                 sessionId:self.sessionID];

}

-(void) adClick:(UIButton*) button {

    [DLAdOperation sendClick:self.placementId
                   sessionId:self.sessionID];
}

```

## 6. 表示サンプル

<table>
<tr>
<td align="center" style="border-style:none;">[バナー広告サンプル]</td>
<td align="center" style="border-style:none;">[インタースティシャル広告サンプル]</td>
</tr>
<tr>
<td style="border-style:none;"><img src="./sample_banner.jpg" width="300px"/></td>
<td style="border-style:none;"><img src="./sample_interstitial.jpg" width="300px"/></td>
</tr>
</table>

---
[トップ](/lang/ja/README.md)
