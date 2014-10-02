## SDK設定の詳細

SDKの動作に必要な設定をplistに追加します。「AppAdForce.plist」という名称のプロパティリストファイルをプロジェクトの任意の場所に作成し、次のキーと値を入力してください。

任意の場所で右クリック→「New File...」を選択

![SDK設定01](https://github.com/cyber-z/public_fox_ios_sdk/raw/master/doc/config_plist/ja/img01.png)

「Property List」を選択。

![SDK設定02](https://github.com/cyber-z/public_fox_ios_sdk/raw/master/doc/config_plist/ja/img02.png)

「AppAdForce.plist」という名称に変更し、Createボタンをクリック。

![SDK設定03](https://github.com/cyber-z/public_fox_ios_sdk/raw/master/doc/config_plist/ja/img03.png)

作成したプロパティリストファイルを選択。右クリックでメニューを開き、「Add Row」を選択

![SDK設定04](https://github.com/cyber-z/public_fox_ios_sdk/raw/master/doc/config_plist/ja/img04.png)

各キーとバリューを設定。

![SDK設定05](https://github.com/cyber-z/public_fox_ios_sdk/raw/master/doc/config_plist/ja/img05.png)

設定するキーとバリューは以下の通りです。

<table>
<tr>
  <th>Key</th>
  <th>Type</th>
  <th>Value</th>
</tr>
<tr>
  <td>APP_ID</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>SERVER_URL</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>APP_SALT</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>APP_OPTIONS</td>
  <td>String</td>
  <td>何も入力せず、空文字の状態にしてください。</td>
</tr>
<tr>
  <td>CONVERSION_MODE</td>
  <td>String</td>
  <td>1</td>
</tr>
<tr>
  <td>ANALYTICS_APP_KEY</td>
  <td>String</td>
  <td>Force Operation X管理者より連絡しますので、その値を入力してください。<br />アクセス解析を利用しない場合は設定の必要はありません。</td>
</tr>
</table>

[TOP](https://github.com/cyber-z/public_fox_ios_sdk)

