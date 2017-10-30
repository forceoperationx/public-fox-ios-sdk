[TOP](../../README.md)　>　FAQ・注意事项

这里总结了到目前为止出现的疑难问题，编码安装事的注意事项等。请务必确认。

## FAQ

### 支持对象的iOS版本是多少？

使用Objective-C开发的话为iOS 7及以上。
使用Swift开发的话为iOS 8及以上。

### F.O.X中使用的BundleVersion是什么？

iOS中，bundle版本具体为以下两种。

* CFBundleVersion
* CFBundleShortVersionString

F.O.X中，上述中CFBundleShortVersionString的值作为管理目的而使用。

### 期待的广告安装数比报表数据低

安装计测的`trackInstall:`及`trackInstallWithOption:`若不在启动后马上执行，在到达地点前离开的用户会被遗漏计测。

`trackInstall:`和`trackInstallWithOption:`在没有特殊情况时，请在`application:didFinishLaunchingWithOptions:`内执行。在其他位置执行可能会导致安装数无法正确计测。

在`application:didFinishLaunchingWithOptions:`中未安装代码的状态投放成果型广告时，请务必告知广告代理店或媒体公司负责人。无法进行正确计测的状态投放成果型广告时，可能会导致需要支付超出实际安装数的广告费用。

### 未设置URL SCHEME的APP上线发布后无法从浏览器跳转至APP

进行Cookie计测时启动浏览器以后，必须使用URL scheme跳转回到APP画面。此时需要设置URL scheme，未设置scheme就上线发布时会导致无法正常迁移。

### URL SCHEME中含有大写字母时，无法正常迁移app。

根据运行环境，会出现因为URL SCHEME 的大小写字母不能判定而导致URL SCHEME 无法正常迁移的情况。请将URL SCHEME 全部设置为小写英文或数字或小数点。

### URL scheme设置与其他公司APP相同时，浏览器跳转了其他APP

iOS中，多个APP设置为同一个URL scheme时，会随机启动APP。由于可能导致无法启动指定的APP，请将URL scheme区别与其他APP来设定。

### 进行短时间内获取大量用户的推广无法正确计测

iOS中，APP启动时超过一定时间主线程被阻止运行时，会强制关闭APP。请注意不要让启动时的初始化处理在主线程上与服务器同时进行通讯。短时间内获得大量用户的激励广告等会因为集中访问服务器，通讯回复较差而导致APP启动时间延长或强制关闭等情况，从而导致无法正确计测广告结果。

按照以下步骤可以进行以上情况的测试，请进行以下设置，确认APP是否正常启动。

`iOS「设置」→「开发者」→「NETWORK LINK CONDITIONER」`

* 「Enable」设置为on
* 勾选「Very Bad Network」

## 注意事项

### 像appId等这样按不同APP分配的参数，请务必使用指定的值

如果输入了不同的值，在粘贴的时候混入空格或改行这样的字符，可能会发生无法正常计测的现象。

### 如果UIWebView里设定了独自的UserAgent、请使用enabledCustomizedUserAgent

Fingerprinting计测手法使用UIWebView，如果独自定制化了UserAgent的话，请务必使用`enabledCustomizedUserAgent`，否则将无法正常计测。

### trackingCompletionHandler在主线程(Main Thread)里被执行

在`trackingCompletionHandler`里面，进行花时间的重度处理的话可能会发生延迟描画显示的问题。

### Deferred deeplink callback默认在后台线程(Background Thread)里被执行

如果希望进行UI线程相关的操作，请使用Grand Central Dispatch(GCD)类库。

### APP的全新发布，还有APP更新发布的时候，请一定进行疏通测试，请确认是否能够正常地取得计测结果

到申请到应用商城为止，请在导入了SDK状态下做充分的测试，确保APP的动作没有任何问题。

---
[Top](../../README.md)
