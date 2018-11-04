import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';
import { get } from '@ember/object';

module('Unit | Model | User', function(hooks) {
  setupTest(hooks);

  test('should own a campaign', function(assert) {
    const User = this.owner.lookup('service:store').modelFor('user');
    const relationship = get(User, 'relationshipsByName').get('campaigns');

    assert.equal(relationship.key, 'campaigns', 'has relationship with campaigns');
    assert.equal(relationship.kind, 'hasMany', 'kind of relationship is hasMany');
  });
});
