import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class MandLPopUp extends Page {
  public readonly MembershipLogo = () => this.derived({
    Desktop: '//*[@data-testid="membership-loyalty-modal-logo"] | //div[@data-testid="Modal-component-ml-logo"]',
  });

  public readonly BenefitsTitle = () => this.derived({
    Desktop: '//h5[@data-testid="modal-heading"] | //h3[contains(@class, "membership_popup_title")]',
  });

  public readonly BenefitsInfo = () => this.derived({
    Desktop: '//div[@data-testid="modal-content"]//p | //div[@data-testid="Modal-component"]//p[@data-testid="typography-p"]',
  });

  public readonly RegisterButton = () => this.derived({
    Desktop: '//button[@data-testid="register"] | //div[contains(@class, "membership_popup_membership_popup") and @data-testid="Modal-component"]//button[@data-testid="pvh-button"]',
  });

  public readonly CloseButton = () => this.derived({
    Desktop: '//button[@data-testid="modal-close-btn"] | //*[@data-testid="icon-utility-cross-svg"]',
    Mobile: '//button[@data-testid="modal-close-btn"] | (//*[@data-testid="icon-utility-cross-svg"])[2]',
  });
}
