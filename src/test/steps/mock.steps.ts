import { When, Then } from '@pvhqa/cucumber';
import { GetTestLogger } from '../../core/logger/test.logger';

When(/I mock "(.*)" with status code (\d+) and blank response body$/, async (url: string, sCode: number) => {
  GetTestLogger().info(`[Mocking] URL: ${url} with status code ${sCode}`);
  const statusCodesArr: Array<number> = [401, 404, 501, 502, 504];
  const mockResponse = await browser.mock(url);
  if (!statusCodesArr.includes(sCode)) {
    throw new Error(`Status code not recognised: ${sCode} Please use any of the following: 401, 404, 501, 502, 504`);
  } else {
    mockResponse.respond([{}], {
      statusCode: sCode,
    });
  }
});

Then(/I mock "(.*)" with empty response body$/, async (url: string) => {
  GetTestLogger().info(`[Mocking] URL: ${url} with blank response body`);
  const mockResponse = await browser.mock(url);
  mockResponse.respond([{}], {});
});
