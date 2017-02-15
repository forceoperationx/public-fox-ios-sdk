## SDK configuration

Add necessary setting for SDK operation to plist. Create file named "AppAdForce.plist" on arbitrary place, then input following key and value.

Right click at arbitrary place →Select "New File...".

![SDK configuration01](./img01.png)

Select "Property List".

![SDK configuration02](./img02.png)

Change the name to "AppAdForce.plist", click the Create button.

![SDK configuration03](./img03.png)

Choose the created property list file and open the menu by right click and select"Add Row".

![SDK configuration04](./img04.png)

Setting the each key and value.

![SDK configuration05](./img05.png)

Key and value for setting are following.

Key | Type | Value
:---: | :---: | :---
APP_ID | String | There will be a contact from the administrator,so please type the value.
SERVER_URL | String | There will be a contact from the administrator,so please type the value.
APP_SALT | String | There will be a contact from the administrator,so please type the value.
APP_OPTIONS | String | Please do not type anything, so please keep it empty.
CONVERSION_MODE | String | 1
ANALYTICS_APP_KEY | String | There will be a contact from the administrator,so please type the value. <br />If you do not use the access analysis, does not need to be set

[AppAdForce.plist sample](./AppAdForce.plist)

---
[TOP](/lang/en/README.md)
