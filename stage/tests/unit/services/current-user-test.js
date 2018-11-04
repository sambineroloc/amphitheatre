import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';
import { authenticateNewUser } from 'stage/tests/helpers/sessions/sign-in';

module('Unit | Service | CurrentUser', function(hooks) {
  setupTest(hooks);

  test('should create a new map if one isnt cached for location', async function (assert) {
    let stubCurrentUserService = {
      async load() {
        let user = authenticateNewUser();
        this.set('user', user);
        return user;
      }
    }
    let currentUserService = this.owner.factoryFor('service:current-user').create({
      service: stubCurrentUserService
    });
    let user = await currentUserService.load();
    assert.equal(this.get('user'), user)
  });
})
