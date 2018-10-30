import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('login');
  this.route('authenticated', { path: '' }, function() {
    this.route('campaigns');
    this.route('campaign', { path: '/campaigns/:id' });
  });
  this.route('users', { path: '' }, function() {
    this.route('new', { path: 'sign_up' });
  });
});

export default Router;
