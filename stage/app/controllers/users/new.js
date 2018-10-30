import Controller from '@ember/controller';

export default Controller.extend({
  actions: {
    async createUser() {
      let user = this.get('model');
      user.save();
    }
  }
});
