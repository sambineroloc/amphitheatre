import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  currentUser: service('current-user'),

  actions: {
    async createCampaign() {

    }
  }
});
