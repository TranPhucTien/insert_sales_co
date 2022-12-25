import axios from 'axios';
import { connectDatabase } from '../models/index.js';

const INVOICE_API = 'http://localhost:5001/api/saleco/allInvoice';
const PRODUCT_API = 'http://localhost:5001/api/saleco/allProduct';

const insertLine = ({ numberOfRecodes = 1000 }) => {
    connectDatabase.connect(async function () {
        const lineList = [];
        const listProductCode = [];
        const listInvCode = [];

        const responseInvoice = await axios.get(INVOICE_API);
        responseInvoice.data.data.forEach((item) =>
            listInvCode.push(item.inv_number),
        );

        const responseProduct = await axios.get(PRODUCT_API);
        responseProduct.data.data.forEach((item) =>
            listProductCode.push(item.p_code),
        );

        const random = (length) => {
            return Math.floor(Math.random() * length);
        };

        const lengthInvoice = listInvCode.length;
        const lengthProduct = listProductCode.length;

        for (let i = 1; i <= numberOfRecodes; i++) {
            console.log(`----------${i}/${numberOfRecodes}------------`);
            const invNumber = listInvCode[random(lengthInvoice)];
            const productCode = listProductCode[random(lengthProduct)];
            const lineUnit = Math.floor(Math.random() * 5) + 1;
            const linePrice = Number((Math.random() * 200).toFixed(2) + 1);
            const total = lineUnit * linePrice;

            lineList.push([invNumber, productCode, lineUnit, linePrice, total]);
        }

        let sql;

        sql =
            'INSERT INTO LINE(inv_number, p_code, line_units, line_price, line_total) VALUES ?';

        connectDatabase.query(sql, [lineList], function (err, result) {
            if (err) throw err;
            console.log(
                `Inserted into LINE - database: ${process.env.DB_NAME}`,
            );

            console.log('Number of records inserted: ' + result.affectedRows);
        });
    });
};

export default insertLine;
