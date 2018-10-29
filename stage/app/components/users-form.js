import Component from '@ember/component';
// import { inject as service } from '@ember/service';

export default Component.extend({
  user: null,

  didInsertElement() {
    this._resetUser();
  },

  _resetUser() {
    this.set('user', this.get('store').createRecord('user'));
  },

  actions: {
    async createUser() {
      let user = this.get('user');
      user.save().then(() => {}).catch(() => {});
    }
  }
});
