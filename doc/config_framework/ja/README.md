## フレームワーク設定の詳細

ビルド対象のターゲットをクリックし、「Build Phases」→「Link Binary With Libraries」を選択。「+」ボタンを押し、各フレームワークを選択してください。

![フレームワーク設定01](https://github.com/cyber-z/public_fox_ios_sdk/raw/master/doc/config_framework/ja/img01.png)

次のフレームワークをプロジェクトにリンクしてください。

<table>
<tr><th>フレームワーク名</th><th>Status</th></tr>
<tr><td>SafariServices.framework</td><td>Optional</td></tr>
<tr><td>AdSupport.framework</td><td>Optional</td></tr>
<tr><td>iAd.framework </td><td>Required</td></tr>
<tr><td>Security.framework </td><td>Required </td></tr>
<tr><td>StoreKit.framework </td><td>Required </td></tr>
</table>

> ※ AdSupport.frameworkはiOS 6以降で追加されたフレームワークのため、アプリケーションをiOS 5以前でも動作させる(iOS Deployment Targetを5.1以下に設定する)場合にはweak linkを行うために”Optional”に設定してください。

> ※ SafariServices.frameworkはiOS 9以降で追加されたフレームワークのため、アプリケーションをiOS 8以前でも動作させる(iOS Deployment Targetを8.4以下に設定する)場合にはweak linkを行うために”Optional”に設定してください。

![フレームワーク設定02](https://github.com/cyber-z/public_fox_ios_sdk/raw/master/doc/config_framework/ja/img02.png)

[TOP](https://github.com/cyber-z/public_fox_ios_sdk#2-%E8%A8%AD%E5%AE%9A)

