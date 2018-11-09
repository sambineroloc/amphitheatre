import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { visit, currentURL, fillIn } from '@ember/test-helpers';

module('Acceptance | Users | New', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);

  hooks.beforeEach(async function() {
    await visit('/users/sign_up');
  })

  test('can navigate to sign up form', async function(assert) {
    assert.equal(currentURL(), '/users/sign_up')
  });

  test('form data is applied to the fields', async function(assert) {
    let user = server.build('user');
    this.set('model', user);
    let formData = {
      username: 'guybrush',
      email: 'guy@threepwood.com',
      password: 'sosecure'
    }
    await fillIn('[data-test-form="username"] > input', formData.username);
    await fillIn('[data-test-form="email"] > input', formData.email);
    await fillIn('[data-test-form="password"] > input', formData.password);
    await fillIn('[data-test-form="password-confirmation"] > input', formData.password);

    assert.dom('[data-test-form="username"] > input').hasValue(formData.username);
    assert.dom('[data-test-form="email"] > input').hasValue(formData.email);
    assert.dom('[data-test-form="password"] > input').hasValue(formData.password);
    assert.dom('[data-test-form="password-confirmation"] > input').hasValue(formData.password);
  })
});
