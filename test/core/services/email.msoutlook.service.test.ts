/* eslint-disable max-len */
/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable no-console */
import { expect } from 'chai';
import fs from 'fs';
import 'mocha';
import { SetUpTestlogger } from '../../../src/core/logger/test.logger';
import EmailMsOutlookService from '../../../src/core/services/email-ms-outlook.service';

describe('Email Outlook Service Tests', () => {
  let emailMsOutlookService: EmailMsOutlookService;

  before(async () => {
    await fs.promises.mkdir('./output/test', { recursive: true });
    SetUpTestlogger('./output/test/test.log', 'info');
    emailMsOutlookService = new EmailMsOutlookService();
  });

  it('can get proper response body', async () => {
    const response = await emailMsOutlookService.getSubjectOutlook('Je orderbevestiging');
    expect(response).to.not.be.null;
  });

  it('get error when search query is empty', async () => {
    await emailMsOutlookService.getSubjectOutlook('').catch((error) => {
      expect(error.toString()).to.be.eq('Error: Error encountered for get microsoft outlook email response: TypeError: Cannot read property \'subject\' of undefined');
    });
  });

  it('get error code 400 when search query with special characters', async () => {
    await emailMsOutlookService.getSubjectOutlook('#$%%^').catch((error) => {
      expect(error.toString()).to.be.eq('Error: Error encountered for get microsoft outlook email response: URIError: URI malformed');
    });
  });
});
