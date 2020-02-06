# F.O.X SDK の削除確認方法
<div id="delete_unity"></div>

# iOS

## ライブラリの削除

導入方法に応じてSDKを削除してください。

[F.O.X iOS SDK 4.X](https://github.com/forceoperationx/public-fox-ios-sdk/blob/4.x-master/lang/ja/README.md#install_sdk)

[F.O.X iOS SDK 3.X](https://github.com/forceoperationx/public-fox-ios-sdk/blob/3.x-master/lang/ja/README.md#install_sdk)

## CocoaPods/Carthage

CocoaPods/Carthageの設定ファイルからF.O.Xの設定を削除してください。

## ライブラリの削除

以下のファイルがある場合は削除してください。

- `CYZFox.framework`
- `libFoxSdk.a` 
- `AdManager.h`
- `Ltv.h`
- `AnalyticsManager.h`

F.O.Xにて追加したフレームワークで他で利用していないものを削除してください

[フレームワーク設定 4.X](https://github.com/forceoperationx/public-fox-ios-sdk/blob/4.x-master/lang/ja/README.md#setting_sdk)

[フレームワーク設定 3.X](https://github.com/forceoperationx/public-fox-ios-sdk/blob/3.x-master/lang/ja/README.md#setting_sdk)

## コード/その他ファイル全体

F.O.Xでの計測のために追加したコードを削除してください。

また、コード/ファイル全体を対象に、以下の単語を検索し、含まれてる場合は適宜削除してください。
大文字小文字の区別なしで検索してください。

- `FOX`
- `F.O.X`
- `forceoperationx`
- `app-adforce`
- `appadforce`
- `cyberz`
- `cyber-z`
- `cyz`

