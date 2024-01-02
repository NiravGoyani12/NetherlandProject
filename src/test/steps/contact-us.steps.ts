import { When } from '@pvhqa/cucumber';

When(/on contactUs page I remove captcha/, async () => {
  await browser.execute('document.getElementById("ContactUsSubmitButton").removeAttribute("disabled");');
});
