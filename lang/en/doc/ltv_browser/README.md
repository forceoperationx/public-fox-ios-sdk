# LTV tracking by using tag

LTV tracking can be performed using img tag when member registration, product purchase, etc. are done on a web page.

F.O.X's LTV measurement supports both browsers and in-app WebViews. F.O. X records necessary information for LTV tracking in the browser's cookie.

## LTV tracking by using browser.

By using the `ltvOpenBrowser:` method to start up the browser, tag measurement can be performed. Specify the URL displayed in the external browser as a string for the argument of the `ltvOpenBrowser:`` method.

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv ltvOpenBrowser:@"http://yourhost.com/"];
```

## LTV tracking by using In-app WebView

In case of tag tracking by displaying not browser but WebView in app, add below method to pass Cookie information to WebView. In case of LTV tracking by WebView, Cookie is deleted by closing WebView. Launching browser several times, code has to be located in each part.

```objective-c
#import "Ltv.h"
// ...
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv setLtvCookie];
```

## Put the tracking tag

Please put the tracking tag on the page which is the result point of LTV. The tracking tag will be contacted by the F.O.X operator.

Detail for each parameter in tag is below

<table>
<tr>
  <th>Parameter</th>
  <th>Mandatory</th>
  <th>Note</th>
</tr>
<tr>
  <td>_buyer</td>
  <td>Mandatory</td>
  <td>ID to identify advertiser.<br />Operators give them and set those values.</td>
</tr>
<tr>
  <td>_cvpoint</td>
  <td>Mandatory</td>
  <td>ID to identify cv point.<br />Operators give them and set those values.</td>
</tr>
<tr>
  <td>_price</td>
  <td>Optional</td>
  <td>For managing amount of sales.</td>
</tr>
<tr>
  <td>_currency</td>
  <td>Optional</td>
  <td>Set the currency code In the case of null, "JPY" is specified.</td>
</tr>
<tr>
  <td>_buid</td>
  <td>Optional</td>
  <td>For managing unique ID such as member ID.<br />※Within 64 characters and half-width, alphanumeric characters only.</td>
</tr>
</table>

Specify the currency code defined by [ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217) for \_currency.

---
[TOP](/lang/en/README.md)
