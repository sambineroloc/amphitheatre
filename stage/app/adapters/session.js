import DS from 'ember-data';

export default DS.JSONAPIAdapter.extend({
  urlForQueryRecord(query) {
    if (query.me) {
      delete query.me;
      return '/me';
    }

    return this._super(...arguments);
  }
});
