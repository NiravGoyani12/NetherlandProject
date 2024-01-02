# Find Element Strategy

## API

* $ : (Not recommended to use) Try to get element, no exception raised when element is not exist
  ```js
  // No exceiption raised when element is exist
  let existElement = await $(selector)
  await existElement.click() 

  // Bad code: it will raise unhandled promise error when do .click()
  let notExistElement = await $(selector)
  await notExistElement.click() //  Exception raised here if element not exist after implicit wait and connection retry.
  ```
* exist$ : Get the exist element
  ```js
  // click until element is exist
  let element = await exist$(selector)
  await element.click()

  // raise an exception in 1st line
  let notExistElement = await exist$(selector) // Exception raised here
  await notExistElement.click()
  ```
* maybeExist$ : Return null if element is not exist
  ```js
  let element = await maybeExist$(selector) // same as exist$ when element is exist
  await element.click()

  let notExistElement = await maybeExist$(selector) // return null
  expect(notExistElement).to.be.null
  ```
* maybeDisplayed$ : Return null if element is not exist or exist but not displayed
  ```js
  let element = await maybeDisplayed$(selector) // same as exist$ but also wait until displayed

  let notExistElement = await maybeDisplayed$(selector) // return null if not exist or not displayed
  ```