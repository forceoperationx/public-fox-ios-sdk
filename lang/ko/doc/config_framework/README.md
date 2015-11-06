## 프레임 워크 설정의 상세

빌드 대상 대상을 클릭하고 「Build Phases」 → 「Link Binary With Libraries」 를 선택합니다. 「+」 버튼을 눌러 각 프레임 워크를 선택하십시오.

![FrameworkSetting01](./img01.png)

다음 프레임 워크를 프로젝트에 추가해 주십시오.

<table>
<tr><th>프레임워크명</th><th>Status</th></tr>
<tr><td>SafariServices.framework</td><td>Optional</td></tr>
<tr><td>AdSupport.framework</td><td>Optional</td></tr>
<tr><td>iAd.framework </td><td>Required</td></tr>
<tr><td>Security.framework </td><td>Required </td></tr>
<tr><td>StoreKit.framework </td><td>Required </td></tr>
</table>

> ※ AdSupport.framework은 iOS 6 이상에서 추가 된 프레임 워크를위한 응용 프로그램을 iOS 5 이하에서도 작동시킬 (iOS Deployment Target을 5.1 이하로 설정하는) 경우에는 weak link를 위해 "Optional"으로 설정하십시오.

> ※ SafariServices.framework는 iOS 9 이상에서 추가 된 프레임 워크를위한 응용 프로그램을 iOS 8 이전에도 작동시킬 (iOS Deployment Target을 8.4 이하로 설정하는) 경우에는 weak link를 위해 "Optional"에 설정하십시오.

![FrameworkSetting02](./img02.png)

---
[TOP으로](/lang/ko/README.md)
