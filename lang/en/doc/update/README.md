## Updating to latest version of F.O.X SDK

In case of updating latest F.O.X SDK, process is below

1. Remove old version if included below files on project
1. Add latest version files on project1. Execute 「Product」→「Clean」on Xcode

As from v2.12, only libAppAdForce.a is provided as a library file. LTV, analytics and push notification are included in libAppAdForce.a
As from v2.12, only libAppAdForce.a is provided as a library file. LTV, analytics and push notification are included in libAppAdForce.a . Please delete all the following files when updating F.O.X SDK.

* libLtv.a
* libAnalytics.a
* libNotify.a

For check SDK version, `setDebugMode:` method can be called.

```objective-c
[[AppAdForceManager sharedManager] setDebugMode:YES];
```
Make sure whether latest version and implemented version correspond or not
```
[5160:c07] ===== FORCE OPERATION X DEBUG DESCRIPTION =====
[5160:c07] Force Operation X SDK v2.13.4g
```
Delete `setDebugMode:` method from application as release it.
Don’t forget testing tracking when update SDK. After updating the SDK, be sure to conduct the test and check that there is no problem with the tracking and application operation.

---
[TOP](/lang/en/README.md)
