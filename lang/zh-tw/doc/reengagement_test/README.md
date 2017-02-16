## Reengagement計測時的疏通測試

在上架申請以前，請在導入SDK後的狀態做充分的測試，以確保APP的動作沒有問題。

因為在啟動後只發生一次Install計測的通信，如果想要再次進行Install計測的話，請卸載APP再次安裝

**測試步驟**

1. 如果測試用的設備已安裝APP，請先卸載掉APP<br />
1. 清除測試移动终端默认浏览器Safari的Cookie，請按「設定」→「Safari」→「Cookie和數據消除」刪除Cookie<br />
1. 複製鄙司發行的【安装用测试URL】，粘貼到默認瀏覽器（標準瀏覽器）的URL欄裡進行訪問。<br />
＊請在管理畫面（SDK導入→平台的選擇→SDK導入文檔→测试URL→安装用测试URL）裡取得【安装用测试URL】。<br />
＊請一定在OS設定的默認瀏覽器裡粘貼測試URL來發出請求。郵件APP或QR碼讀取APP等這些APP內部會用WebView發生的畫面跳轉是無法計測的。<br />
1. 畫面移轉到Market<br />
＊使用測試URL，可能會因為沒有設定跳轉目的地（沒有在APP詳細裡設定「商城URL」）而彈出錯誤對話框，這個不影響測試。<br />
1. 在測試終端上安裝測試APP<br />
1. 啟動APP（F.O.X設定和不同測試終端會影響APP啟動後的舉動，請參考下面的說明）<br />
＊如果沒有勾選cookie計測手法，Safari瀏覽器將不會彈跳出來。<br />
＊如果勾選了cookie計測手法，並且使用iOS9以下的測試終端，瀏覽器將自動彈跳出來<br />
＊如果勾選了cookie計測手法，並且使用iOS9及以上的測試終端，會啟動SFSafariViewController。但是如果設定了`setStartPageVisible:NO`的話，SFSafariViewController和Safari都不會啟動。<br />
＊如果沒有出現上述的舉動，說明沒有正常設定。請重新設定，若仍無法發現問題，請與弊司聯繫。<br />
1. 把畫面移轉到LTV計測地點<br />
＊如果登錄了LTV地點執行此步驟<br />
1. 結束並從後台關閉APP<br />
1. 刪除默認浏览器的Cookie、點擊【Reengage用测试URL】。請確認APP是否啟動。<br />
＊請在管理畫面（SDK導入→平台的選擇→SDK導入文檔→测试URL→安装用测试URL）裡取得【Reengage用测试URL】。<br />
＊如果APP沒有啟動，請確認是否設定了定製的URL Scheme。請重新設定，若仍無法發現問題，請與弊司聯繫。<br />
1. 把畫面移轉到LTV地點（至少1個）<br />
1. 不顯示APP、讓其運行在後台。<br />
1. 再次刪除默認瀏覽器的Cookie、點擊【Reengage用测试URL】。請確認APP是否啟動。<br />
＊如果APP沒有啟動，請確認是否設定了定製的URL Scheme。請重新設定，若仍無法發現問題，請與弊司聯繫。<br />
1. 把畫面移轉到LTV地點（至少1個）<br />
1. 結束並從後台關閉APP<br />
1. 再次啟動APP<br />

請告訴鄙司3，6，7，9，10，12，13的時間。在鄙司這邊會確認是否正常被計測。確認沒有問題的話，測試算正式完成。


> 請注意在步驟3使用的測試URL和步驟9、12使用的Reengagement計測測試用URL是不一樣的。

---
[TOP](/lang/zh-tw/README.md)
