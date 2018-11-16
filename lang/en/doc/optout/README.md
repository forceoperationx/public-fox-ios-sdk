[TOP](../../README.md)　>　Enabling opt-out feature

---

## (Optional) Enabling opt-out feature

It is possible for users to opt out of targeted advertisements by advertising companies. When the user selects opt-out in the dialog displaying the privacy policy and the usage agreement at the time of starting the application FOX notifies the advertising company that the user has decided to opt out along with advertisement measurement results.

For more information on how to enable opt-out functionality see the

If you want to enable opt-out functionality, set the [`CYZFoxTrackOption`](../sdk_api/README.md#CYZFoxoption)'s `OptOut` property to `true` as explained in ["Install Tracking Details"](../track_install/README.md#track_install_optional)

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
// First time launch install tracking
CYZFoxTrackOption* option = [CYZFoxTrackOption new];
option.optout = YES;
[CYZFox trackInstall:option];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
// First time launch install tracking
let option: CYZFoxTrackOption = CYZFoxTrackOption()
option.optout = true
CYZFox.trackInstallWithOption(option)
```

---
[Return to Top](../../README.md)
