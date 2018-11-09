import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  session: service(),

  actions: {
    async createUser() {
      let user = this.get('model');
      user.save().then(() => {
        let identification = user.get('email');
        let password = user.get('password');
        this.get('session').authenticate('authenticator:oauth2', identification, password).catch((reason) => {
          this.set('errorMessage', reason.error || reason);
        });
      });
      this.transitionToRoute('/');
    }
  }
});
