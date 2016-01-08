# 有關利用Tag的LTV計測

在WEB頁面上進行會員登錄或商品購入的場合，可以利用img Tag進行LTV計測。

F.O.X的LTV計測適用於外部瀏覽器和APP內WebView。外部瀏覽器利用ltvOpenBrowser:而APP内WebView利用setLtvCookie來把LTV計測需要的信息記錄到瀏覽器的Cookie裡。

## 使用外部瀏覽器的LTV計測

從APP啟動外部瀏覽器，使用外部瀏覽器表示WEB頁面進行Tag計測的場合，請利用ltvOpenBrowser:方法來啟動外部瀏覽器。用字符串形式設定外部瀏覽器使用的URL給參數。

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv ltvOpenBrowser:@"http://yourhost.com/"];
```

## 使用APP內WebView的LTV計測

畫面遷移在APP內WebView裡進行的場合，可以利用setLtvCookie。請在生成WebView的地方安裝下面的代碼。多次生成和廢棄WebView的場合，請在生成之際執行setLtvCookie。在內部利用NSHTTPCookieStorage來設定Cookie。

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv setLtvCookie];
```

## Tag的安裝

請在LTV成果地點頁面裡安裝F.O.X管理員提供的計測Tag。

Tag的參數式樣如下。

<table>
<tr>
  <th>參數名</th>
  <th>必須?</th>
  <th>備考</th>
</tr>
<tr>
  <td>_buyer</td>
  <td>必須</td>
  <td>識別廣告主的ID。<br />請輸入管理員提供的值。</td>
</tr>
<tr>
  <td>_cvpoint</td>
  <td>必須</td>
  <td>識別成果地點的ID。<br />請輸入管理員提供的值。</td>
</tr>
<tr>
  <td>_price</td>
  <td>任意</td>
  <td>消費額。消費計測時請設定。<br /></td>
</tr>
<tr>
  <td>_currency</td>
  <td>任意</td>
  <td>半角字母數字3位長度的貨幣代碼。<br />消費計測時請設定。<br />未設定的場合、\會默認把_price設定為JPY(日圓)。</td>
</tr>
<tr>
  <td>_buid</td>
  <td>任意</td>
  <td>半角字母數字最大64位長度。<br />像會員ID這樣為每個用戶保持唯一值的時候請使用。</td>
</tr>
</table>

\在_currency裡請指定用[ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217)定義的貨幣代碼。

---
[TOP](/lang/tw/README.md)
