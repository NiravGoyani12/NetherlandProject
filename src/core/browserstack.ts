/* eslint-disable no-console */
import browserstack from 'browserstack-local';

export default class BrowserstackService {
  private bsLocalArgs = {
    // eslint-disable-next-line max-len
    key: process.env.BROWSERSTACK_KEY, verbose: true, forceLocal: true, force: true, onlyAutomate: true,
  };

  public bsLocal: any;

  constructor() {
    // creates an instance of Local
    this.bsLocal = new browserstack.Local();
  }

  public startBrowserstack() {
    this.bsLocal.start(this.bsLocalArgs, () => {
      console.log('Started BrowserStackLocal');
    });
  }

  public checkBrowserstackStatus() {
    console.log(this.bsLocal.isRunning());
  }

  public stopBrowserstack() {
    this.bsLocal.stop(() => {
      console.log('Stopped BrowserStackLocal');
    });
  }
}
