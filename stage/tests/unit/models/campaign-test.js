import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';
import { get } from '@ember/object';

module('Unit | Model | Campaign', function(hooks) {
  setupTest(hooks);

  test('should belong to a user', function(assert) {
    const Campaign = this.owner.lookup('service:store').modelFor('campaign');
    const relationship = get(Campaign, 'relationshipsByName').get('user');

    assert.equal(relationship.key, 'user', 'has relationship with user');
    assert.equal(relationship.kind, 'belongsTo', 'kind of relationship is belongsTo');
  });
});
