import Serializer from 'ember-data/serializer';

export default Serializer.extend({
  include: 'campaign'
});
