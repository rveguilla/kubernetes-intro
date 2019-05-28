const express = require('express');
const mysql = require('promise-mysql');

const serverPort = process.env.PORT || 3000;

const server = express();

const connPool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'app_user',
    password: process.env.DB_PASSWORD || 'app_password',
    database: process.env.DB_NAME || 'app_database'
});

server.get("*",  async (req, res) => {
  try {
      const rows = await connPool.query('select * from app_table');
      res.json({rows}).end()
  } catch (err) {
      console.error(err);
      res.send(err.message).end();
  }
});

server.listen(serverPort, () => {
  console.log(`Server listening at http://localhost:${serverPort}`);
});
