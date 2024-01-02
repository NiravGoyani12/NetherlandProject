export const options = JSON.parse(`{
    "hostname":"localhost",
    "port": 4444,
    "protocol": "http",
    "path": "/wd/hub",
    "logLevel": "silent",
    "connectionRetryCount": 0,
    "capabilities": {
        "browserName": "chrome",
        "goog:chromeOptions": {
            "args": ["--start-maximized", "--headless", "--ignore-certificate-errors", "no-sandbox", "test-type"]
        }
    }
}`) as WebdriverIO.RemoteOptions;

export const remoteOptions = JSON.parse(`{
    "hostname":"144.2.51.55",
    "port": 80,
    "path": "/wd/hub",
    "protocol": "http",
    "capabilities": {
        "browserName": "chrome",
        "goog:chromeOptions": {
            "args": ["--start-maximized",  "--ignore-certificate-errors", "no-sandbox", "test-type"]
        },
        "zal:recordVideo": true,
        "zal:idleTimeout": 2,
        "zal:testFileNameTemplate": "test_{testName}"
    },
    "logLevel": "info",
    "headers": {
        "Host": "144.2.51.55"
    }
}`) as WebdriverIO.RemoteOptions;

export const timeout = JSON.parse(`{
    "implicit": 0,
    "pageLoad": 60000,
    "script": 60000,
    "elementExist": 10000,
    "elementClickable": {
        "timeout": 5000
    }
}`) as WebdriverIO.Timeouts;
