## (Optional) Implement opt out

Users are enabled to select not being used for targeting Ads by advertising company. If a user selects opt out on dialog showing privacy policy or terms of service at activation, F.O.X notice the company that the user has selected opt out with result of measurement.

If you want to enable opt out, call `setOptout:` before `sendConversion:` as follows.

```objective-c
if(user.optout) {	[[AppAdForceManager sharedManager] setOptout:YES];}

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
```
---
[TOP](/lang/en/README.md)
