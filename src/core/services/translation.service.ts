/* eslint-disable import/no-dynamic-require */

interface TranslationItem {
  [key: string]: string
}

export interface Translations {
  [langLocalName: string]: TranslationItem;
}

/**
 * This service will be created for each process
 * If the data increased,  we should move this service as a shared server
 */
export default class TranslationService {
  private translations: Translations;

  private translationFilePath = '';

  constructor(translationFilePath?: string) {
    if (translationFilePath) {
      this.translationFilePath = translationFilePath;
    } else if (process.env.Brand) {
      this.translationFilePath = `../../../translation-${process.env.Brand}.json`;
    } else {
      this.translationFilePath = '../../../translation-th.json';
    }
  }

  private loadData() {
    if (!this.translations) {
      this.translations = require(this.translationFilePath);
    }
  }

  public get(langLocalName: string, key: string) {
    langLocalName = langLocalName.trim();
    key = key.trim();
    this.loadData();
    if (!this.translations[langLocalName] || !this.translations[langLocalName][key]) {
      throw new Error(`Cannot get translation by langLocalName ${langLocalName} with key ${key}`);
    }
    return this.translations[langLocalName][key];
  }
}
