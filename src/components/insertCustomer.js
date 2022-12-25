import axios from 'axios';
import { connectDatabase } from '../models/index.js';

const API_USER = 'https://randomuser.me/api/';

const insertCustomer = ({ numbersOfRecords = 10 }) => {
    connectDatabase.connect(async function (err) {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const promises = [];
        const users = [];

        for (let i = 1; i <= numbersOfRecords; i++) {
            promises.push(
                await axios
                    .get(API_USER, {
                        headers: { 'Accept-Encoding': 'gzip,deflate,compress' },
                    })
                    .then((response) => {
                        console.log(`-------${i}/${numbersOfRecords}---------`);

                        const info = response.data.results[0];
                        const fname = info.name.first;
                        const lname = info.name.last;
                        const gender =
                            info.gender.toLowerCase() === 'female' ? 0 : 1;
                        const areacode = info.location.postcode.toString();
                        const phone = info.phone;
                        const balance = Number(
                            Number(Math.random() * 1000).toFixed(2),
                        );
                        const initial = characters.charAt(
                            Math.floor(Math.random() * characters.length),
                        );
                        const obj = {
                            fname,
                            lname,
                            gender,
                            areacode,
                            phone,
                            balance,
                            initial,
                        };

                        const values = [
                            obj.lname,
                            obj.fname,
                            obj.gender,
                            obj.areacode,
                            obj.phone,
                            obj.balance,
                            obj.initial,
                        ];

                        users.push(values);
                    }),
            );
        }

        Promise.all(promises).then(() => {
            let sql;

            sql =
                'INSERT INTO CUSTOMER(cus_lname, cus_fname, cus_gender, cus_areacode, cus_phone, cus_balance, cus_initial) VALUES ?';

            connectDatabase.query(sql, [users], function (err, result) {
                if (err) throw err;
                console.log(
                    `Inserted into CUSTOMER - database: ${process.env.DB_NAME}`,
                );
                console.log(
                    'Number of records inserted: ' + result.affectedRows,
                );
            });
        });
    });
};

export default insertCustomer;
