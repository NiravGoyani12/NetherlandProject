# Page Object Strategy

## Standards
* In CK/TH specific step def, use p$() to get page object
```
import Wlp from ../wlp.ts
const wishlistPage = p$(Wlp)

Given(//, () => {
  const myLocator = wishlistPage.MyLocator();
})

```

* In Shared(EER/EED) step def or Common Element Steps, use services.pageObject.getSelector() to get page object
```
Given(//, () => {
  const myLocator = services.pageObject.getSelector('Experience.ShoppingBag.MyLocator')
})
```

## Page Object Strategy
The page object strategy is a mechanism to change page object in runtime based on a specific given condition.  Such as to switch React/Non-React page object, or switch New CC Iframe/Old CC Iframe in runtime. 

The purpose for this strategy is to write test case and step def only in one time, but the test is compatible for different conditions. 

The page object stragety is ONLY applied when you use `services.pageObject.getSelector()`

## Strategy Process
1. Apply strategy to Element Path(ex: Experience.ShoppingBag.MyLocator)
2. If the strategy condition is met, change the Element Path based on strategy(ex: Checkout.ReactShoppingBagPage.MyLocator)
3. Parse the Element Path to real selector in CK/TH specific pages
4. If 2nd step failed, Parse the Element Path to real selector in Common Pages
