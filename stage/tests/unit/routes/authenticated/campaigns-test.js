import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit } from '@ember/test-helpers';
import { authenticateSession } from 'ember-simple-auth/test-support';

module('Unit | Route | campaigns', function(hooks) {
  setupTest(hooks);
  setupMirage(hooks);

  test('all campaigns are present', async function(assert) {
    await authenticateSession({ username: 'zberto@gmail.com', password: 'password' });
    let campaign = server.create('campaign');
    await visit('/campaigns');

    assert.dom('[data-test-campaigns="header"]').hasText('Your Campaigns');
    assert.dom('[data-test-campaigns="campaign-title"]').hasText(campaign.title);
  });
});
