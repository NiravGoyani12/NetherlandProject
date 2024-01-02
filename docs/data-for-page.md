# Data for Each Page

## Data source for different component / page
* Search Suggestions : FH (specific API)
* Search : FH (is blocked? is parent category is visible?, if both true, then visible in Search)
* Wish List : FH (is blocked? doesn't care about the visibility of parent category)
* Wish List counter : DB
* PDP: DB
* Mini Bag & Added To Bag popup: DB
* Shoppping bag counter: DB
* All Checkout pages: DB

## How to use data
* If it's price related, ex fetch product with discount,  then you should use ProductItem queries
* If it's attribtue/group related, ex find a PDP with OS,  then you should use ProductStyle queires

## Product fetch and Product Detail fetch
* Product Fetch could fetch multiple products, the model of product item and product style are same
* Product Detail fetch only works for One product item, or One product style,  the model is different

