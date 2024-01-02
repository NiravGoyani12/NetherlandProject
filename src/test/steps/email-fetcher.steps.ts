import { Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../core/services';
import { searchEmailByRecipient } from '../helper/email-fetcher.helper';
import { GetTestLogger } from '../../core/logger/test.logger';
import TranslationService from '../../core/services/translation.service';

const translation = new TranslationService();

const brand = services.env.Brand;
const emailSenderTH = 'store@mailing.tommy.com';
const emailSenderCK = 'store@mailing.calvinklein.com';

Then(/I see "(.*)" mail for email (.*) in (\d+) seconds(?: and store "(.*)" link with key (.*))?/, async (
  emailType: string, emailAddress: string,
  timeoutInSec?: number, typeOfLink?: string, key?: string) => {
  const emailSender = brand === 'ck' ? emailSenderCK : emailSenderTH;
  emailAddress = services.account.parse(emailAddress);

  const lang = services.site.siteInfo.LOCALENAME.toLowerCase();

  const registrationSubject = translation.get(lang, 'registration_email_title');
  const registrationBody = translation.get(lang, 'registration_email_body');
  const resetPasswordSubject = translation.get(lang, 'password_reset_email_title');
  const resetPasswordBody = translation.get(lang, 'password_reset_email_body');

  const emails = await searchEmailByRecipient(
    emailAddress,
    timeoutInSec * 1000,
    emailType === 'resetPassword' ? resetPasswordSubject : '',
  );
  if (emails.length > 1) {
    GetTestLogger().warn(`Expected to get 1 email for ${emailAddress} since yesterday, but got ${emails.length}. Checking first email.`);
  }
  switch (emailType) {
    case 'registration':
      expect(emails[0].subject.toLocaleLowerCase()).to.be
        .equal(registrationSubject.toLocaleLowerCase());
      expect(emails[0].body.replace(/&nbsp;/g, ' ').replace(/\n/g, ' ').toLocaleLowerCase())
        .contain(registrationBody.toLocaleLowerCase());
      expect(emails[0].from).contain(emailSender);
      break;
    case 'resetPassword':
      expect(emails[0].subject.toLocaleLowerCase()).to.be
        .equal(resetPasswordSubject.toLocaleLowerCase());
      expect(emails[0].body.replace(/&nbsp;/g, ' ').replace(/\n/g, ' ').toLocaleLowerCase())
        .contain(resetPasswordBody.toLocaleLowerCase());
      expect(emails[0].from).contain(emailSender);
      break;
    default:
      throw new Error(`Email type ${emailType} is not recognized`);
  }
  if (typeOfLink === 'Reset') {
    // find and store an element <a href>
    const keyPasswordResetLink = 'password_reset_link'; // to map translation from dictionary
    const title = translation.get(lang, keyPasswordResetLink); // get translation for site language

    const allLinks = emails[0].html.match(/<a(.*)href="https:\/\/click.mailing(.*?)(.*)\/a>/g);
    const linksWithTitle = allLinks.filter((next) => next.indexOf(`${title}`) > 0); // filter element with link with title Reset
    if (!linksWithTitle.length || linksWithTitle.length === 0) {
      throw new Error(`Cannot parce links from  ${emailType} email: expected to get more than 0, got ${linksWithTitle}`);
    } else if (linksWithTitle.length > 1) {
      GetTestLogger().warn(`Expected to get 1 link for reset password, got ${linksWithTitle.length} instead. Using first link ${linksWithTitle[0]}`);
    }
    const linkToStore = linksWithTitle[0].match(/href="(.*?)"/g)[0].toString().replace('href="', '').replace('"', '');
    services.world.store(key, linkToStore);
  }
});

Then(/from email I click a link (.*)/, async (link: string) => {
  link = services.world.parse(link);
  await browser.url(link);
  await browser.waitForPageLoaded();
});
