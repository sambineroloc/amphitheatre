import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import { inject as service } from '@ember/service';

export default Route.extend(AuthenticatedRouteMixin, {
  currentUser: service('current-user'),

  async model() {
    await this.get('currentUser').load();
    let userId = this.get('currentUser').user.id;
    return this.store.findRecord('user', userId, { include: 'campaigns' });
  }
});
