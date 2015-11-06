## （옵션）관리 화면상에 등록한 번들 버전에 따른 처리의 배분

F.O.X의 관리 화면에 등록되어 있는 버전과 실행 중의 앱의 버전에 따라서 처리를 나누는 것이 가능합니다.
본 기능을 이용하는 것으로, 예를 들어 릴리스 중과 테스트 중의 버전의 처리를 F.O.X를 이용하여 제어하고, 테스트 중일때만 특정의 처리를 실행하는 것 등이 가능해집니다.
본 기능의 구현은 필수는 아닙니다.
한편, F.O.X에서 이용하는 번들 버전은, CFBundleShortVersionStr에 해당하는 값입니다.

번들 버전에 따른 처리의 배분을 하려면 `checkVersionWithDelegate`: 메소드를 이용합니다. 매개변수의 delegate는 CheckVersionDelegate 프로토콜 및 didLoadVersion: 메소드를 구현합니다.
버전 체크 문의를 F.O.X 서버에서 행하고 결과를 수신하면 didLoadVersion:이 호출됩니다.
didLoadVersion: 전화 후`getBundleVersionStatus :`메소드를 이용하여 관리 화면에 등록한 번들 버전이 실행중인 응용 프로그램의 버전과 일치하는지 여부를 판정 할 수 있습니다. 일치 한 경우에는 YES 일치하지 않은 경우에는 NO를 반환합니다.

이하, 본 기능의 구현 예입니다. Delegate 메소드를 호출하여 원하는 모든 클래스의 헤더 파일에서 CheckVersionDelegate 프로토콜의 구현을 선언합니다.

```objective-c
#import "AdManager.h"
// 모든 클래스에서 <CheckVersionDelegate>를 추가@interface MyViewController : UIViewController<CheckVersionDelegate>
@end
```

`checkVersionWithDelegate :`메소드를 호출하고 서버에 문의를 합니다. ViewController 클래스를 위임하는 경우에는 viewDidLoad 등에 구현합니다.

```objective-c
- (void)viewDidLoad {	[super viewDidLoad];	// 관리 화면에서 등록한 번들 버전과 일치하는지 여부를 문의합니다.	[[AppAdForceManager shareManager] checkVersionWithDelegate:self];}
```

대리자 메소드 인 didLoadVersion:를 구현합니다.

```objective-c
- (void)didLoadVersion:(id)sender {	// 관리 화면에서 등록한 번들 버전과 일치하는지 여부를 반환합니다.	BOOL matches = [[AppAdForceManager sharedManager] getBundleVersionStatus];	// 일치하지 않는 경우 (예를 들어 테스트중인 버전) 처리 기술	if(!matches) {		....	}}
```

>본 메소드에 의한 F.O.X 서버에 대한 문의는, 부하경감을위해 1 클라이언트에서 각 버전마다 5 회까지로 제한됩니다. 5 회를 초과하면 서버에 문의하지 않고 didLoadVersion:이 호출되지 않습니다. 번들 버전을 업데이트하여 다시 5 회를 상한으로 서버에 문의를 하게 됩니다.

---
[TOP으로](/lang/ko/README.md)
