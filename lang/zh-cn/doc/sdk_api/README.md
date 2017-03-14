# FOX SDK API

<div id="foxconfig"></div>

## 1. CYZFoxConfig

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|appId|NSString|readonly, 管理界面中生成的APP ID|
|salt|NSString|readonly, 管理界面中生成的slat|
|appKey|NSString|readonly, 管理界面中生成的APP KEY|
|foxServerURL|NSString|Deliver服务器URL|
|analyticsServerURL|NSString|访问解析服务器URL|
|debugMode|BOOL|readonly, 是否生成调试日志|
|webViewTrackingEnabled|BOOL|UIWebView中计测功能是否有效|
|customizedUserAgentEnabled|BOOL|定制化UserAgent的支持是否有效|

#### Instance Methods
1. `-(void) enableDebugMode`
> 利用Logcat输出发生错误时的消息和堆栈跟踪（Stack Trace）

2. `-(void) enableWebViewTracking`
> UIWebView中计测功能设为有效

3. `-(void) activate`
> 设置的信息会在SDK内部反映。注意，只保存第一次呼出时的设置值。

４. `-(void) enableCustomizedUserAgent`
> 定制化UserAgent的支持是否有效

#### Static Methods

1.
```objc
+(nullable CYZFoxConfig*) configWithAppId:(NSUInteger) appId salt:(nonnull NSString*) salt appKey:(nonnull NSString*) appKey;
```
> 构造函数方法，所需属性会在初始化时被设置。
> <br/>@param `appId` 管理界面中生成的APP ID
> <br/>@param `salt` 管理界面中生成的salt
> <br/>@param `appKey` 管理界面中生成的APP KEY


<div id="CYZFox"></div>

## 2 CYZFox

#### Static Methods

1. `+(void) trackInstall`
> 计测安装后首次启动的方法。根据管理界面中的设置进行操作。

2. `+(void) trackInstallWithOption:(nonnull CYZFoxTrackOption*) option`
> 计测安装后首次启动的method方法。根据FoxOption中设置的计测选项进行操作。
> <br/>@param [`option`](#CYZFoxTrackOption) 计测指定选项

3. `+(void) handleOpenURL:(nonnull NSURL*) url`
> 收取Cookie计测和流失唤回广告计测用的URL scheme的方法
> <br/>@param `url` 从外部启动APP的URL

4. `+(void) trackSession`
> 进行session计测

5. `+(void) trackEvent:(nonnull CYZFoxEvent*) event`
> 进行事件计测
> <br/>@param [`event`](#foxevent) 事件信息详情

6. `+(nullable NSDictionary*) getUserInfo`
> 获取计测所有事件时的用户信息和属性

7. `+(void) setUserInfo:(nonnull NSDictionary*) userInfo`
> 设置计测所有事件时的用户信息和属性
> <br/>@param `userInfo` 以JSON形式设置信息和属性

8. `+(BOOL) isConversionCompleted`
> Install计测完成后用boolean返回结果

9. `+(void) trackEventByBrowser:(nonnull NSString*) redirectURL`
> 对设置事件标签的外部网页进行事件计测
> <br/>@param `redirectURL` 埋入事件标签的外部网页URL


<div id="CYZFoxTrackOption"></div>
## 3 CYZFoxTrackOption

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|optout|BOOL|OptOut是否输出setter<br>※默认 : false|
|redirectURL|NSString|浏览器启动后的自动跳转页面|
|buid|NSString|Buid的setter|
|onTrackFinished|Block|不推荐，首次启动计测成功时的callback|
|trackingCompletionHandler|Block|初次启动计测完成时的Callback方法。|
|deferredDeeplinkHandler|Block|取得Deferred Deeplink时候的Callback方法。<br>_Callback参数_：<br>`deeplinkInfo` -- NSDictionary、JSON类型deeplink的信息|
|durationSinceClick|NSTimeInterval|从点击到Deferred deeplink的有效期限。以秒为单位|

<div id="foxevent"></div>

## 4 CYZFoxEvent

#### Properties
|Property|Type|Detail|
|:---|:---|:---|
|ltvId|NSUInteger|管理界面中生成的LTV ID|
|buid|NSString|client user ID|
|extraInfo|NSDictionary|任意Key-Value信息|
|eventName|NSString|事件名|
|value|NSUInteger|事件相关值|
|orderId|NSString|购买事件的order ID|
|sku|NSString|道具 SKU|
|itemName|NSString|道具名|
|price|NSString|道具**单价**|
|quantity|NSString|道具数量|
|currency|NSString|单价货币|
|eventInfo|NSDictionary|自定义JSON形式信息|

#### Instance Methods
1. `-(nullable instancetype) initWithEventName:(nonnull NSString*) eventName`
> 指定初始化方法、事件名。
> <br/>@param `eventName` 事件名

2. `-(nullable instancetype) initWithEventName:(nonnull NSString*) eventName andLtvId:(NSUInteger) ltvId`
> 指定初始化方法、事件名和LTV ID。
> <br/>@param `eventName` 事件名
> <br/>@param `ltvId` 管理画面中发行的LTV ID

3. `-(void) addExtraValue:(nonnull NSString*) value forKey:(nonnull NSString*) key`
> 添加任意Key-Value信息
> <br/>@param `value` Value
> <br/>@param `key` Key

#### Static Methods
1.
```objc
+(nullable CYZFoxEvent*) makePurchaseEventWithEventName:(nonnull NSString*) eventName
                                               ltvId:(NSUInteger) ltvId
                                               price:(double) price
                                            currency:(nullable NSString*) currency;
```
> 生成购买事件的helper方法
> <br/>@param `eventName` 事件名
> <br/>@param `ltvId` 管理画面中发行的LTV ID
> <br/>@param `price` 单价
> <br/>@param `currency` 单价货币


---
[トップ](../../README.md)
