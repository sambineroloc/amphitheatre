import { module, skip } from 'qunit';
import { setupTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit } from '@ember/test-helpers';

module('Unit | Route | campaigns', function(hooks) {
  setupTest(hooks);
  setupMirage(hooks);

  skip('all campaigns are present', async function(assert) {
    let campaign = server.create('campaign');
    await visit('/campaigns');

    assert.dom('[data-test-campaigns="header"]').hasText('Your Campaigns');
    assert.dom('[data-test-campaigns="campaign-title"]').hasText(campaign.title);
  });
});
