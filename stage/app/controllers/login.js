import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  session: service(),

  actions: {
    async authenticate() {
      let { identification, password } = this.getProperties('identification', 'password');
      this.get('session').authenticate('authenticator:oauth2', identification, password).then((response) => {
        this.session.data.set('user_id', response.user_id);
      }).catch((reason) => {
        this.set('errorMessage', reason.error || reason);
      });
      this.transitionToRoute('/');
    }
  }
});
