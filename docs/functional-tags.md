# Functional tags

For some tags, they have different meaning, it will lead different behaviour when exeucting test. We call them Functional tags.

Here is the list of functional tags:

* @MultipleTabs: when your test play with multiple tabs, or open multiple tabs, you SHOULD put this tag, it will help you to close unused tabs after scenario completed
* @IFrame: when your test play with iframes, such as switch to iframe, you SHOULD put this tag, it will help you to switch back to main content after scenario completed
* @ClearLocalStorage: when your test changed local storage, and which will impact other tests, such as A/B testing with Optimizely,  you should put this tag, and it will help you to clear all local storage after the test.
* @ScreenResize: when your test changes screen size, you SHOULD put this tag, it will help you to maximize screen size after scenario completed. Please note: only applicable to desktop.
* @ExcludeUat: scenarios with this tag are not supposed to be executed on UAT environment
* @ExcludeProdStag: scenarios with this tag are not supposed to be executed on prod-stag environment