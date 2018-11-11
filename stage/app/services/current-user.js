import Service from '@ember/service';
import { inject as service } from '@ember/service';
import RSVP from 'rsvp';

export default Service.extend({
  session: service('session'),
  store: service(),

  load() {
    let store = this.get('store');
    let session = this.get('session');
    let access_token = session.data.authenticated.access_token;
    if (session.isAuthenticated) {
      return store.queryRecord('session', { me: true, access_token }).then((user) => {
        this.set('user', user);
      });
    } else {
      return RSVP.resolve();
    }
  }
});
