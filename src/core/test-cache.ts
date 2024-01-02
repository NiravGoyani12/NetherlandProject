export default class TestCache {
  constructor() {
    this.cache = new Map();
  }

  public saveToCache(key: string, value: any) {
    if (typeof value === 'object') {
      this.cache.set(key, { ...value });
    } else {
      this.cache.set(key, value);
    }
  }

  public getFromCache<T>(key: string): T {
    return this.cache.get(key) as T;
  }

  private cache : Map<string, any>;
}
