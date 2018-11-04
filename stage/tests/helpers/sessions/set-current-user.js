import Service from '@ember/service';

export async function setCurrentUser(application) {
  let StubCurrentUserService = Service.extend({
    load() {
      return server.schema.users.all()[0];
    }
  });

  application.owner.register('service:current-user', StubCurrentUserService);
  return server.create('user');
}
