import Service from '@ember/service';
import { authenticateSession } from 'ember-simple-auth/test-support';

export async function newSession(application) {
  let user = setCurrentUser(application)
  authenticateUser(user)
}

export async function setCurrentUserForComponent(component, user) {
  component.currentUserService = component.owner.lookup('service:current-user');
  component.currentUserService.user = { username: user.username };
}

export function setCurrentUser(application) {
  let StubCurrentUserService = Service.extend({
    load() {
      return server.schema.users.all()[0];
    }
  });

  application.owner.register('service:current-user', StubCurrentUserService);
  return server.create('user');
}

export async function authenticateUser(user) {
  await authenticateSession({
    identification: user.email,
    password: user.password
  });
}

export async function authenticateNewUser() {
  let user = server.create('user');
  await authenticateSession({
    identification: user.email,
    password: user.password
  });
  return user;
}
