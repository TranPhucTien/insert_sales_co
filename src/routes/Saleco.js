import express from 'express';
import { SalecoController } from '../controllers/SalecoController.js';

const router = express.Router();
const salecoController = new SalecoController();

router.get('/allProduct', salecoController.getAllProduct);
router.get('/productList', salecoController.getProductList);
router.get('/allUser', salecoController.getAllUser);
router.get('/allInvoice', salecoController.getAllInvoice);

export default router;
