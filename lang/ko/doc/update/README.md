## 최신 버전으로 업데이트에 대하여

이전 버전의 F.O.X SDK가 설치된 앱에 대한 최신 버전의 F.O.X SDK를 설치하는데 필요한 단계를 설명합니다.
1. 이전 버전의 라이브러리 파일 및 헤더 파일을 프로젝트에서 삭제
2. 최신 버전의 파일을 프로젝트에 추가3. Xcode의「Product」→「Clean」을 실행

F.O.X iOS SDK V2.12이후의 버전에서는, 라이브러리 파일을 libAppAdForce.a만 제공합니다. V2.11 이전 버전에서 개별로 존재하던 라이브러리는 모두 libAppAdForce.a로 통합되었습니다. 업데이트할 때 이하의 파일이 존재한다면 모두 삭제해 주십시오.
* libLtv.a
* libAnalytics.a
* libNotify.a

최신판인지 확인하는 방법으로는 setDebugMode메소드를 호출하여 확인할 수 있습니다.

```objective-c
[[AppAdForceManager sharedManager] setDebugMode:YES];
```
위의 메소드를 호출하면 아래와 같은 값이 출력되니 최신 버전과 일치하는지 확인해 주십시오.

```
[5160:c07] ===== FORCE OPERATION X DEBUG DESCRIPTION =====
[5160:c07] Force Operation X SDK v2.13.4g
```
setDebugMode메소드는, 릴리즈시에는 삭제해 주세요.
SDK의 업데이트 후, 반드시 소통 테스트를 실시하고, 계측 및 앱의 동작에 문제 없는 것을 확인해 주세요.

## v2.13.4g 버전에서 업데이트 된 점

F.O.X 에서는 앱의 버전마다 동작의 제어를 위해, 번들 버전의 값을 이용하고 있습니다. V2.13.5g 버전에서는, 동작 제어에 이용하는 번들 버전의 값을 CFBundleVersion으로부터 CFBundleShortVersionString로 변경했습니다.. 번들 버전을 이용하여 동작 제어를 하고 있을 경우에는 유의해 주세요.

## v2.12.1 버전에서 업데이트 된 점

v2.13g 버전에서는、재반응(re-engagement)유도 계측 기능이 추가되었습니다. URL 스키마 경유의 앱 기동을 계측하기 위해, 「[3. 인스톨 계측의 구현](/lang/ko/doc/send_conversion/README.md)」의 절차에 따라, `setUrlSchemeWithOptions: 및 setUrlSchem:`를 추가 구현해주십시요.


## v2.11.1 버전에서 업데이트 된 점

v2.11.1 이전 버전의 SDK에서 업데이트 할 경우 iAd.framework를 추가할 필요가 있습니다.

## v2.8.1 버전에서 업데이트 된 점
v2.8.1 이전 버전의 SDK에서 업데이트할 경우 AdSupport.framework를 추가할 필요가 있습니다.

---
[TOP으로](/lang/ko/README.md)
