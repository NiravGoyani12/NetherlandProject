/// <reference types="webdriverio/webdriverio"/>

declare module WebdriverIO {
    // adding command to `$()`
    interface Element {
        // don't forget to wrap return values with Promise
        jsClick: () => Promise<void>
        safeClick: (waitForClickAble?: WaitForOptions, clickOptions?: ClickOptions) => Promise<void>
        safeClickRetry: (displayedElementSelector: any, clickOptions?: ClickOptions) => Promise<void>
        safeType: (value: string | number | boolean | object | any[], isSet?:boolean, waitForIntractAble?: WebdriverIO.WaitForOptions) => Promise<void>
        selectDropdown: (optionLocator: string, byJs?: boolean, bySimpleClick?: boolean) => Promise<void>
        setCheckbox: (isChecked: boolean) => Promise<void>
        hover: (waitForDisplayOptions?: WebdriverIO.WaitForOptions) => Promise<void>
        swipeToElementMobile: () => Promise<void>
        getTextByJs: (this: WebdriverIO.Element) => Promise<string>
        smoothScrollToElement: (this: WebdriverIO.Element) => Promise<void>
        setAttribute: (attributeName: string, attributeValue: string) => Promise<void>
    }

    interface Browser {
        waitForPageLoaded: () => Promise<void>
        setInitStorage: () => Promise<void>
        setInitCookiesAndRefresh: () => Promise<void>
        setPaginationCookiesAndRefresh: () => Promise<void>
        setInitCookiesAndNavigate: (url: string) => Promise<void>
        setOnlyFunctionalCookiesAndNavigate: (url: string) => Promise<void>
        setAuthCookies: (email: string, password: string, newAccount?: boolean) => Promise<void>
        setCookiesAndRefresh: (cookies: WebDriver.Cookie[]) => Promise<void>
        deleteAuthenticationCookies: () => Promise<void>
        deleteUserActivityCookies: () => Promise<void>
        deletePersistentCookies: () => Promise<void>
        deleteGDPRCookies: () => Promise<void>
        deleteGenderCookies: () => Promise<void>
        deleteNewsletterCookies: () => Promise<void>
        deleteAllStorage: () => Promise<void>
        resetAuthCookies: (cookies: WebDriver.Cookie[]) => Promise<void>
        getPvhCookiesState: (functionalOnly: boolean) => Promise<boolean>
        getGenderCookiesState: () => Promise<boolean>
        getOlapicCookiesState: () => Promise<boolean>
        waitUntilResult: (condition: () => Promise<any>, timeoutMsg?: string, timeout?: number, interval?: number) => Promise<any>
        scrollToWindowDirection: (position: 'bottom' | 'top') => Promise<void>
        smoothScrollToWindowDirection: (position: 'bottom' | 'top') => Promise<void>
        getNetworkRequestNumber: (requestType: string, partialRequestName: string) => Promise<number>
        getNetworkRequest: (requestType: string, partialRequestName: string) => Promise<string>
        safeDeleteAllCookies: () => Promise<void>
        safeTouch: (x: number, y: number) => Promise<void>
        mouseMove: (x: number, y: number) => Promise<void>
    }

}