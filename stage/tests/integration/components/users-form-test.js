import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | users-form', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function(assert) {
    await render(hbs`{{users-form}}`);

    assert.dom('[data-test-form="username"]').exists();
    assert.dom('[data-test-form="email"]').exists();
    assert.dom('[data-test-form="password"]').exists();
    assert.dom('[data-test-form="password_confirmation"]').exists();
    assert.dom('[data-test-form="submit"]').exists();
  });
});
