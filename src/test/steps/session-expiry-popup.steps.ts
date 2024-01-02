import { When } from '@pvhqa/cucumber';
import * as SessionExpiryPopUp from '../helper/session-expiry-popup.helper';

When(/In session expiry pop up i sign in with email (.*) and password (.*) and set rememberme to (.*)/, async (email: string, password: string, rememberMe: boolean) => {
  await SessionExpiryPopUp.SessionExpirySignInWithUserAndPassword(email, password, rememberMe);
});
