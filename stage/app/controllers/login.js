import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  session: service(),

  actions: {
    async authenticate() {
      let { email, password } = this.getProperties('email', 'password');

      try {
        await this.get('session').authenticate('authenticator:oauth2', email, password);
      } catch(e) {
        this.set('errorMessage', e.error || e);
      }
    }
  }
});
