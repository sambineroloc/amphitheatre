import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('campaigns');
  this.route('campaign', { path: '/campaigns/:id' });
  this.route('login');
});

export default Router;
