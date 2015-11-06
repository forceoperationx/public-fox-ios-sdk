# 태그를 이용한 LTV 계측에 대해서

웹페이지로 회원등록이나 상품구입할 경우에, img태그를 이용해서 LTV계측이 가능합니다.

F.O.X의 LTV 계측은, 외부 브라우저, 앱 내 WebView의 양쪽 다 대응하고 있습니다. 외부 브라우저의 경우에는 ltvOpenBrowser, 앱 내 WebView의 경우에는 setLtvCookie메소드를 이용하는 것으로,
 F.O.X가 LTV 계측에 필요한 정보를 브라우저의 Cookie에 기록합니다.

## 외부 브라우저에서이 LTV 계측
앱에서 외부 브라우저를 기동하고, 외부 브라우저에 표시된 웹 페이지에서 태그 계측을 할 경우는, ltvOpenBrowser 메소드를 이용해서 외부 브라우저를 기동해 주세요. 매개변수에는, 외부 브라우저로 표시하는 URL을 문자열을 지정합니다.

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv ltvOpenBrowser:@"http://yourhost.com/"];
```

## 앱 내 WebView에서의 LTV계측
유저의 이동이 WebView 내에서 이루어지는 경우에는, setLtvCookie를 이용할 수 있습니다. WebView가 생성되는 장소에 아래 코드를 넣어 주십시오.
 WebView가 여러번 생성/파기되는 경우에는, 생성될 때마다 setLtvCookie가 실행되도록 해 주세요. 내부적으로 NSHTTPCookieStorage를 이용해서 Cookie를 설정 합니다.

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv setLtvCookie];
```

## 태그의 구현

LTV의 성과지점이 되는 페이지에 계측 태그를 구현해 주세요. 계측 태그는 Force Operation X 관리자가 연락합니다.

태그에 이용하는 파라미터 사양은 하기와 같습니다.

<table>
<tr>
  <th>파라미터 명</th>
  <th>필수</th>
  <th>비고</th>
</tr>
<tr>
  <td>_buyer</td>
  <td>필수</td>
  <td>광고주를 식별하는 ID.<br />관리자로부터 연락받은 값을 넣어 주십시오.</td>
</tr>
<tr>
  <td>_cvpoint</td>
  <td>필수</td>
  <td>성과 지점을 식별하는 ID。<br />관리자로부터 연락받은 값을 넣어 주십시오.</td>
</tr>
<tr>
  <td>_price</td>
  <td>옵션</td>
  <td>과금액. 과금 계측 시에 설정해 주십시오.<br /></td>
</tr>
<tr>
  <td>_currency</td>
  <td>옵션</td>
  <td>통화 코드(3자).<br />과금 계측 시에 설정해 주십시오.<br />통화가 설정되지 않은 경우、\_price는JPY(엔)으로 됩니다.</td>
</tr>
<tr>
  <td>_buid</td>
  <td>옵션</td>
  <td>영문, 숫자 조합(64자 까지)<br />회원 ID등 유저 별 유니크한 값을 보존할 경우 사용해 주십시오.</td>
</tr>
</table>

\_currency에는[ISO 4217](https://ko.wikipedia.org/wiki/ISO_4217)에 정의된 통화 코드를 지정해 주십시오.

---
[TOP으로](/lang/ko/README.md)
