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

    }
  }
});
