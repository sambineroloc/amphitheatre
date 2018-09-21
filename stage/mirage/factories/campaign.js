import { Factory } from 'ember-cli-mirage';

export default Factory.extend({
  title(i) { return `Campaign title ${i}`; },
  description(i) { return `Campaign description ${i}` }
});
