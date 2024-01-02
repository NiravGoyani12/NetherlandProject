Feature: Unified Shopping Bag - Edit

	@FullRegression @RCTest
	@Desktop @Mobile
	@Chrome @FireFox @Safari
	@ShoppingBag @EditItem @UnifiedCheckout
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For normal size product a guest user can edit size and quantity and save the changes
		Given There is 1 normal size product items of locale <locale> with inventory between 800 and 99999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.EditOrderItemSection is displayed in 10 seconds
		Then in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber has correct default value
		When in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber I select a instock size saved as #size into product item #newSku
			And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
		Then in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber has correct sizes
		When I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
		Then I see Experience.ShoppingBag.EditProductButton with args #newSku is displayed in 5 seconds
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 2 contains text "#size"
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#quantity"

		@tms:UTR-12644 @P1
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16470
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - A logged in user can edit normal size product - change size and quantity
		Given There is 1 normal size product items of locale <locale> with inventory between 800 and 10000
			And I am on locale <locale> home page with forced accepted cookies
			And I am a logged in user
			And I wait for 2 seconds
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber I select a instock size saved as #size into product item #newSku
			And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
			And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
		Then I see Experience.ShoppingBag.EditProductButton with args #newSku is displayed
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 2 contains text "#size"
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#quantity"

		@tms:UTR-2249
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

		@tms:UTR-16473
		Examples:
			| locale  | langCode |
			| default | default  |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For normal size product a guest user can edit quantity and save the changes
		Given There is 1 normal size product items of locale <locale> with inventory between 800 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
		When I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
		Then I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#quantity"

		@tms:UTR-12643
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16474
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For one size product a guest user can edit quantity and save the changes
		Given There is 1 one size product items of locale <locale> with inventory between 11 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
		When I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
		Then I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#quantity"

		@tms:UTR-12647
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

		@tms:UTR-16475
		Examples:
			| locale  | langCode |
			| default | default  |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For multi color product a guest user can edit color and save the changes
		Given There is 1 multi colour product with at least 3 colours of locale <locale> with inventory between 200 and 99999
			And I extract a product style from product product1#stylePartNumber saved as #styleColorPartNumber
			And I extract a product item from product style #styleColorPartNumber which has inventory saved as #skuPartNumber
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item #skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args #skuPartNumber
		Then in page Experience.ShoppingBag edit colour dropdown of product item #skuPartNumber has correct default value
			And in page Experience.ShoppingBag edit colour dropdown of product item #skuPartNumber has correct colours
		When in page Experience.ShoppingBag edit colour dropdown of product item #skuPartNumber I select a instock colour saved as #newColor
			And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
		Then I see Experience.ShoppingBag.Item with args #skuPartNumber is not displayed in 3 seconds
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 1 contains text "#newColor"

		@tms:UTR-12646
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16476
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For multi color and multi size product a guest user can edit color,size and quantity and save the changes
		Given There are 2 multi colour product with at least 3 colours of locale <locale> with inventory between 200 and 9999
			And I extract a product style from product product2#stylePartNumber saved as #styleColorPartNumber
			And I extract a product item from product style #styleColorPartNumber which has inventory saved as #skuPartNumber
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item #skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds
		When I click on Experience.ShoppingBag.EditProductButton with args #skuPartNumber
			And in page Experience.ShoppingBag edit colour dropdown of product item #skuPartNumber I select a instock colour saved as #newColor
			And in page Experience.ShoppingBag edit size dropdown of product item #skuPartNumber I select a instock size saved as #newSize into product item #newSku
			And in page Experience.ShoppingBag edit quantity dropdown of product item #skuPartNumber I select the highest available quantity saved as #newQuantity
			And I click on Experience.ShoppingBag.EditSaveButton with args #skuPartNumber
		Then I see Experience.ShoppingBag.Item with args #newSku is displayed
			And I see Experience.ShoppingBag.Item with args #skuPartNumber is not displayed in 2 seconds
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 1 contains text "#newColor"
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 2 contains text "#newSize"
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#newQuantity"

		@tms:UTR-12645
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16322
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |


	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari
	@ShoppingBag @EditItem @MiniShoppingBag @UnifiedCheckout @P2
	@feature:EESCK-11607
	Scenario Outline: Edit Shopping Bag - For width only items are displayed correctly in SB and edit is not impacted
		Given There is 1 width only size product item of locale <locale> with inventory between 10 and 99999
			And I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
			And I extract product item detail by sku part number product1#skuPartNumber
		When in unified PDP I select size by sku part number product1#skuPartNumber
			And I click on ProductDetailPage.Pdp.AddToBagButton
			And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
		When I click on ProductDetailPage.Header.ShoppingBagButton
		Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
			And I see Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber I select a instock size saved as #size into product item #newSku
			And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
		Then in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber has correct sizes
		When I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber is not displayed
		Then I see Experience.ShoppingBag.EditProductButton with args #newSku is displayed in 5 seconds

		@tms:UTR-16351
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16479
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For one size product I am unable to edit sizes
		Given There is 1 one size product items of locale <locale> with inventory between 11 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.EditQuantityDropdown is displayed
		Then I see Experience.ShoppingBag.EditSizeDropdown is not displayed in 3 seconds

		@tms:UTR-16480
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16481
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For one color product I am unable to edit colors
		Given There is 1 product with 1 colour of locale <locale> with inventory between 10 and 9999
			And I extract a product style from product product1#stylePartNumber saved as #styleColorPartNumber
			And I extract a product item from product style #styleColorPartNumber which has inventory saved as #skuPartNumber
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item #skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args #skuPartNumber
			And I wait until Experience.ShoppingBag.EditQuantityDropdown is displayed
		Then I see Experience.ShoppingBag.EditColourDropdown is not displayed in 3 seconds

		@tms:UTR-17122
		Examples:
			| locale  | langCode |
			| default | default  |


		@tms:UTR-16483
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending
	@ShoppingBag @EditItem @UnifiedCheckout @P2
	#TODO:fix size dropdown validation
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - For multi size product I am unable to select OOS size
		Given There is 1 normal size product style of locale <locale> where 2 sizes are out of stock with inventory between 2 and 9999
			And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item #skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
		When I click on Experience.ShoppingBag.EditProductButton with args #skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
		Then in page Experience.ShoppingBag edit size dropdown of product item #skuPartNumber has correct sizes
			And in page Experience.ShoppingBag edit size dropdown of product item #skuPartNumber has correct default value

		@tms:UTR-16484
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16485
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending @P2
	@ShoppingBag @UnifiedCheckout @EditItem
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - User is able to edit multiple products on shopping bag page
		Given There are 2 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 200 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2 in 10 seconds
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber is displayed
			And I click on Experience.ShoppingBag.EditProductButton with args product2#skuPartNumber
			And I click on <buttonToClick> with args product2#skuPartNumber
		Then the count of displayed elements Experience.ShoppingBag.EditProductButton is equal to 2
			And the count of displayed elements Experience.ShoppingBag.RemoveButton is equal to 2

		@tms:UTR-17123
		Examples:
			| locale  | langCode | buttonToClick                         |
			| default | default  | Experience.ShoppingBag.EditSaveButton |

		@tms:UTR-16487
		Examples:
			| locale           | langCode         | buttonToClick                           |
			| multiLangDefault | multiLangDefault | Experience.ShoppingBag.EditCancelButton |

	@FullRegression
	@Desktop @Mobile
	@Chrome @EditItem
	@FireFox @SafariPending @P2 @ExcludeDB0 @ExcludeUat
	@ShoppingBag @UnifiedCheckout
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - Changing quantity for item in shopping bag doesn't affect listing order
		Given There are 1 normal size product item of locale <locale> with inventory between 11 and 9999
			And There are 2 one size product items of locale <locale> with inventory between 11 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product3#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 3
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
			And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
			And I click on Experience.ShoppingBag.EditProductButton with args product2#skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
			And in page Experience.ShoppingBag edit quantity dropdown of product item product2#skuPartNumber I select the highest instock quantity saved as #quantity
			And I click on Experience.ShoppingBag.EditSaveButton with args product2#skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
		Then I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 1 containing "product3#skuPartNumber"
			And I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 2 containing "product2#skuPartNumber"
			And I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 3 containing "product1#skuPartNumber"

		@tms:UTR-2259
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16488
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @EditItem
	@FireFox @SafariPending @P2 @ExcludeDB0 @ExcludeUat
	@ShoppingBag @UnifiedCheckout
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - Removing item from shopping bag doesn't affect listing order
		Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 5 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product3#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 3
		When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
			And I click on Experience.ShoppingBag.RemoveConfirmButton
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
		Then I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 1 containing "product3#skuPartNumber"
			And I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 2 containing "product2#skuPartNumber"

		@tms:UTR-2260
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16489
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression @RCTest
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending
	@ShoppingBag @UnifiedCheckout @P2 @ExcludeDB0 @ExcludeUat @EditItem
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - Changing size of the item in shopping bag changes listing order
		Given There is 1 normal size product item of locale <locale> with inventory between 99 and 9999
			And There are 2 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 5 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product3#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 3
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber I select a instock size saved as #size into product item #newSku
			And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
		Then I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 1 containing "#newSku" in 10 seconds
			And I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 2 containing "product3#skuPartNumber"
			And I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 3 containing "product2#skuPartNumber"

		@tms:UTR-2261
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16491
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending
	@ShoppingBag @UnifiedCheckout @P2 @ExcludeDB0 @ExcludeUAT @EditItem
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - Changing color of the item in shopping bag changes listing order
		Given There is 1 multi colour product with at least 3 colours of locale <locale> with inventory between 200 and 9999
			And I extract a product style from product product1#stylePartNumber saved as #styleColorPartNumber
			And I extract a product item from product style #styleColorPartNumber which has inventory saved as #skuPartNumber
			And There are 2 one size product items of locale <locale> with inventory between 11 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item #skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product3#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 3
		When I click on Experience.ShoppingBag.EditProductButton with args #skuPartNumber
			And in page Experience.ShoppingBag edit colour dropdown of product item #skuPartNumber I select a instock colour saved as #newColor
			And I click on Experience.ShoppingBag.EditSaveButton with args #skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
		Then I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 1 not containing "#skuPartNumber" in 2 seconds
			And I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 2 containing "product3#skuPartNumber"
			And I see the attribute data-partnumber of element Experience.ShoppingBag.ItemByIndex with index 3 containing "product2#skuPartNumber"
			And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 1 contains text "#newColor"

		@tms:UTR-2262
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16492
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending @Translation @Lokalise
	@ShoppingBag @UnifiedCheckout @P2 @EditItem
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - Validate product details order in the shopping bag
		Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
			And I get translation from lokalise for "Color" and store it with key #Color
			And I get translation from lokalise for "Size" and store it with key #Size
			And I get translation from lokalise for "Quantity" and store it with key #Quantity
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds
		Then I see Experience.ShoppingBag.ItemDetailsInfoByIndex with index 1 contains text "#Color"
			And I see Experience.ShoppingBag.ItemDetailsInfoByIndex with index 2 contains text "#Size"
			And I see Experience.ShoppingBag.ItemDetailsInfoByIndex with index 3 contains text "#Quantity"
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
			And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
		Then I see Experience.ShoppingBag.ItemDetailsInfoByIndex with index 1 contains text "#Color"
			And I see Experience.ShoppingBag.ItemDetailsInfoByIndex with index 2 contains text "#Size"
			And I see Experience.ShoppingBag.ItemDetailsInfoByIndex with index 3 contains text "#Quantity"

		@tms:UTR-2263
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:TR-16493
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari
	@ShoppingBag @EditItem @MiniShoppingBag @UnifiedCheckout @P2 @feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - Mini shopping bag is updated after editing product in shopping bag
		Given There is 1 normal size product items of locale <locale> with inventory between 200 and 9999
			And There is 1 one size product items of locale <locale> with inventory between 200 and 9999
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
			And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #initialTotalPrice
		When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
			And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber I select a instock size saved as #newSize into product item #newSku
			And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
			And I wait for 5 seconds
			And I click on Experience.ShoppingBag.EditProductButton with args product2#skuPartNumber
			And in page Experience.ShoppingBag edit quantity dropdown of product item product2#skuPartNumber I select the highest instock quantity saved as #quantity
			And I click on Experience.ShoppingBag.EditSaveButton with args product2#skuPartNumber
			And I wait until Experience.ShoppingBag.ItemLoader is not displayed
			And I wait for 5 seconds
			And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #updatedTotalPrice
			And I wait for 2 seconds
			And I hover over Experience.Header.ShoppingBagButton
		Then the count of displayed elements Experience.MiniShoppingBag.Products is equal to 2
			And I see Experience.MiniShoppingBag.ProductQuantityInfo with args product2#skuPartNumber contains text "10"
			And I see Experience.MiniShoppingBag.ProductSizeInfo with index 2 contains text "#newSize"
			And I see Experience.MiniShoppingBag.ProductQuantityInfo with index 2 contains text "1"
			And the numeric value of Experience.MiniShoppingBag.TotalPrice is equal to #updatedTotalPrice
			And the numeric value of Experience.MiniShoppingBag.TotalPrice is greater than #initialTotalPrice
			And I see Experience.Header.ShoppingBagCounter contains text "11"

		@tms:UTR-2264
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16494
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari
	@ShoppingBag @EditItem @MiniShoppingBag @UnifiedCheckout @P2
	@feature:CET1-4004
	Scenario Outline: Edit Shopping Bag - Removing items from shopping bag should not impact the page scrolling
		Given There are 3 any product items of locale <locale> with inventory between 10 and 500
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
			And I am on locale <locale> shopping bag page of langCode <langCode> for product item product3#skuPartNumber
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 3
		When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
			And I click on Experience.ShoppingBag.RemoveConfirmButton
			And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
		When I scroll to the element Experience.ShoppingBag.PaymentMethodLogos
		Then I see Experience.ShoppingBag.PaymentMethodLogos is in viewport

		@tms:UTR-2265
		Examples:
			| locale  | langCode |
			| default | default  |

		@tms:UTR-16495
		Examples:
			| locale           | langCode         |
			| multiLangDefault | multiLangDefault |


#TODO
# @FullRegression @RCTest
# @Desktop @Mobile
# @Chrome @FireFox @Safari
# @ShoppingBag @EditItem @UnifiedCheckout @issue:CET1-3721
# Scenario Outline: Edit Shopping Bag - For Jeans with Length and width, a guest user can edit size and quantity and save the changes
# 	Given There is 1 normal size product items of locale <locale> with inventory between 0 and 9999
# 		And I am on locale <locale> shopping bag page for product item 8719852781709 with forced accepted cookies
# 		And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
# 	When I click on Experience.ShoppingBag.EditProductButton with args 8719852781709
# 	Then in page Experience.ShoppingBag edit size dropdown of product item 8719852781709 has correct default value
# 	When in page Experience.ShoppingBag edit size dropdown of product item 8719852781709 I select a instock size saved as #size into product item #newSku
# 		And in page Experience.ShoppingBag edit quantity dropdown of product item 8719852781709 I select the highest instock quantity saved as #quantity
# 		And in page Experience.ShoppingBag edit quantity dropdown of product item 8719852781709 has highest instock quantity
# 	When I click on Experience.ShoppingBag.EditSaveButton with args 8719852781709
# 	Then I see Experience.ShoppingBag.EditProductButton with args #newSku is displayed
# 		And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 2 contains text "#size"
# 		And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#quantity"

# 	Examples:
# 		| locale |
# 		| ee     |

# @FullRegression
# @Desktop @Mobile
# @Chrome @FireFox @SafariPending
# @ShoppingBag @UnifiedCheckout @toreview
# Scenario Outline: Edit Shopping Bag - For low stock product item I am unable to select high quantity
# 	Given There is 1 one size product item of locale <locale> with inventory between 2 and 6
# 		And I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
# 		And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
# 	When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
# 		And I wait until Experience.ShoppingBag.ItemLoader is not displayed
# 		And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
# 	Then in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber has highest instock quantity

# 	Examples:
# 		| locale |
# 		| ee     |