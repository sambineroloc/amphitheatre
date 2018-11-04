import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit, currentURL, fillIn, click } from '@ember/test-helpers';
import { authenticateSession } from 'ember-simple-auth/test-support';

module('Acceptance | Users | New', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);

  hooks.beforeEach(async function() {
    await visit('/users/sign_up');
  })

  test('can navigate to sign up form', async function(assert) {
    assert.equal(currentURL(), '/users/sign_up')
  });

  test('submitting form allows user to sign up', async function(assert) {
    let user = server.build('user');
    this.set('model', user);
    await fillIn('[data-test-form="username"]', 'guybrush');
    await fillIn('[data-test-form="email"]', 'guy@threepwood.com');
    await fillIn('[data-test-form="password"]', 'sosecure');
    await fillIn('[data-test-form="password-confirmation"]', 'sosecure');
    await authenticateSession({
      identification: user.email,
      password: user.password
    });
    await click('[data-test-form="submit"]');

    assert.equal(currentURL(), '/campaigns')
  })
});
