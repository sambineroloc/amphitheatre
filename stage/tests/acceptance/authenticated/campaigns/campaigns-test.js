import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit } from '@ember/test-helpers';
import { authenticateSession } from 'ember-simple-auth/test-support';
import { setCurrentUser } from 'stage/tests/helpers/sessions/set-current-user';

let campaign, user;

module('Acceptance | Authenticated | Campaigns', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);

  hooks.beforeEach(async function() {
    user = setCurrentUser(this);
    await authenticateSession({
      identification: user.email,
      password: user.password
    });
    campaign = server.create('campaign');
  });

  test('all campaigns are present', async function(assert) {
    await visit('/campaigns');

    assert.dom('[data-test-campaigns="header"]').hasText('Your Campaigns');
    assert.dom('[data-test-campaigns="campaign-title"]').hasText(campaign.title);
  });
});
