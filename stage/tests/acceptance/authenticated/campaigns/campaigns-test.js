import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit } from '@ember/test-helpers';
import Service from '@ember/service';
import { authenticateSession } from 'ember-simple-auth/test-support';

let StubCurrentUserService = Service.extend({
  load() {
    return server.schema.users.all()[0];
  }
});

module('Acceptance | Authenticated | Campaigns', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);

  hooks.beforeEach(async function() {
    this.owner.register('service:current-user', StubCurrentUserService);
    let user = server.create('user');
    await authenticateSession({
      identification: user.email,
      password: user.password
    });
  });

  test('all campaigns are present', async function(assert) {
    let campaign = server.create('campaign');
    await visit('/campaigns');

    assert.dom('[data-test-campaigns="header"]').hasText('Your Campaigns');
    assert.dom('[data-test-campaigns="campaign-title"]').hasText(campaign.title);
  });
});
