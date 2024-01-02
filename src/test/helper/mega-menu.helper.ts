/* eslint-disable import/prefer-default-export */
import services from '../../core/services';
import {
  maybeDisplayed$, exist$,
} from '../general';
import { sleep } from './utils.helper';

export const OpenUnifiedMegaMenuOnMobile = async () => {
  if (services.env.IsMobile) {
    const megaMenuDisplayed = await maybeDisplayed$('Experience.Header.MegaMenuSecondLevelItems', 1500);
    if (!megaMenuDisplayed) {
      await (await maybeDisplayed$('Experience.Header.HamburgerMenuOpen')).jsClick();
      await sleep(1500);
    }
  }
};

export const CloseUnifiedMegaMenuMobile = async () => {
  if (services.env.IsMobile) {
    const megaMenuOpened = await (
      await maybeDisplayed$('Experience.Header.MegaMenuSecondLevelItems', 300));
    if (megaMenuOpened) {
      await (await exist$('Experience.Header.HamburgerMenuClose')).jsClick();
      await sleep(500);
    }
  }
};
