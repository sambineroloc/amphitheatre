export default function() {
  this.get('/campaigns');
  this.get('/me', function(db) {
    return db.users.all()[0];
  });
  this.get('/users/:id', function(db) {
    let user = db.users.all().models[0];
    return user;
  });
  this.post('/users', function(db, request) {
    var attrs = JSON.parse(request.requestBody).data.attributes;
    return db.users.create(attrs);
  });

  this.post('http://localhost:3000/oauth/token', function() {
    return {
      'access_token': 'acbde',
      'token_type': 'Bearer',
      'expires_in': 7200,
      'created_at': 68354867865}
  });
}
