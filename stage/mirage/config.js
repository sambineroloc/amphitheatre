export default function() {
  this.urlPrefix = 'http://localhost:3000';

  this.get('/campaigns', (schema) => {
    return schema.campaigns.all();
  });
}
