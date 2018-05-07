const http = require('http');
const app = require('./app');

/*
  app.listen(3000, () => {
    console.log('Im running port 3000');
  })
*/

http.createServer(app).listen(3000);

console.log('Im running port 3000');
