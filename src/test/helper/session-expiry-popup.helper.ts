/* eslint-disable import/prefer-default-export */
import services from '../../core/services';
import {
  exist$,
} from '../general';

// eslint-disable-next-line max-len
export const SessionExpirySignInWithUserAndPassword = async (email: string, password: string, rememberme?: boolean) => {
  email = services.account.parse(email);
  password = services.account.parse(password);

  await Promise.all([
    exist$('Experience.SessionExpiryPopUp.EmailField').then((ele) => ele.safeType(email)),
    exist$('Experience.SessionExpiryPopUp.PasswordField').then((ele) => ele.safeType(password)),
  ]);

  if (rememberme) {
    await exist$('Experience.SessionExpiryPopUp.RememberMeCheckBox').then((ele) => ele.setCheckbox(true));
  }
  await exist$('Experience.SessionExpiryPopUp.SignInButton').then((ele) => ele.jsClick());
};
