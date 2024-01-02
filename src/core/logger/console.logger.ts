/* eslint-disable no-console */
export default function consoleLog(text: string) {
  console.log(`[${new Date().toISOString()}] ${text}`);
}
