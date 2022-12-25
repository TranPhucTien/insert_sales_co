import axios from 'axios';
import { connectDatabase } from '../models/index.js';
import { randomFiveCharacter, randomDate } from '../constant.js';

const USER_API = 'http://localhost:5001/api/saleco/allUser';

const insertInvoice = ({ numberOfRecords = 1000 }) => {
    connectDatabase.connect(async function () {
        const invoiceList = [];
        const listCusCode = [];
        const type = ['cc', 'cash', 'cred', 'chk'];

        const response = await axios.get(`${USER_API}`);
        response.data.data.forEach((item) => listCusCode.push(item.cus_code));

        for (let i = 1; i <= numberOfRecords; i++) {
            console.log(`----------${i}/${numberOfRecords}------------`);
            const randomBool = Boolean(Math.round(Math.random()));

            const id =
                randomFiveCharacter() +
                randomFiveCharacter() +
                randomFiveCharacter();
            const time = randomDate(new Date(2012, 0, 1), new Date());
            const _type = type[Math.floor(Math.random() * type.length)];
            const subtotal = Number((Math.random() * 1000 + 1).toFixed(2));
            const tax = Number((Math.random() * 10).toFixed(2));
            const shippingCost = Number((Math.random() * 50).toFixed(2));
            const total = Number(
                (subtotal * ((tax + 100) / 100) + shippingCost).toFixed(2),
            );
            const payAmount =
                randomBool === true
                    ? total
                    : Number((Math.random() * 50).toFixed(2));
            const balance = Math.abs(total - payAmount);
            const cusCode =
                listCusCode[Math.floor(Math.random() * listCusCode.length)];

            invoiceList.push([
                id,
                time,
                _type,
                subtotal,
                tax,
                shippingCost,
                total,
                payAmount,
                balance,
                cusCode,
            ]);
        }

        let sql;

        sql =
            'INSERT INTO INVOICE(inv_number, inv_date, inv_pay_type, inv_subtotal, inv_tax, inv_shipping_cost, inv_total, inv_pay_amount, inv_balance, cus_code)  VALUES ?';

        connectDatabase.query(sql, [invoiceList], function (err, result) {
            if (err) throw err;
            console.log(
                `Inserted into INVOICE - database: ${process.env.DB_NAME}`,
            );
            console.log('Number of records inserted: ' + result.affectedRows);
        });
    });
};

export default insertInvoice;
