# Support for Safari

<i>Note: This readme is only relevant for Mac users</i>

### Make Sure You Have Safari’s WebDriver
<br/>
Safari and Safari Technology Preview each provide their own safaridriver executable. Make sure you already have the executable on your device:

- Safari’s executable is located at /usr/bin/safaridriver.

<br/>

### Configure Safari to Enable WebDriver Support
Safari’s WebDriver support for developers is turned off by default. How you enable it depends on your operating system.

**High Sierra and later:**
<br/>
Run `safaridriver --enable` once. (If you’re upgrading from a previous macOS release, you may need to use sudo.)

**Sierra and earlier:**
<br/>
If you haven’t already done so, make the Develop menu available. 
<br/>
1. Choose Safari > Preferences, and on the Advanced tab, select “Show Develop menu in menu bar.” 
2. Choose Develop > Allow Remote Automation.
3. Authorize safaridriver to launch the XPC service that hosts the local web server. To permit this, manually run /usr/bin/safaridriver once and follow the authentication prompt.

### Run tests on your local

1. Make sure you have local selenium server running
2. Commands to use:

```
# CK
npm run ck-debug-safari

# TH
npm run debug-safari
```

### Resources:
1. https://developer.apple.com/documentation/webkit/testing_with_webdriver_in_safari