import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  session: service(),
  currentUser: service('current-user'),

  actions: {
    async createCampaign() {
      // let user = this.get('model');
      // user.save().then(() => {
      //   let identification = user.get('email');
      //   let password = user.get('password');
      //   this.get('session').authenticate('authenticator:oauth2', identification, password).catch((reason) => {
      //     this.set('errorMessage', reason.error || reason);
      //   });
      // });
    }
  }
});
