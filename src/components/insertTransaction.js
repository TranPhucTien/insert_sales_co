import axios from 'axios';
import { randomDate } from '../constant.js';
import { connectDatabase } from '../models/index.js';

const USER_API = 'http://localhost:5001/api/saleco/allUser';

const insertTransaction = ({ numberOfRecords = 1000 }) => {
    connectDatabase.connect(async function (err) {
        const transList = [];
        const listCustomerCode = [];
        const type = ['charge', 'payment'];

        const response = await axios.get(`${USER_API}`);
        response.data.data.forEach((item) =>
            listCustomerCode.push(item.cus_code),
        );

        for (let i = 1; i <= numberOfRecords; i++) {
            console.log(`----------${i}/${numberOfRecords}------------`);
            const time = randomDate(new Date(2012, 0, 1), new Date());
            const _type = type[Math.floor(Math.random() * 2)];
            const amount = Number((Math.random() * 1000 + 1).toFixed(2));
            const cusCode =
                listCustomerCode[
                    Math.floor(Math.random() * listCustomerCode.length)
                ];

            transList.push([time, _type, cusCode, amount]);
        }

        let sql;

        sql =
            'INSERT INTO ACCT_TRANSACTION(acct_trans_date, acct_trans_type, cus_code, acct_trans_amount)  VALUES ?';

        connectDatabase.query(sql, [transList], function (err, result) {
            if (err) throw err;
            console.log(
                `Inserted into ACCT_TRANSACTION - database: ${process.env.DB_NAME}`,
            );
            console.log('Number of records inserted: ' + result.affectedRows);
        });
    });
};

export default insertTransaction;
