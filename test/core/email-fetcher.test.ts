/* eslint-disable max-len */
// /* eslint-disable no-console */
// import 'mocha';
// import { expect } from 'chai';
// import { EmailContent, searchEmailByRecipient } from '../../src/test/helper/email-fetcher.helper';
// import { SetUpSimpleTestLogger } from '../../src/core/logger/test.logger';


// const imaps = require('imap-simple');
// const { simpleParser } = require('mailparser');
// const _ = require('lodash');

// describe('email fetcher test', () => {
//   before(() => {
//     SetUpSimpleTestLogger();
//   });

//   // eslint-disable-next-line @typescript-eslint/no-unused-vars
//   const registrationBody = 'You made it, your Tommy account has been';
//   const registrationSubject = 'Your Tommy account';
//   const emailAddress = 'pvhqatester+gRrNlz69@gmail.com';
//   let email: EmailContent;

// const config = {
//   imap: {
//     user: 'pvhqatester@gmail.com',
//     password: 'pvhqa12345678',
//     host: 'imap.gmail.com',
//     port: 993,
//     tls: true,
//     authTimeout: 10000,
//   },
// };

// it('can connect to gmail', async () => {
//   await imaps.connect(config)
//     .then((connection) => {
//       console.log('we are connected');
//       connection.end();
//     }, (err: any) => {
//       console.log(err);
//     });
// });

// it('can open INBOX', async () => {
//   let emailsNumber: number;
//   emailsNumber = 0;

//   await imaps.connect(config)
//     .then((connection) => connection.openBox('INBOX')
//       .then(async () => {
//         console.log('we are in inbox');
//         const twoDaysAgo: Date = new Date();
//         const delay: number = 24 * 3600 * 1000 * 2;
//         twoDaysAgo.setTime(Date.now() - delay);
//         const searchCriteria = [
//           'UNSEEN', ['SINCE', twoDaysAgo],
//         ];
//         const fetchOptions = {
//           bodies: ['HEADER'],
//           markSeen: false,
//         };
//         console.log(`Searching mails since ${twoDaysAgo.toISOString()}`);
//         await connection.search(searchCriteria, fetchOptions)
//           .then((searchResults) => {
//             console.log(`Fetched ${searchResults.length} emails`);
//             emailsNumber = searchResults.length;
//             connection.end();
//           });
//       }));
//   expect(emailsNumber).greaterThan(1);
// });

// it('can fetch specific email and parse content', async () => {
//   const content: EmailContent = {
//     to: '', from: '', subject: '', body: '', date: new Date(),
//   };

//   await imaps.connect(config)
//     .then((connection) => connection.openBox('INBOX')
//       .then(async () => {
//         console.log('we are in inbox');
//         const twoDaysAgo: Date = new Date();
//         const delay: number = 24 * 3600 * 1000 * 2;
//         twoDaysAgo.setTime(Date.now() - delay);
//         const searchCriteria = [
//           'UNSEEN', ['SINCE', twoDaysAgo], ['TO', 'pvhqatester+FvTXhlzU@gmail.com'],
//         ];
//         const fetchOptions = {
//           bodies: ['HEADER', 'TEXT', ''],
//         };
//         console.log(`Searching mails since ${twoDaysAgo.toISOString()}`);
//         await connection.search(searchCriteria, fetchOptions)
//           .then((messages) => {
//             console.log(`Fetched ${messages.length} emails for ${emailTo} email`);
//             messages.forEach((item) => {
//               const all = _.find(item.parts, { which: '' });
//               const id = item.attributes.uid;
//               const idHeader = `Imap-Id: ${id}\r\n`;
//               simpleParser(idHeader + all.body)
//                 .then((mail) => {
//                   // access to the whole mail object
//                   content.to = mail.to.value[0].address;
//                   content.body = mail.text;
//                   content.subject = mail.subject;
//                   content.from = mail.from.value[0].address;
//                   content.date = mail.date;

//                   console.log(`TO object is: ${content.to}`);
//                   console.log(`subject is: ${content.subject}`);
//                   console.log(`from is: ${content.from}`);

//                   connection.end();
//                 });
//             });
//           });
//       }));
// });

//   it('can read registration email for specific user', async () => {
//     // this does not work as it requires browser.
//     const emails = await searchEmailByRecipient(emailAddress, 120);
//     const firstEmail = emails[0];
//     // expect(email.to).equal(emailAddress);
//     // expect(email.from).equals(registrationEmailSenderTH);
//     console.log(`to is: ${firstEmail.to}`);
//     console.log(`from is: ${firstEmail.from}`);
//     console.log(`subject is: ${firstEmail.subject}`);
//     expect(firstEmail.to).contains(emailAddress);
//     expect(firstEmail.subject).contains(registrationSubject);
//     expect(firstEmail.body).contains(registrationBody);
//   });
// });
