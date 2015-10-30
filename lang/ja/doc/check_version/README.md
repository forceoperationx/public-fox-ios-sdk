## （オプション）管理画面上に登録したバンドルバージョンに応じた処理の振り分け

F.O.X の管理画面上に登録しているバージョンと実行中のアプリのバージョンとが一致するかどうかに応じて処理を振り分けることができます。本機能を利用することで、例えばリリース中とテスト中のバージョンの処理の振り分けをF.O.Xを利用して制御し、テスト中のみ特定の処理を実行するなどが可能となります。
本機能の実装は必須ではありません。

なお、F.O.X で利用するバンドルバージョンとは、CFBundleShortVersionString に相当する値です。

バンドルバージョンに応じた処理の振り分けを`行うには、checkVersionWithD`elegate:メソッドを利用します。引数の delegate には、CheckVersionDelegateプロトコル及び didLoadVersion:メソッドを実装してください。バージョンチェックの問い合わせを F.O.X サーバーに対して行い、結果を受信すると didLoadVersion:がコールされます。didLoadVersion:のコール後は、`getBundleVersionStatus:`メソッドを利用し、管理画面上に登録したバンドルバージョ ンが実行中のアプリのバージョンと一致するかどうかを判定することができます。一致した場合にはYES、一致しなかった場合にはNOを返します。

以下、本機能の実装例です。デリゲートメソッドをコールしたい任意のクラスのヘッダファイルで CheckVersionDelegate プロトコルの実装を宣言します。

```objective-c
#import "AdManager.h"
// 任意のクラスで<CheckVersionDelegate>を追加@interface MyViewController : UIViewController<CheckVersionDelegate>
@end
```

`checkVersionWithDelegate:`メソッドをコールし、サーバーに問い合わせを行います。ViewControllerクラスをデリゲートとする場合には、viewDidLoadなどに実装します。

```objective-c
- (void)viewDidLoad {	[super viewDidLoad];	// 管理画面上で登録したバンドルバージョンと一致するかどうかを問い合わせます。	[[AppAdForceManager shareManager] checkVersionWithDelegate:self];}
```

デリゲートメソッドである didLoadVersion:を実装します。

```objective-c
- (void)didLoadVersion:(id)sender {	// 管理画面上で登録したバンドルバージョンと一致するかどうかを返します。	BOOL matches = [[AppAdForceManager sharedManager] getBundleVersionStatus];	// 一致しなかった場合(例えばテスト中のバージョン)の処理の記述。	if(!matches) {		....	}}
```

>本メソッドによる F.O.X サーバーへの問い合わせは、負荷軽減のため1クライアントにおいて各 バージョンごとに5回までに制限されます。5 回を超えるとサーバーへの問い合わせは行われず、 didLoadVersion:がコールされません。バンドルバージョンを更新することで再度 5 回を上限 にサーバーへ問い合わせが行われます。

---
[TOPへ](/lang/ja/README.md)
