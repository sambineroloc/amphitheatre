import { Factory } from 'ember-cli-mirage';

export default Factory.extend({
  username(i) { return `superduder${i}`; },
  email(i) { return `superduder${i}@email.com` },
  password(i) { return `difhblsdkghlwfdsl${i}` }
});
