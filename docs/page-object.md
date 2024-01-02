# Page Object
A page object can represent a Page or a component. Which could contains 2 kinds of information, locators and page related functions.

## How to define a page object
You could define a page object like following code:
```
@Singleton // The pages are saved as singleton instance inside a IoC container
export default class MyPage extends Page {

  // A function which can directly help you to navigate to this page.
  // If it is a component, you SHOULD NOT add this function. 
  // You cannot add more function parameters. This function is optional. 
  public async navigate() {
  }

  // A function which tells that the page or a component is fully loaded or not,
  // it should return a Promise<boolean>, you should not do any waitUntil inside the function. 
  // This function is optional.
  public async isLoaded() {

  }

  // This is an example locator
  public readonly MyLocator => () => this.derived({
    Destkop: 'test',
    Mobile: 'testMobile',
    Tablet: 'testTablet',
  }); 

  // This is your own customised function, sometimes you want to group some steps into one,
  // and call it directly from Step definition, 
  // it's also optional function. 
  // You can chose the function name by yourself.
  public async myOwnFunction() {

  }
}
```

## How to use Page object
There are 2 ways to get page object, by a string which contains class name and function name, or directly from page object singeleton.  There is a standard which explain that how we use these 2 different ways.

### Solution 1 - Use a string
* Example:
```
# An example of page object
@Singleton
export default class MyPage {
  public readonly LocatorWithArg => (text?: string) => this.derived({
    Destkop: `test${text}`,
    Mobile: `testMobile${text}`,
    Tablet: `testTablet${text}`,
  });

  public readonly SimpleLocator => () => this.derived({
    Destkop: 'test',
    Mobile: 'testMobile',
    Tablet: 'testTablet',
  });  
}

// When the page object locator which requires an arg or args
services.pageObject.getSelector('MyPage.LocatorWithArg', 'my arg')

// When the page object locator as simple as a pure string
services.pageObject.getSelector('MyPage.SimpleLocator')
```

* **When to use**:
It ONLY can use from Common Steps, since common steps are shared for multiple pages.  Or similiar, if your steps are shared by multiple pages,  then you can use this one. 

### Solution 2 - Use Singleton Instance
* Example:
```
// When the page object locator which requires an arg or args
const myPage = p$(MyPage);

myPage.LocatorWithArg('my arg')
myPage.SimpleLocator()
```

* **When to use**:
When you use page objects in the customised helper, page-related step definitions, then you need to use this solution. 

## Fake Page object
It is used when you only need the Mobile selector. You need to use fake otherwise your test will fail with error "Error: No page object for destkop version". 

* Example:
```
  public readonly SimpleLocator => () => this.derived({
    Destkop: '//fake',
    Mobile: 'testMobile',
  });
```