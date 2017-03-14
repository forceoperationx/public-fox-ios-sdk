[TOP](../../README.md)　>　执行Optout

---

## （任意）Optout的执行
广告公司可以让用户选择是否使用用户定向投放广告。用户在APP启动时弹出的隐私权政策和使用条例对话框中选择Optout的情况时，告知效果测定结果的同时，F.O.X也会通知广告公司用户选择了Optout。
适用Optout的场合，请通过以下「[执行Install计测](../track_install/README.md#track_install_optional)」，将执行时[`CYZFoxTrackOption`](../sdk_api/README.md#CYZFoxoption)中设置`OptOut为true`。

![Language](http://img.shields.io/badge/language-Objective–C-blue.svg?style=flat)
```objc
// 首次启动的安装计测
CYZFoxTrackOption* option = [CYZFoxTrackOption new];
option.optout = YES;
[CYZFox trackInstall:option];
```

![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)
```Swift
// 首次启动的安装计测
let option: CYZFoxTrackOption = CYZFoxTrackOption()
option.optout = true
CYZFox.trackInstallWithOption(option)
```

---
[Top](../../README.md)
