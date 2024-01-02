/* eslint-disable import/prefer-default-export */

export async function smoothScrollToElement(this: WebdriverIO.Element) {
  await browser.execute(`
  function sleep(ms) {
       return new Promise(resolve => setTimeout(resolve, ms));}
  async function scroll(scrollY, scrollHeight, scrollIteration) {
      while ((scrollY - scrollHeight) > scrollIteration) 
      {  
          window.scrollBy(0, scrollIteration);
          await sleep(100);
          scrollHeight = window.pageYOffset;
      }
      remainingScroll = scrollY - scrollHeight;
      window.scrollBy(0, remainingScroll);}
  rect = arguments[0].getBoundingClientRect();
  scrollHeight = window.pageYOffset;
  scrollY = rect.y - $(window).height() + rect.height + scrollHeight;
  scrollIteration = 100;
  return scroll(scrollY, scrollHeight, scrollIteration);`, this);
}
