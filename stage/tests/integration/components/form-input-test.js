import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | form-input', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function(assert) {
    await render(hbs`{{form-input label='Username' field='username' type='input' placeholder='Enter your username' value=model.username}}`);
    assert.dom('[data-test-form="username"] > input').exists();
  });
});
