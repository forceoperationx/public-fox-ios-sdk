## (任意)Opt-Out的安裝

有些廣告公司會允許用戶選擇不接受瞄準投放的廣告。在APP啟動時，用戶若在顯示隱私條例和使用規範的視窗中選擇不參加的選項，接收到效果測量通知的同時，F.O.X會把此用戶選擇不參加的資訊，發送給廣告公司。

若要對應Opt-Out，請在如同以下「3. 啟動計測安裝」導入sendConversionWithStartPage之前設定。

```objective-c
if(user.optout) {	[[AppAdForceManager sharedManager] setOptout:YES];}

[[AppAdForceManager sharedManager] sendConversionWithStartPage:@"default"];
```
---
[TOP](/lang/tw/README.md)
