/* eslint-disable no-console */
import { expect } from 'chai';
import fs from 'fs';
import 'mocha';
import { SetUpTestlogger } from '../../../src/core/logger/test.logger';
import TranslationService from '../../../src/core/services/translation-lokalise.service';

describe('Translation Lokalise Service Tests', () => {
  let translationService: TranslationService;

  before(async () => {
    await fs.promises.mkdir('./output/test', { recursive: true });
    SetUpTestlogger('./output/test/test.log', 'info');
    translationService = new TranslationService();
  });

  it('can get proper response body', async () => {
    const response = await translationService.getTranslation('Email', 'es_es');
    expect(response).to.not.be.null;
  });

  it('get error when translation key does not exist', async () => {
    await translationService.getTranslation('Bogdan_NO_SUCH_KEY', 'it_it').catch((error) => {
      expect(error.toString()).to.be.eq('Error: Cannot get translation key for key name Bogdan_NO_SUCH_KEY');
    });
  });

  it('get error when translation key is empty', async () => {
    await translationService.getTranslation('', 'es_es').catch((error) => {
      expect(error.toString()).to.be.eq('Error: The key name cannot be null!');
    });
  });

  it('get error code 404 when translation does not exist', async () => {
    await translationService.getTranslation('UnitTestKeyWithError', 'ro_ro').catch((error) => {
      expect(error.toString()).to.be.eq('Error: Error encountered for GET translation: HTTPError: Response code 404 (Not Found)');
    });
  });
});
