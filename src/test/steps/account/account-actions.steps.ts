import { When } from '@pvhqa/cucumber';
import * as UnifiedActions from '../../helper/login-logout.helper';
import { getPageType } from '../../helper/utils.helper';

When(/I open sign in panel/, async () => {
  await UnifiedActions.OpenUnifiedSignInPanel();
});

When(/I sign in with email (.*) and password (.*)/, async (email: string, password: string) => {
  const page = await getPageType();

  if (page === 'tommy together - signinpage') {
    await UnifiedActions.SignInWithUserAndPasswordWithoutPanel(email, password);
  } else {
    await UnifiedActions.SignInWithUserAndPassword(email, password);
  }
});

When(/I check on remember me checkbox/, async () => {
  await UnifiedActions.ClickRememberMeCheckBox();
});

When(/I open sign up panel/, async () => {
  await UnifiedActions.OpenUnifiedSignUpPanel();
});

When(/I sign up with email (.*) and password (.*)/, async (email: string, password: string) => {
  const page = await getPageType();

  if (page === 'tommy together - registerpage') {
    await UnifiedActions.SignUpWithUserAndPasswordWithoutPanel(email, password);
  } else {
    await UnifiedActions.SignUpWithUserAndPassword(email, password);
  }
});

When(/I sign up with email (.*) only/, async (email: string) => {
  await UnifiedActions.SignUpWithEmailTH(email);
});

When(/I(?: can)? sign out/, async () => {
  await UnifiedActions.UnifiedSignOut();
});
