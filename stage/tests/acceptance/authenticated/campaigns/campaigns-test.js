import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit } from '@ember/test-helpers';
import { newSession } from 'stage/tests/helpers/sessions/sign-in';

let campaign;

module('Acceptance | Authenticated | Campaigns', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);

  hooks.beforeEach(async function() {
    await newSession(this);
    campaign = server.create('campaign');
  });

  test('all campaigns are present', async function(assert) {
    await visit('/');

    assert.dom('[data-test-campaigns="header"]').hasText('Your Campaigns');
    assert.dom('[data-test-campaigns="campaign-title"]').hasText(campaign.title);
  });
});
