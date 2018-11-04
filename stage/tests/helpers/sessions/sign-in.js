import Service from '@ember/service';
import { authenticateSession } from 'ember-simple-auth/test-support';

export async function newSession(application) {
  let user = _setCurrentUser(application)
  _authenticateUser(user)
}

export function _setCurrentUser(application) {
  let StubCurrentUserService = Service.extend({
    load() {
      return server.schema.users.all()[0];
    }
  });

  application.owner.register('service:current-user', StubCurrentUserService);
  return server.create('user');
}

export async function _authenticateUser(user) {
  await authenticateSession({
    identification: user.email,
    password: user.password
  });
}
