import { World } from '@pvhqa/cucumber';

declare module '@pvhqa/cucumber' {
  interface World {
    testUniqueName: string,
    store: Map<string, any>
  }
}
