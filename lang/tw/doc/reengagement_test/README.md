## Reengagement計測時的疏通測試

在向Market申請以前，在導入SDK以後請做充分的測試，確認APP的動作沒有問題。

因為在啟動後只發生一次Install計測的通信，如果想要再次進行Install計測的話，請卸載APP再次安裝

**測試步驟**

1. 如果測試用的設備已安裝APP，須解除安裝
1. 透過測試用端末的「設定」→「Safari」→「Cookie和數據消除」刪除Cookie
1. 點擊弊司發行的測試用URL
1. 再移轉到Market
1. 在測試用端末上安裝測試APP<br />
1. 啟動APP，瀏覽器啟動<br />
若流覽器無法啟動，說明沒有正常設定。請重新設定，若仍無發現問題，請與弊司聯繫。
1. 畫面移轉到LTV地點<br />
1. 結束APP，也從Background刪除<br />
1. 刪除Safari的Cookie、點擊Reengagement計測測試用URL。請確認APP是否啟動。
1. 到達LTV地点
1. 不顯示APP、運行在後台不關閉。
1. 刪除Safari的Cookie、點擊Reengagement計測測試用URL。請確認APP是否啟動。
1. 畫面移轉到LTV地點
1. 再次啟動APP

請告訴鄙公司3，6，7，9，10，12，13的時間。在鄙公司這邊會確認是否正常被計測。鄙公司確認沒有問題的話，測試算正式完成。

> 測試用的URL請務必在標準的Safari裡使用。Chrome這樣的第三方瀏覽器，郵件APP，QR碼讀取APP等這些APP內部會用WebView發生跳轉，無法進行計測。

> 點擊測試URL的時候，有時候因沒有跳轉目的地而彈出錯誤對話框，這個不影響疏通測試。

> 請注意在步驟3使用的測試URL和步驟9、12使用的Reengagement計測測試用URL是不一樣的。

---
[TOP](/lang/ja/README.md)
