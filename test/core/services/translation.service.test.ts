import 'mocha';
import { expect } from 'chai';
import path from 'path';
import TranslationService from '../../../src/core/services/translation.service';

describe('Translation service', () => {
  let translationService:TranslationService;
  before(() => {
    translationService = new TranslationService(path.join(__dirname, '..', '..', 'utils', 'translation-mock.json'));
  });

  it('can get data success', () => {
    const v1 = translationService.get('fr_fr', 'test1');
    expect(v1).to.equal('fr1');
  });

  it('raise error when langLocalName is not exist', () => {
    expect(() => translationService.get('no_no', 'test1')).to.throw('Cannot get translation by langLocalName no_no with key test1');
  });

  it('raise error when key is not exist', () => {
    expect(() => translationService.get('fr_fr', 'no')).to.throw('Cannot get translation by langLocalName fr_fr with key no');
  });
});
