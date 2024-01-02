/* eslint-disable import/prefer-default-export */

export async function setCheckbox(this: WebdriverIO.Element, isChecked: boolean) {
  if (!((await this.isSelected()) === isChecked)) {
    await this.jsClick();
  }
}
