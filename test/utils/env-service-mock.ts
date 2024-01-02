/* eslint-disable max-classes-per-file */
import EnvService from '../../src/core/services/env.service';

export class UatFakeEnvService extends EnvService {
  get Site() { return 'b2ceuup'; }
}

export class SystestFakeEnvService extends EnvService {
  get Site() { return 'systestp'; }
}

export class ProdStagFakeEnvService extends EnvService {
  get Site() { return 'prod-stag'; }
}
