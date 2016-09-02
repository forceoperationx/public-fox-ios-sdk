# タグを利用したLTV計測について

会員登録や商品購入等がWebページで行われる場合に、imgタグを利用してLTV計測を利用することができます。

F.O.XのLTV計測は、外部ブラウザ、アプリ内WebViewの両方に対応しています。外部ブラウザの場合にはltvOpenBrowser:、アプリ内WebViewの場合にはsetLtvCookieメソッドを利用することで、F.O.XがLTV計測に必要な情報をブラウザのCookieに記録します。

## 外部ブラウザでのLTV計測

アプリケーションから外部ブラウザを起動し、外部ブラウザで表示したWebページでタグ計測を行う場合は、ltvOpenBrowser:メソッドを利用して外部ブラウザを起動してください。引数には、外部ブラウザで表示するURLを文字列で指定します。

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv ltvOpenBrowser:@"http://yourhost.com/"];
```

## アプリ内WebViewでのLTV計測

ユーザーの遷移がWebView内で行われる場合には、setLtvCookieを利用することができます。WebViewが生成される箇所で下記コードを実行してください。WebViewが複数回生成・破棄される場合には、生成される度にsetLtvCookieが実行されるようにしてください。内部的にNSHTTPCookieStorageを利用してCookieをセットします。

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv setLtvCookie];
```

## タグの実装

LTVの成果地点となるページに計測タグを実装してください。計測タグはForce Operation X管理者から連絡いたします。

タグに利用するパラメータ仕様は以下の通りです。

<table>
<tr>
  <th>パラメータ名</th>
  <th>必須?</th>
  <th>備考</th>
</tr>
<tr>
  <td>_buyer</td>
  <td>必須</td>
  <td>広告主を識別するID。<br />管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>_cvpoint</td>
  <td>必須</td>
  <td>成果地点を識別するID。<br />管理者より連絡しますので、その値を入力してください。</td>
</tr>
<tr>
  <td>_price</td>
  <td>オプション</td>
  <td>課金額。課金計測時に設定してください。<br /></td>
</tr>
<tr>
  <td>_currency</td>
  <td>オプション</td>
  <td>半角英字3文字の通貨コード。<br />課金計測時に設定してください。<br />通貨が設定されていない場合、\_priceをJPY(日本円)として扱います。</td>
</tr>
<tr>
  <td>_buid</td>
  <td>オプション</td>
  <td>半角英数字64文字まで。<br />会員IDなどユーザー毎にユニークな値を保持する場合にご使用ください。</td>
</tr>
</table>

\_currencyには[ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217)で定義された通貨コードを指定してください。

---
[TOPへ](/lang/ja/README.md)
