import { wcsSignUp, wcsSignIn } from './authentication';
import { wcsAddAddress, wcsUpdateUserInfo } from './account';


const wcs = {
  signUp: wcsSignUp,
  signIn: wcsSignIn,
  addAddress: wcsAddAddress,
  updateUserInfo: wcsUpdateUserInfo,
};
export default wcs;
