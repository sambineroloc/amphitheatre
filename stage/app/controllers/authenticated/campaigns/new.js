import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  session: service(),

  actions: {
    async createCampaign() {
      this.get('model').save().then(() => {
        this.transitionToRoute('/');
      });
    }
  }
});
