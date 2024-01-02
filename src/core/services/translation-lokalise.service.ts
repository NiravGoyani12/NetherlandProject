/* eslint-disable consistent-return */
import got from 'got';
import { Singleton } from 'typescript-ioc';
import data from '../json/translation-keys.json';

@Singleton
export default class TranslationLokaliseService {
  private translationKeys;

  constructor() {
    this.translationKeys = data;
  }

  private getKey(keyName: string) {
    if (!keyName) {
      throw new Error('The key name cannot be null!');
    }

    if (!this.translationKeys[keyName]) {
      throw new Error(`Cannot get translation key for key name ${keyName}`);
    }

    return this.translationKeys[keyName];
  }

  public async getTranslation(keyName: string, language: string) {
    const correctUrl = 'https://api.lokalise.com/api2/projects/2856408963049baf872d50.49916427:master';
    const key = this.getKey(keyName);
    try {
      const client = got.extend({
        prefixUrl: correctUrl,
        headers: {
          Accept: 'application/json',
          'X-Api-Token': '550cdb5b5d3f5397c8ee5bf6d0f64209460170e4',
        },
      });
      const resp = await client.get<any>(`/keys/${key}`);
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw new Error(`Get translation key request failed with status code ${resp.statusCode}`);
      }
      if (resp.body === null || !resp.body) {
        throw new Error('Get translation key request failed due to null response body received');
      }
      const translations = JSON.parse(resp.body);

      // eslint-disable-next-line default-case
      switch (language) {
        case 'ru_ru':
          return translations.key.translations[0].translation;
        case 'en_gb':
          return translations.key.translations[1].translation;
        case 'de_de':
          return translations.key.translations[2].translation;
        case 'fr_fr':
          return translations.key.translations[3].translation;
        case 'it_it':
          return translations.key.translations[4].translation;
        case 'nl_nl':
          return translations.key.translations[5].translation;
        case 'pl_pl':
          return translations.key.translations[6].translation;
        case 'es_es':
          return translations.key.translations[7].translation;
      }
    } catch (e) {
      throw new Error(`Error encountered for Get translation key: ${e}`);
    }
  }
}
