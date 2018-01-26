const express = require('express');
const anyDB = require('any-db');
const Promise = require('bluebird');

const server = express();

const dbDriver = process.env.DB_DRIVER || 'mysql';
const dbHost = process.env.DB_HOST || 'localhost';
const dbUser = process.env.DB_USER || 'app_user';
const dbPassword = process.env.DB_PASSWORD || 'app_password';
const dbName = process.env.DB_NAME || 'app_database';
const serverPort = process.env.PORT || 3000;

const connectionString = `${dbDriver}://${dbUser}:${dbPassword}@${dbHost}/${dbName}`;

let dbInitialized = false;

const createConnection = () => {
  return new Promise((resolve, reject) => {
    anyDB.createConnection(connectionString, (err, conn) => {
      if (err) {
        reject(err);
      } else {
        resolve(conn);
      }
    });
  });
};

const query = (queryString) => {
  return createConnection().then((conn) => {
    return new Promise((resolve, reject) => {
      conn.query(queryString, (err, result) => {
        if (err) {
          reject(err);
        } else {
          resolve(result);
        }
      });
    });
  });
};

const initDb = () => {
  const initQueries = [
    "create table if not exists app_table (id int primary key, app_column text);",
    "insert into app_table (id, app_column) values (1, 'I am a MySQL DB') ON DUPLICATE KEY UPDATE app_column='I am a MySQL DB';",
    "insert into app_table (id, app_column) values (2, 'Whoohooo!')  ON DUPLICATE KEY UPDATE app_column='Whoohooo!';"
  ];
  return Promise.mapSeries(initQueries, query);
};

server.get("*", (req, res) => {
  if (dbInitialized) {
    query('select * from app_table')
      .then((result) => res.json({rows: result.rows}).end())
      .catch((err) => {
        console.error(err);
        res.send(err.message).end;
      });
  } else {
    initDb()
    .then(()=>{dbInitialized = true})
    .catch((err)=>{
      console.error(err);
      dbInitialized = false;
    })
  res.send('Waiting for DB...').end();
  }
});
server.listen(serverPort, () => {
  console.log(`Server listening at https://localhost:${serverPort}`);
});
