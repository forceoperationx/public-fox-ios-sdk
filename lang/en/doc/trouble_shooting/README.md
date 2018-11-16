[TOP](../../README.md)　>　FAQ・Notes

The following is a compilation of common issues, questions, and important information to note.

## FAQ

### What iOS versions does F.O.X support？

iOS 8 and above.

### What bundle version should I use with F.O.X？

On iOS, there are two markers that represent a bundle version.

* CFBundleVersion
* CFBundleShortVersionString

F.O.X uses the above written CFBundleShortVersionString value for administrative purposes.

### The number of installs reported from advertisement clicks is lower than expected.

If the methods `trackInstall:` or `trackInstallWithOption` are not implemented immediately after launch, then any user who exits the app without reaching the point where you've implemented the methods then there will be a discrepancy in your install tracking numbers.

The `trackInstall:` or `trackInstallWithOption:` method should be implemented in the `didFinishLaunchingWithOptions` method called when the application is launched unless there is a particular reason. If it is included in any other place, the install tracking results may not be accurate.

<br> Be sure to notify your advertising agency or media company if you have not implemented the `trackInstall` method in the `didFinishLaunchingWithOptions` method invoked at app launch. Otherwise there is a risk of being charged more for advertising expenses due to the possibility of falsely increased install numbers.

### We released our app without specifying a URL scheme, and now we can't return from the browser to our app.

When performing Cookie tracking the URL scheme is used to transition from the browser to your app. As such, it is necessary to have a custom URL scheme specified. If you do not specify a URL scheme then your app will not be able perform such a screen transition.

### Our URL scheme contains uppercase letters, preventing the browser from transitioning to our app.

Depending on your production environment, there are cases where capitalized URL schemes are not recognized. In order to avoid this, please set your URL scheme in lower case alphanumeric characters.

### The URL Scheme we specified conflicts with another company's app, and now the browser transitions to their app

With regards to iOS apps, when multiple apps have the same URL Scheme, it is not certain which app will be launched. In order to avoid this situation, please set a URL Scheme that is unique and will not clash with other apps.

### We recently pushed a promotion that gathered a large amount of users in a very short period, which resulted in a discrepancy in our install tracking numbers.

On iOS there is a specification in place that forcibly terminates the application if the main thread is blocked for more than a certain time at application startup. Be careful not to perform initialization or synchronous communication to the server on the main thread at startup.

In cases such as the release of a reward campaign, many users attempt to install the app at the same time. This may put a strain on your servers, slowing the communication between the server and a user's device, and can result in forced termination of the app at startup. When this happens, it is possible that a discrepancy can occur in your Ad effectiveness tracking numbers.

This situation can be tested using the following procedure, so please confirm with the settings below whether the application starts normally. <br>
`iOS「Settings」→「Developer」→「NETWORK LINK CONDITIONER」`

* Turn on「Enable」
* Check「Very Bad Network」

## NOTES

### Make sure you set each parameter you are issued to the relevant location in your app (e.g. AppID,AppKEY,etc.)

There have been cases where tracking information was incomplete/incorrect when these parameters included a space or carriage return or were incorrectly specified.

### If you have set your own UserAgent for UIWebView, please use enabledCustomizedUserAgent

If you are using Fingerprinting tracking and using a UIWebView with a custom UserAgent, then if you do not use `enabledCustomizedUserAgent` then there is a possibility that your tracking data will be collected incorrectly.

### trackingCompletionHandler is running in the main thread

If there is any slow-running/heavy code being run inside the `trackingCompletionHandler` there is a possibility that screen rendering will be slow.

### The deferred deeplink callback is executed in the background thread by default

If you want to use UI threads, please use the Grand Central Dispatch (GCD) library.

### Whenever your app has a new release or update, make sure you perform all connection tests on our management portal to ensure tracking is functioning properly.

Be sure to test thoroughly with our SDK implemented into your app and make sure there are no operational issues before releasing your app to the marketplace.

---
[Return to Top](../../README.md)
