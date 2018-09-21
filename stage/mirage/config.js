export default function() {
  this.urlPrefix = 'http://localhost:3000';

  this.get('/campaigns', () => {
    return {
      campaigns: [
        { title: 'Wheel of Time', description: 'Damn good' },
        { title: 'Snowcrash', description: 'Also damn good' },
        { title: 'Neuromancer', description: 'Wowee' }
      ]
    }
  });
}
