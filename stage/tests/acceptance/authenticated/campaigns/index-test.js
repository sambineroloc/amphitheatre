import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit } from '@ember/test-helpers';
import { newSession } from 'stage/tests/helpers/sessions/sign-in';

let campaign, user, currentUser;

module('Acceptance | Campaigns | Index', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);

  hooks.beforeEach(async function() {
    await newSession(this);
    currentUser = this.owner.factoryFor('service:current-user').create();
    user = server.schema.users.all().models[0];
    this.set('currentUser', currentUser);
    campaign = server.create('campaign', { user: user });
  });

  test('all campaigns are present', async function(assert) {
    await visit('/');

    assert.dom('[data-test-campaigns="header"]').hasText('Your Campaigns');
    assert.dom('[data-test-campaigns="campaign-title"]').hasText(campaign.title);
    assert.dom('[data-test-campaigns="new"]').hasText('Create New Campaign?');
  });
});
