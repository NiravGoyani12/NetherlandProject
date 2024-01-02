import { Singleton } from 'typescript-ioc';
import { Page } from '../page';


@Singleton
export default class RobotsTxt extends Page {
  public readonly RobotsCommands = () => this.derived({
    Desktop: '//body/pre',
  });
}
