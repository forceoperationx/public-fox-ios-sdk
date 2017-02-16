## Test procedures to perform re-engage measurement

Until the application to market, test enough in a state where the the SDK has been introduced, and make sure that there is no problem in the operation of the application.

Communication of Installation measurement is performed only once after startup. If you want to do effect measurement test next, uninstall the application, please go from the installation again.

* **Test procedure**

1. Uninstall test app if it has been installed in the testing terminal.
1. Delete the Cookie of the Safari browser of the testing terminal.
1. Click the test URL that issued from our company
1. Redirected to the market
1. Install a test application to the testing terminal<br />
1. Activate the app<br />
Behavior at application startup depends on F.O.X setting and OS version of test terminal.<br />
If cookie tracking is enabled, the Safari browser will be launched on terminals under iOS 9. For iOS 9 or later, SFSafariViewController is launched. However, if `setStartPageVisible: NO` is set, neither SFSafariViewController nor Safari will launch.<br />
If cookie trackin is disabled, the browser will not launch.<br />
If the above behavior does not occur, that means setting has not been carried out correctly. Review the settings, and if you do not see any problem, please contact us.
1. Screen transition to LTV point<br />
1. Quit the app, also removed from the background<br />
1. Delete the browser Cookie, click URL for the re-engagement measurement test. Please ensure that the app is started.<br />
※ If the application does not start, please check whether original URL scheme has been set.<br />
Review the settings, please contact us if you do not see the problem.<br />
1. Screen transition to LTV point<br />
1. Exit the app, leave on the background without removing.
1. Again, delete the browser Cookie again, click URL for the re-engagement measurement test. Please ensure that the app is started.<br />
※ If the application does not start, please check whether original URL scheme has been set.<br />
Review the settings, please contact us if you do not see the problem.
1. Reach the LTV point
1. Exit the app, also removed from the background
1. Activate the app again

Please tell the time of 3,6,7,9,10,12,13 to our company. We will see if measurement has been successfully performed. If there are no problems in our confirmation, the test will be completed.

> Make sure that test URL will be requested on Safari. The measurement will not be performed if you transit by Web View in the app such as mail app or QR code reader.

> When you click on a test URL, there is a case where error dialog is displayed because there is no transit destination, but this is not a problem in the communication test.

---
[TOP](/lang/en/README.md)
