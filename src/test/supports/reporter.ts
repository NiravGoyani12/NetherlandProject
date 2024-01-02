import { CucumberJSAllureFormatter } from '../../core/allure/CucumberJSAllureReporter';

export default class Reporter extends CucumberJSAllureFormatter {
  constructor(options) {
    super(
      options,
      {
        labels: {
          issue: [/@issue:(.*)/],
          epic: [/@feature:(.*)/],
          tms: [/@tms:(.*)/],
        },
      },
    );
  }
}
