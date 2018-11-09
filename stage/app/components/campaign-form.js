import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  session: service(),
  currentUser: service(),
  campaign: null,

  didInsertElement() {
  },

  _resetCampaign() {
    this.set('campaign', this.get('store').createRecord('campaign', {
      user: this.get('referrer'),
      key: this.get('key')
    }));
  },

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
