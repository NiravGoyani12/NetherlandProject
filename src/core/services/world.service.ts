import { World } from '@pvhqa/cucumber';

export default class WorldService {
  private world: World = null;

  public init(world: World) {
    this.world = world;
  }

  public parse(text: string): any {
    if (text) {
      if (text.startsWith('#')) {
        const storageValue = this.world.store.get(text);
        if (storageValue !== null && storageValue !== undefined) {
          return storageValue;
        }
      }
    }
    return text;
  }

  public parseByType<T>(text: string): T {
    if (text) {
      if (text.startsWith('#')) {
        return this.world.store.get(text);
      }
    }
    return null;
  }

  public store(key: string, value: any) {
    this.world.store.set(key, value);
  }
}
