import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';
import { authenticateSession } from 'ember-simple-auth/test-support';

module('Integration | Component | nav-bar', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders the app title and login button when unauthenticated', async function(assert) {
    await render(hbs`{{nav-bar}}`);

    assert.dom('[data-test-navbar="title"]').hasText('Tabletop Amphitheatre');
    assert.dom('[data-test-navbar="login"]').hasText('Login')
  });

  test('it renders the app title, logout button, and home button when authenticated', async function(assert) {
    await authenticateSession({ username: 'zberto@gmail.com', password: 'password' });
    await render(hbs`{{nav-bar}}`);

    assert.dom('[data-test-navbar="title"]').hasText('Tabletop Amphitheatre');
    assert.dom('[data-test-navbar="logout"]').hasText('Logout');
    assert.dom('[data-test-navbar="home"]').hasText('Home');
  });
});
