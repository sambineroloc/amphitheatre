import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit, fillIn, click } from '@ember/test-helpers';
import Service from '@ember/service';

let StubCurrentUserService = Service.extend({
  load() {
    return server.create('user');
  }
});

module('Acceptance | Authenticated | Campaigns', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);

  hooks.beforeEach(async function() {
    this.application.register('service:current-user', StubCurrentUserService);
    let user = server.create('user');
    await visit('/login');
    await fillIn('[data-test-login="identification"]', user.email);
    await fillIn('[data-test-login="password"]', user.password);
    await click('[data-test-login="submit"]');
  });

  test('all campaigns are present', async function(assert) {
    let campaign = server.create('campaign');
    await visit('/campaigns');

    assert.dom('[data-test-campaigns="header"]').hasText('Your Campaigns');
    assert.dom('[data-test-campaigns="campaign-title"]').hasText(campaign.title);
  });
});
