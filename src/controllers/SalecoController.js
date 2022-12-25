import { connectDatabase, queryDatabase } from '../models/index.js';

const LIMIT_DEFAULT = 20;

class SalecoController {
    // [GET] saleco/allUser
    async getAllUser(req, res) {
        const sql = `SELECT * FROM CUSTOMER`;
        const data = await queryDatabase(connectDatabase, sql);
        res.json({
            status: 'success',
            data: data,
        });
    }

    // [GET] saleco/allProduct
    async getAllProduct(req, res) {
        const sql = `SELECT * FROM PRODUCT`;
        const data = await queryDatabase(connectDatabase, sql);
        res.json({
            status: 'success',
            data: data,
        });
    }

    // [GET] saleco/productList
    async getProductList(req, res) {
        const { page, limit } = req.query;
        const _page = page ? page : 1;
        const _limit = limit ? limit : LIMIT_DEFAULT;

        const sql = `SELECT * FROM PRODUCT LIMIT ${(_page - 1) * _limit},${
            _page * _limit
        }`;
        const data = await queryDatabase(connectDatabase, sql);
        res.json({
            status: 'success',
            data: data,
        });
    }

    // [GET] saleco/allInvoice
    async getAllInvoice(req, res) {
        const sql = `SELECT * FROM INVOICE`;
        const data = await queryDatabase(connectDatabase, sql);
        res.json({
            status: 'success',
            data: data,
        });
    }
}

export { SalecoController };
