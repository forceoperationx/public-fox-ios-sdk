## sendConversionWithStartPage:의 상세

`sendConversionWithStartPage:`메소드를 이용하는 것으로, 인스톨 계측이 가능해집니다. Cookie 계측을 이용할 경우에는, 외부 브라우저가 기동 됩니다. 그때, 외부 브라우저가 이동할 URL은 `sendConversionWithStartPage:`의 매개변수에 URL의 문자열을 지정하는 것이 가능합니다.

프로젝트에서 Application Delegate의`application:didFinishLaunchingWithOptions:`를 아래와 같이 구현해주세요.

> 【주의】
sendConversionWithStartPage:는、특별한 이유가 없을 경우에는 `application:didFinishLaunchingWithOptions:`안에 구현해주세요. 다른곳에 구현한 경우에는 인스톨 수가 정확하게 계측되지 않는 경우가 있습니다.
`application:didFinishLaunchingWithOptions:`에 구현하지 않은 상태에서 인스톨 성과형의 광고를 실시할때에는, 반드시 광고대리점 또는 매체사의 담당자에게 그 뜻을 전해 주십시오. 정확하게 계측이 되지 않는 상태에서 인스톨 성과형의 광고를 실시한 경우에는,
계측된 인스톨 수 이상의 광고비를 지불하게 되는 경우가 있습니다.


```objective-c
#import "AdManager.h"

// - (BOOL)application:(UIApplication *)application
//   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
[[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];

// }
```

sendConversionWithStartPage:의 매개변수에는, 특별히 지정할 URL이 없는 경우에는 @"default"를 넣어주세요.
디폴는 표준으로 준비된 웹페이지가 표시됩니다만, 이동할 URL을 F.O.X의 관리 화면상에서 임의로 지정하는 것도 가능합니다.


![sendConversion01](./img01.png)

특정한 URL로 이동하고 싶은 경우, 앱에서 동적으로 URL을 생성하고 싶은 경우에는, URL의 문자열을 설정해 주십시오.

```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html"];
```

`sendConversionWithStartPage:`의 대신에`sendConversionWithStartPage:buid:`메소드를 이용하고,
성과 로그에 광고주 단말 ID를 부여하는것이 가능합니다. 예를 들어, 앱 기동시에 UUID를 생성하고, 초기 기동의 성과와 관련지어 관리하고
 싶은 경우등에 이용 가능합니다.


```objective-c
[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"http://yourhost.com/yourpage.html" buid:@"{your uniq id}"];
```
> `sendConversionWithStartPage:buid:`는 기동직후의 처리로서 구현될 필요가 있기 때문에, 로그인 ID등의 유저액션이 동반되는 값을 매개변수에 설정하는 것은 불가능합니다.


## Fingerprint 계측 시의 주의 사항
Fingerprint 계측은 WebView를 사용하고 있어, UserAgent를 독자적으로 커스터마이즈를 하고 있는 경우에는 정상적으로 계측할 수가 없습니다.WebView의 UserAgent를 독자적인 문자열로 커스터마이즈 하는 코드가 처리되지 전에 다음의 메소드를 반드시 구현해 주십시오.```objective-c
[[AppAdForceManager sharedManager] cacheDefaultUserAgent];```

## 3.2.	v2.16g 미만의 버전부터 이용해 온 경우
지금까지 재반응(re-engagement)유도 계측을 구현할 때, `didFinishLaunchingWithOptions:`안에 `setUrlSchemeWithOptions:`메소드를
 구현하는 사양이었습니다만, `setUrlScheme:`메소드에 통합되어, 본 문서부터는 구현의 내용을 삭제하였습니다.

[삭제]
```objective-c
  [[AppAdForceManager sharedManager] setUrlSchemeWithOptions:launchOptions];
```
하위 호환을 위해, 삭제하지 않고 지금처럼 호출하는 것도 가능합니다.
---[TOP으로](/lang/ko/README.md)