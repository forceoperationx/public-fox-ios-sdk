## Reengagement計測時的疏通測試

在上架申請以前，請在導入SDK後的狀態做充分的測試，以確保APP的動作沒有問題。

因為在啟動後只發生一次Install計測的通信，如果想要再次進行Install計測的話，請卸載APP再次安裝

**測試步驟**

1. 如果測試用的設備已安裝APP，請先卸載掉APP
1. 透過測試用端末的「設定」→「Safari」→「Cookie和數據消除」刪除Cookie
1. 複製鄙司發行的測試用URL，粘貼到Safari的URL欄裡進行訪問<br />
＊測試用的URL請務必在標準的Safari裡使用。由於Chrome這樣的第三方瀏覽器，郵件APP，QR碼讀取APP等這些APP內部會用WebView發生跳轉，因此無法進行計測。
1. 畫面移轉到Market
＊使用測試URL，可能會因為沒有設定跳轉目的地而彈出錯誤對話框，這個不影響測試。
1. 在測試終端上安裝測試APP<br />
1. 啟動APP，瀏覽器啟動<br />
若流覽器無法啟動，說明沒有正常設定。請重新設定，若仍無法發現問題，請與弊司聯繫。
1. 把畫面移轉到LTV地點<br />
1. 結束並從後台關閉APP<br />
1. 刪除Safari的Cookie、點擊Reengagement計測測試用URL。請確認APP是否啟動。
1. 到達LTV地点
1. 不顯示APP、讓其運行在後台。
1. 刪除Safari的Cookie、點擊Reengagement計測測試用URL。請確認APP是否啟動。
1. 畫面移轉到LTV地點
1. 再次啟動APP

請告訴鄙司3，6，7，9，10，12，13的時間。在鄙司這邊會確認是否正常被計測。確認沒有問題的話，測試算正式完成。


> 請注意在步驟3使用的測試URL和步驟9、12使用的Reengagement計測測試用URL是不一樣的。

---
[TOP](/lang/zh-tw/README.md)
