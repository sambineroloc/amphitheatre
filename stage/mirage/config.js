export default function() {
  this.get('/campaigns');
  this.get('/me', function(db) {
    return db.users.all()[0];
  });
  this.post('/oauth/token', function(db) {
    return db.users.all()[0];
  })
}
