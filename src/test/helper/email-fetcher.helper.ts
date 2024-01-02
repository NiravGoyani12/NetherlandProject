import imaps from 'imap-simple';
import { simpleParser } from 'mailparser';
import { GetTestLogger } from '../../core/logger/test.logger';

export interface EmailContent {
  to: string;
  from: string;
  subject?: string;
  body?: string;
  date?: Date;
  html?: string;
}

const config = {
  imap: {
    user: 'pvhqatester@gmail.com',
    password: 'pvhqa12345678',
    host: 'imap.gmail.com',
    port: 993,
    tls: true,
    authTimeout: 5000,
  },
};
// eslint-disable-next-line import/no-extraneous-dependencies
const _ = require('lodash');

export async function searchEmailByRecipient(
  emailTo: string, timeout: number, subject?: string,
): Promise<Array<EmailContent>> {
  const connection = await imaps.connect(config);
  try {
    await connection.openBox('INBOX');

    const yesterday: Date = new Date();
    const delay: number = 24 * 3600 * 1000 * 1; // we don't need all, only since yesterday
    yesterday.setTime(Date.now() - delay);
    let searchCriteria;
    if (subject) {
      searchCriteria = [
        'UNSEEN', ['SINCE', yesterday], ['TO', emailTo], ['SUBJECT', subject],
      ];
    } else {
      searchCriteria = [
        'UNSEEN', ['SINCE', yesterday], ['TO', emailTo],
      ];
    }
    const fetchOptions = {
      bodies: ['HEADER', 'TEXT', ''],
    };
    GetTestLogger().info(`Searching mails for ${emailTo} since ${yesterday.toISOString()}`);

    const messages = await browser.waitUntilResult(async () => {
      const m = await connection.search(searchCriteria, fetchOptions);
      if (m && m.length > 0) {
        return m;
      }
      await browser.refresh();
      return undefined;
    }, '', timeout, 5000);

    const emailsPromiseList: Array<Promise<EmailContent>> = messages.map(async (item) => {
      const all = _.find(item.parts, { which: '' });
      const id = item.attributes.uid;
      const idHeader = `Imap-Id: ${id}\r\n`;
      const mail = await simpleParser(idHeader + all.body);
      return {
        to: mail.to.value[0].address,
        from: mail.from.value[0].address,
        subject: mail.subject,
        body: mail.text,
        date: mail.date,
        html: mail.html,
      };
    });
    const emails = await Promise.all(emailsPromiseList);
    connection.end();
    return emails;
  } finally {
    if (connection) {
      connection.end();
    }
  }
}
