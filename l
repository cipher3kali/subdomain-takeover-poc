{
  "name": "fa4ws",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "start": "node ./bin/www",
    "lint": "eslint ./src --fix",
    "test": "gulp test",
    "coverage": "gulp coverage"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "bcryptjs": "^2.4.3",
    "body-parser": "^1.18.3",
    "cors": "^2.8.5",
    "debug": "~2.6.9",
    "express": "^4.16.4",
    "jasmine": "^3.4.0",
    "jsonwebtoken": "^8.5.1",
    "mongoose": "^5.4.17",
    "nodemon": "^2.0.1",
    "npm-install-all": "^1.1.21",
    "request": "^2.88.0",
    "requirejs": "^2.3.6"
  },
  "devDependencies": {
    "eslint": "^6.0.1",
    "gulp": "^4.0.2",
    "gulp-eslint": "^6.0.0",
    "gulp-exit": "0.0.2",
    "gulp-istanbul": "^1.1.3",
    "gulp-jasmine": "^4.0.0",
    "jasmine-node": "^3.0.0",
    "jasmine-reporters": "^2.3.2"
  }
}
