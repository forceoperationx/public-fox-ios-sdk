## （옵션）OPT-OUT의 구현

광고 회사에 따라서는 타케팅 광고에 이용되지 않는 것을 유저가 선택하는 것이 가능합니다. 앱의 기동시의개인 정보 보호 정책, 이용 규약을 표시하는 다이얼로그에서 유저가 OPT-OUT를 선택한 경우, 효과 계측의 결과의 통지와 함께 F.O.X가 광고회사에게 그 유저가 OPT-OUT를 선택한 것을 통지합니다.OPT-OUT에 대응할 경우에는, 밑과 같이 「3. 인스톨 계측의 구현」에서 구현한 `sendConversionWithStartPage:`보다 전에 구현해 주십시오.

```objective-c
if(user.optout) {	[[AppAdForceManager sharedManager] setOptout:YES];}

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
```
---
[TOP으로](/lang/ko/README.md)
