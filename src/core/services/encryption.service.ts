/* eslint-disable import/no-dynamic-require */
import * as crypto from 'crypto';

export default class Encryption {
  public bufferEncoding: string;

  public KEY: string;

  public IV: string;

  constructor() {
    this.KEY = 'QA0QA1QA2QA3QA4QA5QA6QA7QA8QA9!$';
    this.IV = 'ECOMAUTOMATIONQA';
  }

  public passDecrypt(encryptedData: string, IV: string, KEY: string) {
    const encryptedText = Buffer.from(encryptedData, 'base64');
    const decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(KEY), IV);
    let decrypted = decipher.update(encryptedText);
    decrypted = Buffer.concat([decrypted, decipher.final()]);
    return decrypted.toString();
  }
}
