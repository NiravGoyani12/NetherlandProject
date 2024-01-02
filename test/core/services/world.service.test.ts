import { expect } from 'chai';
import services from '../../../src/core/services';

describe('World service', () => {
  before(() => {
    services.world.init({ testUniqueName: 'World Service Unit Test', store: new Map<string, any>() });
  });

  it('can parse existing key', () => {
    services.world.store('#key1', 'example1');
    expect(services.world.parse('#key1')).to.equal('example1');
  });

  it('can only parse valid keys', () => {
    expect(services.world.parse('key1')).to.equal('key1');
  });

  it('returns original key for not existing value', () => {
    expect(services.world.parse('#key2')).to.equal('#key2');
  });

  it('can update value of existing key', () => {
    services.world.store('#key3', 'example3');
    services.world.store('#key3', 'example4');
    expect(services.world.parse('#key3')).to.equal('example4');
  });
});
