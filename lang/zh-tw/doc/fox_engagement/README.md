# F.O.X Engagement廣告投放

## 1. 概要
本章對基於Force Operation X SDK(下面略稱F.O.X)的F.O.X Engagement廣告投放以及和Criteo協作時的必要安裝做說明。
在進行F.O.X Engagement廣告投放時，需要在相同地點安裝LTV和流量分析各自的計測處理。

* **對應F.O.X iOS SDK版本** : `v2.16g`及以上

### 1.1.	SDK式樣

透過利用F.O.X SDK流量分析機能，進行橫跨媒體的協作事件計測。計測可以根據不同內容來執行各種方法。

#### 事件資訊的送信

引入頭文件AnalyticsManager.h。
```objective-c
 #import "AnalyticsManager.h"
```

利用下面的sendEvent方法，發送事件資訊。
```objective-c
+ (void)sendEvent:(NSString*)eventName
           action:(NSString*)action
            label:(NSString*)label
          orderID:(NSString*)orderID
              sku:(NSString*)sku
         itemName:(NSString*)itemName
            price:(double)price
         quantity:(NSUInteger)quantity
         currency:(NSString*)currency;
         eventInfo:(NSDictionary*)eventInfo;
```

### sendEvent方法參數

各參數的式樣如下。

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|eventName|String|針對做計測的事件種別來設定指定的Event名稱。|
|<span style="color:grey">action|<span style="color:grey">String|<span style="color:grey">不使用。|
|<span style="color:grey">label	|<span style="color:grey">String|<span style="color:grey">不使用。||orderId|String|(任意)指定訂單號。||sku	|String|(任意)指定商品代號sku。||<span style="color:grey">itemName|<span style="color:grey">String|<span style="color:grey">不使用。||<span style="color:grey">value	|<span style="color:grey">int|<span style="color:grey">不使用。||price|double|	指定銷售額。||quantity|int|	指定數量。<br>按price * quantity來計算銷售額。||currency|String|指定貨幣代碼。null的場合默認指定為"JPY"。||eventInfo|JSONObject|按下面式樣的說明來指定Json。|

### 1.2. eventInfo式樣
在eventInfo裡，通過Json形式設定Action附帶的資訊这种方式，能夠進行動態廣告協作投放。Json式樣如下。

| 參數 | 型 | 概要 |
|:----------|:-----------:|:------------|
|product|Array|閱覽過的放入購物車的商品的設定領域。|
|&nbsp;&nbsp;product[].id|String|指定閱覽過的放入購物車的商品ID。|
|&nbsp;&nbsp;product[].price|double|指定閱覽過的放入購物車的商品單價。|
|&nbsp;&nbsp;product[].quantity|int|指定閱覽過的放入購物車的商品數量。|
|&nbsp;&nbsp;product[].category|String|指定閱覽過的放入購物車的商品種別。<br>若想設定多個請用「,」來區分、分層次請用「>」來分割。<br>例）電影，錄像>DVD>體育，休閑|
|din|String|若想指定開始日請設定。|
|dout|String|若想指定結束日請設定。|
|criteo_partner_id|String|Criteo帳號ID在同一個APP裡不一樣的時候請設定。|
|fox_cvpoint|Long|輸入F.O.X的成果地點ID。|
|datafeed|JSONObject|實時數據字段(參考下方)|

### 1.3. 實時數據字段更新式樣
在eventInfo裡，通過Json形式設定數據字段的更新情報的方式，根据F.O.X Engagement廣告投放協作能夠實時更新數據字段。

#### JSON 佈局詳細

對於更新數據字段狀態的Action，請按下面Json式樣來安裝。

| 參數 |必須|型 | 概要 |
|:----------|:-------:|:----:|:------------|
|version|必須|String|指定數據字段的版本。|
|product|必須|Array|商品主表的數據字段的設定領域。|
|&nbsp;&nbsp;product[].id|必須|String|能夠專門識別數據字段的商品的ID。|
|&nbsp;&nbsp;product[].action|必須|String|輸入對數據字段的操作。<br>U:添加或編輯　D:刪除|
|&nbsp;&nbsp;product[].name|必須|String|商品名。<br>刪除時可以設定為null。|
|&nbsp;&nbsp;product[].expire|任意|String|商品的有效期限。<br>請按照「yyyy-MM-dd HH:mm:ss」或者「yyyy-MM-dd」的格式來輸入日期。|
|&nbsp;&nbsp;product[].effective|任意|String|商品的公開日期和時間。<br>如果此項被設定，到公開日期和時間為止，商品不會被顯示出來。<br>請按照「yyyy-MM-dd HH:mm:ss」或「yyyy-MM-dd」的格式來輸入日期。|
|&nbsp;&nbsp;product[].img|任意|String|商品的圖像URL。|
|&nbsp;&nbsp;product[].category1|任意|String|指定第一層次的種別。|
|&nbsp;&nbsp;product[].category2|任意|String|指定第二層次的種別。|
|&nbsp;&nbsp;product[].category3|任意|String|指定第三層次的種別。|
|&nbsp;&nbsp;product[].price|任意|Double|指定商品價格。|
|&nbsp;&nbsp;product[].currency|任意|String|指定商品的貨幣代碼。<br>null的場合默認指定為"JPY"。|
|&nbsp;&nbsp;product[].(任意)|任意|String|指定其他投放或分析使用的項目。<br>請指定數據字段的項目。|

　　　
## 2.事件計測的安裝
　F.O.X SDK對應的F.O.X Engagement的事件計測和Criteo的事件計測分為以下5種。<br>安裝的詳細請確認下面的詳細頁面。

* [> View Toppage事件](./ViewToppageEvent.md)
* [> View Listing事件](./ViewListingEvent.md)
* [> View Product事件](./ViewProductEvent.md)
* [> View Basket事件](./ViewBasketEvent.md)
* [> Track Transaction事件](./ViewTransactionEvent.md)


---
[TOP](/lang/zh-tw/README.md)
