import mysql from 'mysql';
import dotenv from 'dotenv';

dotenv.config();

const connectDatabase = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME,
});

connectDatabase.connect(function (err) {
    if (err) {
        throw err;
    }

    console.log(`Connected to database: ${process.env.DB_NAME}`);
});

const queryDatabase = async (connect, sql, params) =>
    new Promise((resolve, reject) => {
        const handleFunction = (err, result) => {
            if (err) {
                reject(err);
                return;
            }
            resolve(result);
        };
        connect.query(sql, params, handleFunction);
    });

export { connectDatabase, queryDatabase };
