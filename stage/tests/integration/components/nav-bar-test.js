import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';
import { authenticateSession } from 'ember-simple-auth/test-support';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { newSession, setCurrentUserForComponent } from 'stage/tests/helpers/sessions/sign-in';

let user;

module('Integration | Component | nav-bar', function(hooks) {
  setupRenderingTest(hooks);
  setupMirage(hooks);

  test('it renders the app title and login button when unauthenticated', async function(assert) {
    await render(hbs`{{nav-bar}}`);

    assert.dom('[data-test-navbar="title"]').hasText('Tabletop Amphitheatre');
    assert.dom('[data-test-navbar="login"]').hasText('login');
  });

  test('it renders the app title, logout button, and home button when authenticated', async function(assert) {
    user = server.create('user');
    await authenticateSession({ username: user.email, password: user.password });
    await render(hbs`{{nav-bar}}`);

    assert.dom('[data-test-navbar="title"]').hasText('Tabletop Amphitheatre');
    assert.dom('[data-test-navbar="logout"]').hasText('Logout');
    assert.dom('[data-test-navbar="home"]').hasText('Home');
  });

  test('nav-bar displays username when there is a current user', async function(assert) {
    user = await newSession(this);
    await setCurrentUserForComponent(this, user);
    await render(hbs`{{nav-bar}}`);

    assert.dom('[data-test-navbar="username"]').hasText(`Logged in as ${user.username}`);
  });
});
