# ECOM Automation Standards

## Step Def Regex Standard
1. If the input value is text, and the text can include space or special chars, it should be wrapped with double quote like `"(.*)"`
2. If the input value is Locale or LangCode, it should be as `(default|[^\s]+)`
3. If it is element validation,  it should start with `I (wait until|see) ...`
4. If it is page related step,  it should start with `in <some page> I do something`, there is no `that` between them.
5. If it is a key that used for saving data inot scenario context, it should be as `((#[A-Za-z0-9]+))`

## Step Standard
1. If you are checking something is NOT displayed by common steps, the timeout should be explicityly provided in Feature step. such as I see XXX is not displayed in 5 seconds

## Page Object Naming Standards
1. the file name should be all in lowercase, and multiple words should be concated by `-`, like `shopping-bag-page.ts`
2. If it is a page, the file name should end with name
3. the page object should be a class, with `@Singleton` attribute, the name of class should 100% match to file name in camelcase, like `class ShoppingBagPage`

## Page Object Item Naming Standards
1. If it is a drop down, it should end with `Dropdown`, such as `TitleDropdown`
2. If it is a check box, it should end with `Checkbox`, such as `Checkbox`, the selector SHOULD be a pure `<input />`

## WIP Features or Code
1. Add `// TODO: <comment>`, we will continueslly tracking the todo list
2. Try to avoid to add any comments in .feature file

## PR review 
0. Your PR is NOT greater then 500 lines added / deleted
1. Use PR template
2. All code should be reviewd
3. If your PR add new test, at least your test should be PASSED from Chrome Browser Lab
4. Each PR at least need 1 thumb up,  don't be shy to leave thumb down, it's quiet common! BUT you need to leave a comment with reason
5. Check the checkbox for the PR's purpose and ensure your Pipeline is passed
6. If all above are OK, and ALL comment thread are resolved,
7. Then you can merge with SQAUSH COMMITS!

## Coding standards
1. All code should be lint
2. If you are adding new functions, updating new functions in src/core, it OBLIGATED requires you add new unit test, and ensure the unit test can pass

## Tickets Working Priority Standards
1. Fix nightly regression failed test case are ALWAYS HIGHEST PRIORITY then EVERYTHING
2. Sprint business ticket are ALWAYS High priorith then Automation Backlog tickets
