## Purchase-event tracking by using access analytics

Using the access analysis function, it is possible to measure respectively events and sales both organic and non-organic install user. To conduct event measurement and billing measurement by access analysis, implement next sendEvent method.

In the case of setting billing as result points in LTV measurement, implement measurement management of each LTV and access analysis at same place.

```objective-c
+ (void)sendEvent:(NSString*)eventName action:(NSString*)action label:(NSString*)label orderID:(NSString*)orderID sku:(NSString*)sku itemName:(NSString*)itemName price:(double)price quantity:(NSUInteger)quantity currency:(NSString*)currency;
```

Specification of the arguments of the sendEvent is as follows.

|Parameter|Type|Maximum length|Outline|
|:------|:------:|:------:|:------|
|eventName|NSString*|255|Set the arbitrary name identifying event conducting tracking. It is able to set event name freely.|
|action|NSString*|255|Set the action name belonging to event. It is able to set action name freely. If not specifying, nil is acceptable.|
|label|NSString*|255|Set the label name belonging to action. It is able to set label name freely. If not specifying, nil is acceptable.|
|orderId|NSString|255|Set the order ID, nil is acceptable.|
|sku|String|255|Set the product code, nil is acceptable.|
|itemName|String|255|Set the product name, nil is acceptable.|
|price|double||Set the unit price|
|quantity|NSUInteger||Set the amount. price * quantity is calculated as total sales.|
|currency|String||Set the currency code. In the case of nil, "JPY" is specified by default.|

> Specify the currency code defined by [ISO 4217](http://ja.wikipedia.org/wiki/ISO_4217) for currency.

As a sample, the example of implementation is noted below and it is an example of 9.99 American dollars.

```objective-c
#import "Ltv.h"

// Billing measurement by LTV measurement
AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
[ltv addParameter:LTV_PARAM_PRICE:@"9.99"];
[ltv addParameter:LTV_PARAM_CURRENCY:@"USD"];
[ltv sendLtv:{LTV POINT ID}];

// billing measurement by access analytics
[ForceAnalyticsManager sendEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:@"Item A" price:9.99 quantity:1 currency:@"USD"];
```

---
[TOP](/lang/en/README.md)
