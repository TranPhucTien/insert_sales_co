import axios from 'axios';
import { connectDatabase } from '../models/index.js';

const PRODUCT_LIST_URL = 'http://localhost:5000/api/list';

const insertProduct = ({ name = 'laptop', vendorCode = 1 }) => {
    connectDatabase.connect(async function (err) {
        const data = await axios.get(`${PRODUCT_LIST_URL}?name=${name}&page=1`);
        const totalPagination = data.data.totalPagination;

        const promises = [];
        const products = [];

        console.log(`inserting ${name}...`);

        for (let i = 1; i <= totalPagination; i++) {
            promises.push(
                await axios
                    .get(`${PRODUCT_LIST_URL}?name=${name}&page=${i}`)
                    .then((response) => {
                        console.log(`-------${i}/${totalPagination}---------`);

                        const values = [
                            ...response.data.productList.map((field) => {
                                const price =
                                    Number(field.price.slice(1)) || 100;
                                const limitName = field.name.slice(0, 200);
                                const discount = Number(
                                    (Math.random() * 20).toFixed(2),
                                );

                                return [
                                    field.id,
                                    limitName,
                                    price,
                                    field.desc,
                                    field.date,
                                    field.qoh,
                                    field.reorder,
                                    vendorCode,
                                    discount,
                                ];
                            }),
                        ];
                        products.push(...values);
                    }),
            );
        }

        Promise.all(promises).then(() => {
            console.log(`total: ${products.length}`);

            let sql;

            sql =
                'INSERT INTO PRODUCT(p_code, p_name, p_price, p_desc, p_indate, p_qoh, p_reorder, v_code, p_discount) VALUES ?';

            connectDatabase.query(sql, [products], function (err, result) {
                if (err) throw err;
                console.log(
                    `Inserted into PRODUCT - database: ${process.env.DB_NAME}`,
                );
                console.log(
                    'Number of records inserted: ' + result.affectedRows,
                );
            });
        });
    });
};

export default insertProduct;
